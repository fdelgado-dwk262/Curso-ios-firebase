//
//  VistaAnadirGasto.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 2/3/26.
//

import SwiftUI

struct VistaAnadirGasto: View {
    @Environment(\.dismiss) private var dismiss
    var viewModel : GastosViewModel
    
    var gastoEditable : Gasto?
    
    @State private var titulo = ""
    @State private var importe: Double = 0.0
    @State private var idCategoriaSeleccionada : String = ""
    
    @State private var mostrarCategorias = false
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Concepto (ej, Comprar Ar-🐐)", text: $titulo)
                TextField("importe", value: $importe, format: .number)
                    .keyboardType(.decimalPad)
                
                Picker("Categoría", selection: $idCategoriaSeleccionada) {
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
                .onAppear {
                    if let gasto = gastoEditable {
                        titulo = gasto.titulo
                        importe = gasto.importe
                        idCategoriaSeleccionada = gasto.idCategoria
                    } else {
                        // Preselecionada la primera categoria si existe
                        if let primera = viewModel.categorias.first, idCategoriaSeleccionada.isEmpty {
                            idCategoriaSeleccionada = primera.id ?? ""
                        }
                    }
                }
            }
            .navigationTitle(gastoEditable == nil ? "Nuevo Gasto: ": "Editar gasto:")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        guardar()
                        dismiss()
                    }
                    .disabled(titulo.isEmpty || importe == 0)
                }

            }
            .sheet(isPresented: $mostrarCategorias) {
                mostrarCategorias = false
            } content : {
                VistaNuevaCategoria(viewModel: viewModel)
            }
        }
    }
    
    func guardar() {
        if var gasto = gastoEditable {
            gasto.titulo = titulo
            gasto.importe = importe
            gasto.idCategoria = idCategoriaSeleccionada
            viewModel.actualizarGasto(gasto)
        } else {
            viewModel.anadirGasto(titulo: titulo, importe: importe, idCategoria: idCategoriaSeleccionada)
        }
    }
}
