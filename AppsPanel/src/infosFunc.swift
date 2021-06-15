//
//  infosFunc.swift
//  AppsPanel
//
//  Created by Camille Maurel on 15/06/2021.
//

import Foundation

func getContentWebview(completionBlock: @escaping (Data) -> Void) -> Void {
    let url = URL(string: "https://google.com")!

    var request = URLRequest(url: url)

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            completionBlock(data)
        } else if let error = error {
            print("HTTP Request Failed \(error)")
        }
    }.resume()
}
