//
//  VistaGastos.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 2/3/26.
//

import Firebase
import SwiftUI

// TODO: viewmodel temporal para ver que se implementa con un Mock
@Observable
class GastosViewModelMock: GastosViewModelProtocol {
    var gastos: [Gasto]
    private var idUsuario: String

    init(idUsuario: String, gastos: [Gasto] = []) {
        self.idUsuario = idUsuario
        self.gastos = gastos
        
        // creamos un gasto de pruebas paramostrar
        let gasto = Gasto(titulo: "demo", importe: 23.00, fecha: Date(), idUsuario: "asdfwqr34t5w3af")
        self.gastos.append(gasto)
    }

    func escucharDatos() {
        // se queda vacia
    }

    func anadirGasto(titulo: String, importe: Double) {
        let gasto = Gasto(
            titulo: titulo,
            importe: importe,
            fecha: Date(),
            idUsuario: idUsuario
        )
        gastos.append(gasto)
    }

}

struct VistaGastos: View {
    // puede coger cualquiera de los protocoloes o el Mock que extiende de o el original
    @State private var viewModel: any GastosViewModelProtocol
    
    @State private var mostrarAnadir: Bool = false
    
    init(idUsuario: String) {
        // comentamos o no la que corresponda :
        
        // MOCK
//        _viewModel = State(initialValue: GastosViewModelMock(idUsuario: idUsuario))
        
        // Datos firebase
        _viewModel = State(initialValue: GastosViewModel(idUsuario: idUsuario))
    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.gastos) { gasto in
                //
                HStack {
                    VStack(alignment: .leading) {
                        Text(gasto.titulo)
                            .font(.headline)
                        Text(gasto.fecha, style: .date)
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        
                    }
                    Spacer()
                    Text(gasto.importe, format: .currency(code: "Eur"))
                        .font(.subheadline)
                        .foregroundStyle((gasto.importe >= 0) ? Color.red : Color.green)
                }
            }
            .navigationTitle("Mis Gastos")
            .toolbar {
                Button {
                    mostrarAnadir.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            .sheet(isPresented: $mostrarAnadir) {
               VistaAnadirGasto(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    
    VistaGastos(idUsuario: "asdfeteq4t5w3af")
}
