//
//  ContentView.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 2/3/26.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var manager = AuthManager()
    
    
    var body: some View {
        Group {
//            if manager.user != nil {
//                VistaPrincipal(authManager: manager)
            if let user = manager.user {
                VistaGastos(idUsuario: user.uid)
            } else {
                VistaLogin(authManager: manager)
            }
        }
    }
}

#Preview {
    ContentView()
}
