//
//  apiCalls.swift
//  AppsPanel
//
//  Created by Camille Maurel on 15/06/2021.
//

import Foundation

struct News: Codable, Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let latitude: Double
    let longitude: Double
    let picture_url: String?
    let published_at: Int
}

class apiCall {
    let url = "https://test-pgt-dev.apnl.ws"
    let X_AP_DeviceUID = "Documentation"
    let X_AP_Key = "uD4Muli8nO6nzkSlsNM3d1Pm"
    let language = "fr-FR"

    func registerUser(name: String, email: String, phone: String, completion: @escaping (Bool) -> ()) {
        let url = URL(string: url + "/authentication/register")!
        var request = URLRequest(url: url)
        
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(language, forHTTPHeaderField: "Accept-Language")
        request.setValue(X_AP_Key, forHTTPHeaderField: "X-AP-Key")
        request.setValue(X_AP_DeviceUID, forHTTPHeaderField: "X-AP-DeviceUID")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["name": name, "email": email, "phone": phone]
        let bodyData = try? JSONSerialization.data(
            withJSONObject: body,
            options: []
        )
        
        request.httpMethod = "POST"
        request.httpBody = bodyData
        
        let session = URLSession.shared
        print("Submit regitration")
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR")
                print(error)
                completion(false)
            } else if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if (json.first?.key == "success") {
                            print("Sucessfully register")
                            completion(true)
                        } else {
                            print("Error register")
                            completion(false)
                        }
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                    completion(false)
                }
            } else {
                print("ERROR")
                print(error as Any)
                completion(false)
            }
        }.resume()
    }
    
    func getNews(completion:@escaping ([News]) -> ()) {
        let url = URL(string: url + "/events")!
        var request = URLRequest(url: url)

        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(language, forHTTPHeaderField: "Accept-Language")
        request.setValue(X_AP_Key, forHTTPHeaderField: "X-AP-Key")
        request.setValue(X_AP_DeviceUID, forHTTPHeaderField: "X-AP-DeviceUID")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, _, _) in
            let users = try! JSONDecoder().decode([News].self, from: data!)
            
            DispatchQueue.main.async {
                completion(users)
            }
        }
        .resume()
    }
    
}
