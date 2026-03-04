//
//  VistaGastos.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 2/3/26.
//

import SwiftUI
import Firebase
import FirebaseAuth

// TODO: viewmodel temporal para ver que se implementa con un Mock
@Observable
class GastosViewModelMock: GastosViewModelProtocol {
    var gastos: [Gasto]
    var importeTotal: Double = 15.0
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

    func anadirGasto(titulo: String, importe: Double, categoria: CategoriaGastos) {
        let gasto = Gasto(
            titulo: titulo,
            importe: importe,
            fecha: Date(),
            categoria: categoria,
            idUsuario: idUsuario
        )
        gastos.append(gasto)
    }
    
    func borrarGasto(at indices: IndexSet) {}

}

struct VistaGastos: View {
    
    // para el tema del logout
    var authManager: AuthManager
    
    // puede coger cualquiera de los protocoloes o el Mock que extiende de o el original
    @State private var viewModel: any GastosViewModelProtocol
    
    @State private var mostrarAnadir: Bool = false
    
    // reemplezamos el is usuario por authManager
//    init(idUsuario: String) {
        init(authManager: AuthManager) {
            self.authManager = authManager
            let idUsuario = authManager.user?.uid ?? ""
            
        // comentamos o no la que corresponda :
        
        // MOCK
//        _viewModel = State(initialValue: GastosViewModelMock(idUsuario: idUsuario))
        
        // Datos firebase
        _viewModel = State(initialValue: GastosViewModel(idUsuario: idUsuario))
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Resumen") {
                    HStack {
                        Text("Total gastado")
                        Spacer()
                        Text(viewModel.importeTotal, format: .currency(code: "Eur"))
                    }
                }
                Section("Movimientos") {
                    ForEach(viewModel.gastos) { gasto in
                        
                        HStack {
                            
                            Image(systemName: gasto.categoria.nombreIcono)
                                .font(.title2)
                                .frame(width: 40, height: 40)
                                .background(gasto.categoria.color.opacity(0.2))
                                .foregroundStyle(gasto.categoria.color)
                                .clipShape(Circle())
                            
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
                    // el por debajo sabe lo que debe de hacer y pasando parametros por debajo ??
                    .onDelete(perform: viewModel.borrarGasto)
                }
            }
            
            .navigationTitle("Mis Gastos")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        authManager.logout()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundStyle(.red)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        mostrarAnadir.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
            }
            
            .sheet(isPresented: $mostrarAnadir) {
               VistaAnadirGasto(viewModel: viewModel)
            }
        }
    }
}


// la comentamos ya que nos da problemas y no es necesaria
// ya que llenaríuamos el código con cosas innecesarias
//#Preview {
//    VistaGastos(idUsuario: "asdfeteq4t5w3af")
//}
