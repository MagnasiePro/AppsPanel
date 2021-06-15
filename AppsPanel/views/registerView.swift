//
//  registerView.swift
//  AppsPanel
//
//  Created by Camille Maurel on 15/06/2021.
//

import SwiftUI

struct registerView: View {
    @State private var showActionSheet = false
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    
    var body: some View {
        VStack {
            TextField("name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
            TextField("phone", text: $phone)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.phonePad)
            Button(action: {
                self.showActionSheet = true
            }) {
                Text("register")
            }
            .foregroundColor(.white)
            .padding(.vertical, 10.0)
            .padding(.horizontal, 30.0)
            .background(Color.accentColor)
            .cornerRadius(8)
        }
        .padding(.horizontal)
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(
                title: Text("information-verif"),
                buttons: [
                    .cancel(Text("cancel")) { print(self.showActionSheet) },
                    .default(Text("submit")),
                ]
            )
        }
    }
}

struct registerView_Previews: PreviewProvider {
    static var previews: some View {
        registerView()
    }
}