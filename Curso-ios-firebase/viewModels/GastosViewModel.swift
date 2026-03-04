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
    var importeTotal: Double { get set }
    
    func escucharDatos()
    func anadirGasto(titulo: String, importe: Double, categoria: CategoriaGastos)
    func borrarGasto(at indices: IndexSet)
}

@Observable
class GastosViewModel: GastosViewModelProtocol {

    var gastos: [Gasto] = []
    var importeTotal: Double = 0.0

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
                
                // calcular el importe total
                //reduce es una funcion deprogramacion funcional
                // $0 contiene el acumulado hasta el momento,
                // $1.importe de un gasto
                // reduce(0) indica que empezamos a acumular a partir de 0 ( el importe total empieza en 0)
                // el reduce hace lo siguiente .-
                /*
                 Partimos de una array  [2,5,-1,0,4]
                 compactamos el array a un solo valor y partimo del valor 0
                 el $0 es el valor acumulado que empieza a 0
                 
                 $1 .- es el valor que esta en la lista
                 y empezamos con el tema .-
                 $0 es 0 y $1 .- el rimer elemento de la lista
                 y vamos sumando cada elemento
                 
                 $0 .- 0 -> 2 -> 7 -> 6 -> total 10
                 $1 .- 2 -> 5 -> -1 -> 0 -> 4
                 
                 
                $0 .- 0 y $1 .- 2 (array 0)
                $0 .- 2 + $1 = 2 y $1 .- 5 (array 1)
                $0 .- 5 + $1 = 7 y $1 .- -1 (array 2)
                $0 .- 7 + $1 = 6 y $1 .- 0 (array 3)
                $0 .- 6 + $1 y $1 = 6 .- 4 (array 4)
                $0 .- 6 + $1 = 10 <---- acumulado
                
                 
                 
                 */
                self.importeTotal = self.gastos.reduce(0) { $0 + $1.importe }
            }
    }

    func anadirGasto(titulo: String, importe: Double, categoria: CategoriaGastos) {
        // añadimos un gasto en la base de datos ( firebase )
        let nuevoGasto = Gasto(
            titulo: titulo,
            importe: importe,
            fecha: Date(),
            categoria: categoria,
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
    
    // borrado de indices de una lista  IndexSet es un struct
    // no es untipo de datos pero funciona como es similar a un array de  [int]
    // es una srtruc que esta en la librería que por debajo hace muchas mas cosas
    func borrarGasto(at indices: IndexSet) {
        indices.forEach { indice in
            let gasto = gastos[indice]
            
            guard let idGasto = gasto.id else { return }
            
            // borramos los indices y comprobamos si hay error
            db.collection(ConstantesFirestore.coleccionGastos).document(idGasto).delete { error in
                if let error {
                    print("Error al borrar: \(error.localizedDescription)")
                }
            }
        }
        
    }
}
