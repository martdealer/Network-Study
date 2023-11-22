//
//  ContentView.swift
//  NetworkProject
//
//  Created by zsm on 11/22/23.
//

import SwiftUI

struct Post: Decodable {
    let id: Int
    let title, content, createdAt, updatedAt: String
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, content, createdAt, updatedAt
        case userID = "UserId"
    }
}

struct User: Decodable {
    let id: Int
    let name, username, email, phone: String
    let website, province, city, district, street, zipcode: String
    let createdAt, updatedAt: String
}

struct ContentView: View {
    
    @State var posts: [String] = ["zs", "ok"]
    @State var users: [String] = ["user1", "user2"]

    
    var body: some View {
        VStack {
            List {
                ForEach(posts, id: \.self) { item in
                    Text(item)
                }
                ForEach(users, id: \.self) { item in
                    Text(item)
                }
            }
            Button {
                requestPost()
            } label: {
                Text("Request Post")
            }
            Button {
                requestUser()
            } label: {
                Text("Requesst User")
            }
        }
    }
    
    private func requestPost() {
        requestPost { post, error in
            guard let post = post else {
                print(error)
                return
            }
            
            posts.append(post.title)
        }
    }
    
    private func requestUser() {
        requestUser { user, error in
            guard let user = user else {
                print(error)
                return
            }
            
            users.append(user.name ?? "ErrorName")
        }
    }
    
    
    func requestPost(completed: @escaping (Post?, String?) -> ()) {
        let endPoint = "https://koreanjson.com/posts/1"

        
        guard let url = URL(string: endPoint) else {
            completed(nil, "!@!@ INVALID URL")
            return
        }
        
        // url을 보내고 , d-r-e를 받아서 처리할 수 있는 함수를 보냄
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
                let decodedResponse = try JSONDecoder().decode(Post.self,
                                                               from: data)
                //data.append(decodedResponse.title)
                completed(decodedResponse, nil)
            } catch {
                print(error)
            }
            
            
        }.resume()
    }
    
    func requestUser(completed: @escaping (User?, String?) -> ()) {
        let endPoint = "https://koreanjson.com/users/1"

        
        guard let url = URL(string: endPoint) else {
            completed(nil, "!@!@ INVALID URL")
            return
        }
        
        // url을 보내고 , d-r-e를 받아서 처리할 수 있는 함수를 보냄
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
                let decodedResponse = try JSONDecoder().decode(User.self,
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
