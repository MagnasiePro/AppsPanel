//
//  newsView.swift
//  AppsPanel
//
//  Created by Camille Maurel on 15/06/2021.
//

import SwiftUI

extension Image {
    func data(url:URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self
            .resizable()
    }
}

struct newsView: View {
    
    @State var news: [News] = []
    let formatter = DateFormatter()
    @State var isLoaded = false
    @State private var showingSheet = false
    
    init() {
        formatter.timeStyle = .long
    }
    
    func getDate(date: Int) -> Text {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: Date(timeIntervalSince1970: TimeInterval(date)))
        let diff = calendar.dateComponents([.day], from: date1, to: date2).day
        
        switch diff {
        case 0:
            return Text("today")
        case -1:
            return Text("yesterday")
        case .some(_):
            return Text(NSLocalizedString("since", comment: "") + "\(diff! * -1)" + NSLocalizedString("days", comment: ""))
        case .none:
            break
        }
        return Text("")
    }
    
    var body: some View {
        List(news.sorted { $0.published_at > $1.published_at}) { newsUnit in
            HStack {
                Image("https://via.placeholder.com/150")
                    .data(url: URL(string: newsUnit.picture_url ?? "https://via.placeholder.com/150")!)
                    .resizable()
                    .frame(width: 100.0, height: 100.0)
                VStack(alignment: .leading) {
                    Text(newsUnit.title)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    Text(newsUnit.description)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    getDate(date: newsUnit.published_at)
                }
            }
            .gesture(TapGesture()
                        .onEnded({ _ in
                            showingSheet = true
                        }))
            .sheet(isPresented: $showingSheet) {
                Image("https://via.placeholder.com/150")
                    .data(url: URL(string: newsUnit.picture_url ?? "https://via.placeholder.com/150")!)
            }
        }
        .onAppear() {
            if (isLoaded == false) {
                apiCall().getNews { data in
                    self.news = data
                    isLoaded = true
                }
            }
        }
    }
}

struct newsView_Previews: PreviewProvider {
    static var previews: some View {
        newsView()
    }
}
