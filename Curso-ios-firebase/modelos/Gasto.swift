//
//  Gasto.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 2/3/26.
//

import Foundation
import FirebaseFirestore

// Modelo de gasto por usuario
struct Gasto: Codable, Identifiable {
    
    // Firestone rellena el DocumentID automáticamente
    @DocumentID var id: String?
    
    var titulo: String
    var importe: Double
    var fecha: Date
    
    var idUsuario: String // necesario para saber de que usuario es el gasto - el de firebase
    
    // necesario para codificar o decodificar
    enum CodingKeys: String, CodingKey {
        case id, titulo, importe, fecha, idUsuario
    }
}
