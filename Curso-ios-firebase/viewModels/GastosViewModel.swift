//
//  GastosViewModel.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 2/3/26.
//

import FirebaseFirestore
import Foundation

enum ConstantesFirestore {

    // Nomnbre de la tabla
    static let coleccionGastos: String = "gastos"

}

// TODO: Temporal
protocol GastosViewModelProtocol: Observable {
    var gastos: [Gasto] { get set }
    func escucharDatos()
    func anadirGasto(titulo: String, importe: Double)
}

@Observable
class GastosViewModel: GastosViewModelProtocol {

    var gastos: [Gasto] = []

    private var db = Firestore.firestore()

    private var idUsuario: String
    init(idUsuario: String) {
        self.idUsuario = idUsuario
        escucharDatos()
    }

    func escucharDatos() {
        // Callback que escucha a la base de datos para actualizar los datos del usuario

        // Conculta a "Gastos",en firestone, usando el id del usuario
        db.collection(ConstantesFirestore.coleccionGastos)
            .whereField(
                Gasto.CodingKeys.idUsuario.rawValue,
                isEqualTo: idUsuario
            )
            .order(by: Gasto.CodingKeys.fecha.rawValue, descending: true)
            // esciucha los cambios
            .addSnapshotListener { snaphost, error in
                guard let documents = snaphost?.documents else {
                    print(
                        "Error al leer los documentos: \(error?.localizedDescription ?? "Error Desconocido")"
                    )
                    return
                }
                // Mapeo: del documento firestore al array de Gastos
                // necsita un sefgt por que esta dentro de un closure
                
                self.gastos = documents.compactMap { doc -> Gasto? in
                    try? doc.data(as: Gasto.self)
                }
            }
    }

    func anadirGasto(titulo: String, importe: Double) {
        // añadimos un gasto en la base de datos ( firebase )
        let nuevoGasto = Gasto(
            titulo: titulo,
            importe: importe,
            fecha: Date(),
            idUsuario: idUsuario
        )

        do {
            // llamamos la base de datos y añade el registro es la forma de persisisti el dato en la nube
            // tb guarda en una "cache" comom un persistencia local y se necesita la funcion de escucharDatos()
            try db.collection(ConstantesFirestore.coleccionGastos).addDocument(
                from: nuevoGasto
            )

        } catch {
            print(
                "Error al guardar en firestore: \(error.localizedDescription)"
            )
        }

    }
}
