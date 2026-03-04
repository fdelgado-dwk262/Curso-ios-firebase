//
//  Gasto.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 2/3/26.
//

import SwiftUI

// Modelo de Categoría del Gasto
enum CategoriaGastos: String, CaseIterable, Codable {
    case comida = "Comida"
    case transporte = "Transporte"
    case ocio = "Ocio"
    case casa = "Casa"
    case sinCategoria = "Sin Categoría"

    var nombreIcono: String {
        switch self {
        case .comida:
            return "food.fill"
        case .transporte:
            return "car.fill"
        case .ocio:
            return "gamecontroller.fill"
        case .casa:
            return "house.fill"
        case .sinCategoria:
            return "questionmark.circle.fill"
        
        }
    }
    var color: Color {
        switch self {
        case .comida:
            return Color.red
        case .transporte:
            return Color.blue
        case .ocio:
            return Color.yellow
        case .casa:
            return Color.green
        case .sinCategoria:
            return Color.gray
        }
    }
}
