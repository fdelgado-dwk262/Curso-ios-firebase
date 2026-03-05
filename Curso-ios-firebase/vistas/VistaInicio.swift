//
//  VistaInicio.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 5/3/26.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct VistaInicio: View {
    
    @State private var manager = AuthManager()
    var authManager: AuthManager
    
    var body: some View {
        TabView {
            VistaGastos(authManager: manager)
                .tabItem {
                    Label("Gastos", systemImage: "list.bullet")
                }
                .tag(0)
//            Text("Categoria")
            VistaCategorias(authManager: manager)
                .tabItem {
                    Label("Categorías", systemImage: "bookmark")
                }
                .tag(1)
        }
    }
}

#Preview {
    VistaInicio(authManager: AuthManager())
}
