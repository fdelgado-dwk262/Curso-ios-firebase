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
            if manager.user != nil {
//                VistaPrincipal(authManager: manager)
//            if let user = manager.user {
                // como queremos cerrar sesión necesitamos un logout y modificamos la linea
//                VistaGastos(idUsuario: user.uid)
//                VistaGastos(authManager: manager)
                VistaInicio(authManager: manager)
            } else {
                VistaLogin(authManager: manager)
            }
        }
    }
}

#Preview {
    ContentView()
}


// TODO: cosas que faltan
// * falta una vista de listado de categorias
// * falta un ontap gesture en las catagorías para borrar y que llame a la funcion de borrado en cascada
