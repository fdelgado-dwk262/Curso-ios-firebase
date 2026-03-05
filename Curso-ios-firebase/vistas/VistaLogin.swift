//
//  VistaLogin.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 2/3/26.
//



import SwiftUI

struct VistaLogin: View {
    @Bindable var authManager: AuthManager
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var seEstaRegistrando = false // ¿Registrando o haciendo login?
    @State private var logeando = false
    @State private var mensajeError: String?
    
    var body: some View {
        VStack(spacing:20){
            Text(seEstaRegistrando ? "Crear Cuenta" : "Bienvenido/a")
                .font(.largeTitle)
                .bold()
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
            
            SecureField("Contraseña", text: $password)
                .textFieldStyle(.roundedBorder)
            
            if let mensajeError {
                Text(mensajeError)
                    .foregroundStyle(.red)
                    .font(.caption)
            }
            
            // botom de inicio sesión
            Button {
                logeando = true
                Task {
                    await autenticar()
                }
            } label: {
                    Text(seEstaRegistrando ? "Registrarse" : "Iniciar Sesión")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            // desabilidatendo el boton según caso y cambiamos el estilo
            .disabled(email.isEmpty || password.isEmpty || logeando)
            .opacity(email.isEmpty || password.isEmpty || logeando ? 0.5 : 1.0)
            
            // boton que si tienes vunta entra si no registrate
            Button {
                seEstaRegistrando.toggle()
                mensajeError = nil
            } label: {
                Text( seEstaRegistrando ? "¿Ya tienes una cuenta?" : "¿No tienes cuenta? Registrate ahora!")
                    .foregroundStyle(.blue)
            }
        }
        .padding()
    }
    
    func autenticar() async {
        do {
            if seEstaRegistrando {
                try await authManager.register(email: email, pass: password)
            } else {
                try await authManager.login(email: email, pass: password)
            }
            
            logeando = false
        } catch {
            mensajeError = error.localizedDescription
            logeando = false
        }
    }
}

//#Preview {
//    VistaLogin()
//}
