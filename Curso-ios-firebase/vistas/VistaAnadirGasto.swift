//
//  VistaAnadirGasto.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 2/3/26.
//

import SwiftUI

struct VistaAnadirGasto: View {
    @Environment(\.dismiss) private var dismiss
    var viewModel : any GastosViewModelProtocol
    
    @State private var titulo = ""
    @State private var importe: Double = 0.0
    
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Concepto (ej, Comprar Ar-🐐)", text: $titulo)
                TextField("importe", value: $importe, format: .number)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Nuevo Gasto: ")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        viewModel.anadirGasto(titulo: titulo, importe: importe)
                        dismiss()
                    }
                    .disabled(titulo.isEmpty || importe == 0)
                }
            }
        }
    }
}

#Preview {
    VistaAnadirGasto(viewModel: GastosViewModelMock(idUsuario: "wetwreew"))
}
