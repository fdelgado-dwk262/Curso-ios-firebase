//
//  VistaGastos.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 2/3/26.
//

import Firebase
import FirebaseAuth
import SwiftUI

struct VistaCategorias: View {

    // para el tema del logout
    var authManager: AuthManager

    @State private var viewModel: GastosViewModel
    
    @State private var mostrarAnadir: Bool = false
    
    @State private var categoriaEditable: Categoria?

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
                    // verificamso si hay o no cartegorias
                    if viewModel.categorias.isEmpty {
                        Text("No hay categorías disponibles")
                            .tag("")
                    } else {
                        ForEach(viewModel.categorias) { categoria in
                            HStack {
                                Image(systemName: categoria.icono)
                                    .foregroundStyle(
                                        Color.fromString(categoria.nombreColor)
                                    )
                                Text(categoria.nombre)
                            }
                            .tag(categoria.id ?? "")
                            .contentShape(Rectangle()) // hacemos que la fila entera sea clickeable (HACK)
                            .onTapGesture {
                                // al tocar el gasto ester
                                categoriaEditable = categoria
                            }
                        }
                        .onDelete(perform: viewModel.borrarCategorias)
                    }

                }
                .contentShape(Rectangle())  // hacemos que la fila entera sea clickeable (HACK)
                

            }
            .navigationTitle("Mis Categorías")
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
                        // TODO: vista añadir categoria
                        mostrarAnadir = true
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }

            }
        }
        
        .sheet(isPresented: $mostrarAnadir) {
            mostrarAnadir = false
        } content : {
            VistaNuevaCategoria(viewModel: viewModel)
        }

        
            .sheet(item: $categoriaEditable) { categoria in
                VistaNuevaCategoria(viewModel: viewModel, categoriaEditable: categoria)
            }

    }
}

