//
//  infoView.swift
//  AppsPanel
//
//  Created by Camille Maurel on 15/06/2021.
//

import SwiftUI
import WebKit

struct Webview : UIViewRepresentable {
    var request: URLRequest
    var webview: WKWebView?

    init(web: WKWebView?, req: URLRequest) {
        self.webview = WKWebView()
        self.request = req
    }

    class Coordinator: NSObject, WKUIDelegate {
        var parent: Webview

        init(_ parent: Webview) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView  {
        return webview!
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.uiDelegate = context.coordinator
        uiView.load(request)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(String(data: data, encoding: String.Encoding.utf8) as Any)
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }.resume()
    }
}

struct infoView: View {
    var request = URLRequest(url: URL(string: "https://test-pgt-dev.apnl.ws/html")!)

    
    init() {
        request.setValue("Documentation", forHTTPHeaderField: "X-AP-DeviceUID")
        request.setValue("uD4Muli8nO6nzkSlsNM3d1Pm", forHTTPHeaderField: "X-AP-Key")
        request.setValue("text/html", forHTTPHeaderField: "Accept")
        request.setValue("fr-FR", forHTTPHeaderField: "Accept-Language")
    }
    
    var body: some View {
        Webview(web: nil, req: request)
    }
}

struct infoView_Previews: PreviewProvider {
    static var previews: some View {
        infoView()
    }
}
