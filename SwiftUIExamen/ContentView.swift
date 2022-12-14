//
//  ContentView.swift
//  SwiftUIExamen
//
//  Created by CCDM30 on 29/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let coreDM: CoreDataManager
    @State var clv_obraViga = ""
    @State var clv_vigaViga = ""
    @State var materialViga = ""
    @State var longitudViga = ""
    @State var pesoViga = ""
    @State var editar = false
    @State var clvO = ""
    @State var clvV = ""
    @State var mate = ""
    @State var longi = ""
    @State var pes = ""
    @State var list = [Viga]()
    var body: some View {
        VStack{
            TabView{
                NavigationView{
                    List{
                        ForEach(list, id: \.self){
                            vi in
                            HStack{
                                Image(systemName: "gear")
                                Text(vi.clv_viga ?? "" )
                            }
                            .swipeActions{
                                Button(action: {
                                    let viga = vi
                                    borrarVigas(viga: viga)
                                }){
                                    Text("Eliminar")
                                }.tint(.red)
                                
                                Button(action: {
                                    clvO = vi.clv_obra ?? ""
                                    clvV = vi.clv_viga ?? ""
                                    mate = vi.material ?? ""
                                    longi = vi.longitud ?? ""
                                    pes = vi.peso ?? ""
                                    editar = true
                                }){
                                    Text("Editar")
                                }.tint(.blue)
                            }
                            NavigationLink(destination: ViewEditar(coreDM: coreDM, clvO: $clvO, clvV: $clvV, materialV: $mate, longitudV: $longi, pesoV: $pes), isActive: $editar){
                                Text("")
                            }.hidden()
                        }
                    }
                }
                .tabItem{
                    Label("Datos", systemImage: "list.dash")
                }
                
                VStack{
                    TextField("Calve de obra", text: $clv_obraViga)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.telephoneNumber)
                    Spacer()
                    TextField("Clave de viga", text: $clv_vigaViga)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.telephoneNumber)
                    Spacer()
                    TextField("Material", text: $materialViga)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.telephoneNumber)
                    Spacer()
                    TextField("Longitud", text: $longitudViga)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.telephoneNumber)
                    Spacer()
                    TextField("Peso", text: $pesoViga)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.telephoneNumber)
                    Button("Guardar"){
                        coreDM.guardarViga(clv_obra: clv_obraViga, clv_viga: clv_vigaViga, material: materialViga, longitud: longitudViga, peso: pesoViga)
                        obtenerVigas()
                        clv_obraViga = ""
                        clv_vigaViga = ""
                        materialViga = ""
                        longitudViga = ""
                        pesoViga = ""
                    }
                }
                
                .tabItem{
                    Label("Agregar", systemImage: "square.and.pencil")
                }
            }
        }.onAppear(perform: {
            obtenerVigas()
        })
    }
    
    func obtenerVigas(){
        list = coreDM.obtenerVigas()
    }

    func borrarVigas(viga:Viga){
        coreDM.borrarVigas(viga: viga)
        obtenerVigas()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
