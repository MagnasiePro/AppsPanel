//
//  ContentView.swift
//  AppsPanel
//
//  Created by Camille Maurel on 15/06/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            registerView()
                .tabItem {
                    Image(systemName: "person.badge.plus")
                    Text("register")
                }.tag(1)
            newsView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("news")
                }.tag(2)
            infoView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("infos")
                }.tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
