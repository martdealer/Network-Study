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

let dummyData = """
{
    "id": 1,
    "title": "정당의 목적이나 활동이 민주적 기본질서에 위배될 때에는 정부는 헌법재판소에 그 해산을 제소할 수 있고, 정당은 헌법재판소의 심판에 의하여 해산된다.",
    "content": "모든 국민은 인간으로서의 존엄과 가치를 가지며, 행복을 추구할 권리를 가진다. 모든 국민은 종교의 자유를 가진다. 국가는 농·어민과 중소기업의 자조조직을 육성하여야 하며, 그 자율적 활동과 발전을 보장한다. 모든 국민은 양심의 자유를 가진다. 누구든지 체포 또는 구속을 당한 때에는 즉시 변호인의 조력을 받을 권리를 가진다.",
    "createdAt": "2019-02-24T16:17:47.000Z",
    "updatedAt": "2019-02-24T16:17:47.000Z",
    "UserId": 1
  }
"""

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
                data.append("haha")
            } label: {
                Text("request")
            }
        }
    }
    
    private func requestData() {
        do {
            let decodedResponse = try JSONDecoder().decode(Article.self,
                                                           from: dummyData.data(using: .utf8)!)
            data.append(decodedResponse.title)
        } catch {
            print(error)
        }
    }
}


#Preview {
    ContentView()
}
