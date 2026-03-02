//
//  Curso_ios_firebaseApp.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 2/3/26.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

      print("🐐🔥 .- firebase configurado .-.🔥🐐")
      
    return true
  }
}

@main
struct Curso_ios_firebaseApp: App {
    
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
