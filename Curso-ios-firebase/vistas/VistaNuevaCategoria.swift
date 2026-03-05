//
//  VistanuevaCategoria.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 5/3/26.
//

import SwiftUI

struct VistaNuevaCategoria: View {
    @Environment(\.dismiss) var dismiss
    var viewModel: GastosViewModel
    
    @State private var nombre: String = ""
    @State private var iconoSeleccionado: String = "house.fill"
    @State private var colorSeleccionado: String = "blue"
    
    let iconos = ["house.fill", "cart.fill", "heart.fill"]
    let colores = ["red", "blue", "yellow", "green", "orange", "purple", "pink", "gray"]
    
    var body: some View {
        Form {
            TextField("Nombre", text: $nombre)
            
            Picker("Icono", selection: $iconoSeleccionado) {
                ForEach(iconos, id: \.self) { icono in
                    Image(systemName: icono)
                        .tag(icono)
                }
            }
            .pickerStyle(.segmented)
            
            Picker("Color", selection: $colorSeleccionado) {
                ForEach(colores, id: \.self) { color in
                    Text(color.capitalized)
                        .tint(Color.fromString(color))
                        .tag(color)
                }
            }
            .pickerStyle(.segmented)
            
            Button("Crear categoría") {
                viewModel.aniadirCategoria(nombre: nombre, icono: iconoSeleccionado, color: colorSeleccionado)
                dismiss()
            }
            .disabled(nombre.isEmpty)
        }
    }
}
