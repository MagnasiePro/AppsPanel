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
    @State private var showingSuccess = false
    @State private var showingErrorAlert = false
    
    var body: some View {
        VStack {
            TextField("name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.name)
            TextField("email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            TextField("phone", text: $phone)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.phonePad)
                .textContentType(.telephoneNumber)
            Button(action: {
                self.showActionSheet = true
            }) {
                showingSuccess ? Text("success") : Text("register")
            }
            .foregroundColor(.white)
            .padding(.vertical, 10.0)
            .padding(.horizontal, 30.0)
            .background(Color.accentColor)
            .cornerRadius(8)
        }
        .padding(.horizontal)

        .alert(isPresented: $showingErrorAlert) {
            Alert(title: Text("Error"), message: Text("An error has occured"), dismissButton: .default(Text("Ok")))
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(
                title: Text("information-verif"),
                buttons: [
                    .cancel(Text("cancel")) { print(self.showActionSheet) },
                    .default(Text("submit")) {apiCall().registerUser(name: self.name, email: self.email, phone: self.phone) { result in
                        if (result) {
                            showingSuccess = true
                        } else {
                            showingErrorAlert = true
                        }
                    }},
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
