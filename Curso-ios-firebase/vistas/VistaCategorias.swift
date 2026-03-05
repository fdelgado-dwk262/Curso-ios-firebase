//
//  VistaGastos.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 2/3/26.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct VistaCategorias: View {
    
    // para el tema del logout
    var authManager: AuthManager
    
    @State private var viewModel: GastosViewModel
    
    
    init(authManager: AuthManager) {
            self.authManager = authManager
            let idUsuario = authManager.user?.uid ?? ""
            
        // Datos firebase
        _viewModel = State(initialValue: GastosViewModel(idUsuario: idUsuario))
    }
    
    var body: some View {
        NavigationStack {
            List {

                Section("Mis Categorias") {
                    
                        
                        VStack {
                            // verificamso si hay o no cartegorias
                            if viewModel.categorias.isEmpty {
                                Text("No hay categorías disponibles")
                                    .tag("")
                            } else {
                                ForEach(viewModel.categorias) { categoria in
                                    HStack {
                                        Image(systemName: categoria.icono)
                                        Text(categoria.nombre)
                                    }
                                    .tag(categoria.id ?? "")
                                }
                            }
                            
                        }
                        .contentShape(Rectangle()) // hacemos que la fila entera sea clickeable (HACK)
                        .onTapGesture {
                            // al tocar el gasto ester
//                            gastoEditable = gasto
                        }
                    
                    // el por debajo sabe lo que debe de hacer y pasando parametros por debajo ??
//                    .onDelete(perform: viewModel.borrarGasto)
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
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button {
//                        mostrarAnadir.toggle()
//                    } label: {
//                        Image(systemName: "plus")
//                    }
//                }
                
            }
            
//            .sheet(isPresented: $mostrarAnadir) {
//               VistaAnadirGasto(viewModel: viewModel)
//            }
//            // abrimos otro sheet para editar si gastoEditable tiene algo lanza esta sheet
//            .sheet(item: $gastoEditable) { gasto in
//                VistaAnadirGasto(viewModel: viewModel, gastoEditable: gasto)
//            }
        }
    }
}


// la comentamos ya que nos da problemas y no es necesaria
// ya que llenaríuamos el código con cosas innecesarias
//#Preview {
//    VistaGastos(idUsuario: "asdfeteq4t5w3af")
//}
