//
//  VistaPrincipal.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 2/3/26.
//

import FirebaseAuth
import SwiftUI

struct VistaPrincipal: View {

    var authManager: AuthManager

    var body: some View {
        VStack {

            // para probar que todo va bien .... por el moemnto esto es demo
            Text(
                "Estas dentro ID: \(authManager.user?.uid ?? "no hay usuario") "
            )

            Button("Cerrar Sesion") {
                authManager.logout()
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)

        }
    }
}
