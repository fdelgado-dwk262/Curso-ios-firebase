//
//  VistaGastos.swift
//  Curso-ios-firebase
//
//  Created by Equipo 9 on 2/3/26.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct VistaGastos: View {
    
    // para el tema del logout
    var authManager: AuthManager
    
    @State private var viewModel: GastosViewModel
    
    @State private var mostrarAnadir: Bool = false
    
    @State private var gastoEditable: Gasto?
    
    init(authManager: AuthManager) {
            self.authManager = authManager
            let idUsuario = authManager.user?.uid ?? ""
            
        // Datos firebase
        _viewModel = State(initialValue: GastosViewModel(idUsuario: idUsuario))
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Resumen") {
                    HStack {
                        Text("Total gastado")
                        Spacer()
                        Text(viewModel.importeTotal, format: .currency(code: "Eur"))
                    }
                }
                Section("Movimientos") {
                    ForEach(viewModel.gastos) { gasto in
                        
                        HStack {
                            
                            // nuestro gasto puede o no tener una categoria
                            if let categoria = viewModel.obtenerCategorias(id: gasto.idCategoria) {
                                VStack {
                                    Image(systemName: categoria.icono)
                                        .foregroundStyle(Color.fromString(categoria.nombreColor))
                                        .font(.title2)
                                        .clipShape(Circle())
                                    Text(categoria.nombre)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            } else {
                                // se borrra la categoria pero el gasto existe
                                VStack {
                                    Image(systemName: "questionmark.circle")
                                    Text("Sin categoria")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            
                            
                            VStack(alignment: .leading) {
                                Text(gasto.titulo)
                                    .font(.headline)
                                Text(gasto.fecha, style: .date)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                
                                
                            }
                            Spacer()
                            Text(gasto.importe, format: .currency(code: "Eur"))
                                .font(.subheadline)
                                .foregroundStyle((gasto.importe >= 0) ? Color.red : Color.green)
                        }
                        .contentShape(Rectangle()) // hacemos que la fila entera sea clickeable (HACK)
                        .onTapGesture {
                            // al tocar el gasto ester
                            gastoEditable = gasto
                        }
                    }
                    // el por debajo sabe lo que debe de hacer y pasando parametros por debajo ??
                    .onDelete(perform: viewModel.borrarGasto)
                }
            }
            
            .navigationTitle("Mis Gastos")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        authManager.logout()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundStyle(.red)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        mostrarAnadir.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
            }
            
            .sheet(isPresented: $mostrarAnadir) {
               VistaAnadirGasto(viewModel: viewModel)
            }
            // abrimos otro sheet para editar si gastoEditable tiene algo lanza esta sheet
            .sheet(item: $gastoEditable) { gasto in
                VistaAnadirGasto(viewModel: viewModel, gastoEditable: gasto)
            }
        }
    }
}


// la comentamos ya que nos da problemas y no es necesaria
// ya que llenaríuamos el código con cosas innecesarias
//#Preview {
//    VistaGastos(idUsuario: "asdfeteq4t5w3af")
//}
