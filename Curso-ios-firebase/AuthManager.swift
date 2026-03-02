//
//  AuthManager.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 2/3/26.
//

import Foundation
import FirebaseAuth

@Observable
class AuthManager {
    var user: User?
    
    init() {
        // Asigna el usuario si ya hay sesión guardada
        user = Auth.auth().currentUser
    }
    
    // Función para registrar un usuario nuevo
    func register(email: String, pass: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: pass)
        print("Usuario creado")
        user = result.user
    }
    
    func login(email: String, pass: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: pass)
        print("Usuario logeado")
        user = result.user
    }
    
    func logout() {
        try? Auth.auth().signOut()
        user = nil
    }
}
