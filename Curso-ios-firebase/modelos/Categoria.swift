//
//  Gasto.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 2/3/26.
//

import SwiftUI
import FirebaseFirestore

// Modelo de Categoria que reemplazará al Enum antiguo
struct Categoria: Codable, Identifiable , Hashable{
  
    
    @DocumentID var id: String?
    var nombre : String
    var icono: String
    var nombreColor: String
    
    var idUsuario: String // las categorías son únicas por usuario por eso van asociadas al usuario
    
    enum CodingKeys: String, CodingKey {
        case id
        case nombre = "nombre"
        case icono = "icon"
        case nombreColor = "nombreColor"
        case idUsuario
    }
    
}

// helper
extension Color {
    static func fromstring(_ color: String) -> Color {
        switch color {
        case "red":
            return .red
        case "blue":
            return .blue
        case "yellow":
            return .yellow
        case "green":
            return .green
        case "orange":
            return .orange
        case "pink":
            return .pink
        case "purple":
            return .purple
        default:
            return .gray
        }
    }
}

