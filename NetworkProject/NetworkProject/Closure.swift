//
//  Closure.swift
//  NetworkProject
//
//  Created by zsm on 11/22/23.
//

import SwiftUI

struct Closure: View {
    
    var sayHi: (String) -> () = { name in
        print("\(name) Hi")
    }
    
    var body: some View {
        VStack {
            Text("")
            Button {
                //sayHello(name: "zs"), action: { print("good night") }
                sayHello(with: "url") { data, response, error in
                    print("\(data)", "\(response)", "\(error)")
                }
                //sayHi("zs2")
            } label: {
                Text("Touch")
            }

        }
    }
    
    func sayHello(with name: String, action: (String, String, String) -> ()) {
        print("\(name) hello")
        action("test1","test2","test3")
    }
}

#Preview {
    Closure()
}
