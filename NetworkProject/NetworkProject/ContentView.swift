//
//  ContentView.swift
//  NetworkProject
//
//  Created by zsm on 11/22/23.
//

import SwiftUI

struct Article: Decodable {
    let id: Int
    let title, content, createdAt, updatedAt: String
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, content, createdAt, updatedAt
        case userID = "UserId"
    }
}

struct ContentView: View {
    
    @State var data: [String] = ["zs", "ok"]
    
    var body: some View {
        VStack {
            List {
                ForEach(data, id: \.self) { item in
                    Text(item)
                }
            }
            Button {
                requestData()
            } label: {
                Text("request")
            }
        }
    }
    
    private func requestData() {
        requestArticle { article, error in
            guard let article = article else {
                print(error)
                return
            }
            
            data.append(article.title)
        }
    }
    
    func requestArticle(completed: @escaping (Article?, String?) -> ()) {
        let endPoint = "https://koreanjson.com/posts/1"
        
        guard let url = URL(string: endPoint) else {
            completed(nil, "!@!@ INVALID URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error  {
                completed(nil, "!@!@ ERROR")
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return completed(nil, "!@!@ INVALID RESPONSE")
            }
            
            guard let data = data else {
                return completed(nil, "!@!@ INVALID DATA")
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(Article.self,
                                                               from: data)
                //data.append(decodedResponse.title)
                completed(decodedResponse, nil)
            } catch {
                print(error)
            }
            
            
        }.resume()
    }
}


#Preview {
    ContentView()
}
