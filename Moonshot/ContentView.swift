//
//  ContentView.swift
//  Moonshot
//
//  Created by Ярослав Грогуль on 08.01.2023.
//

import SwiftUI

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct MainView: View {
    
    var body: some View {
        LazyVStack {
            ForEach(0..<100) {
                Text("Row \($0)")
            }
        }
    }
}

struct ContentView: View {
//    let layout = [
//        GridItem(.adaptive(minimum: 80, maximum: 120))
//    ]
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            Text("Detail View")
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .padding()
//                                    .background(.red)
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)

                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.7))
                                    Spacer()
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.thinMaterial)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(.lightBackground)
//                            )
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
//                .background(.darkBackground)
            .preferredColorScheme(.dark)
            .background(
                ZStack {
                    LinearGradient(colors: [.black, .lightBackground], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    GeometryReader { geo in
                        Image("background3")
                            .resizable()
                            .scaledToFit()
                            .rotationEffect(.degrees(180))
                            .frame(width: geo.size.width)
//                            .frame(width: geo.size.width)

                    }
                        .ignoresSafeArea()
                    
                }
                
                
            )
        }
        
//        GeometryReader { geo in
//            Image("example2")
//                .resizable()
//                .scaledToFit()
//                .frame(width: geo.size.width * 0.9)
//                .frame(width: geo.size.width, height: geo.size.height)
//        }
        
//        NavigationView {
//            List(0..<100) { row in
//                NavigationLink {
//                    Text("Detail for row\(row)")
//                } label: {
//                    Text("Row \(row)")
//
//                }
//                .navigationTitle("SwiftUI")
//            }
//
//
//        }
        
//        Button("Decode JSON") {
//            let input = """
//            {
//                "name" : "Taylor Swift",
//                "address" : {
//                    "street" : "555 Taylor Swift Avenue",
//                    "city" : "Nashville"
//                }
//            }
//            """
//            let decoder = JSONDecoder()
//            let data = Data(input.utf8)
//            if let user = try? decoder.decode(User.self, from: data) {
//                print(user.address.city)
//            }
//        }
        
//        ScrollView() {
//            LazyVGrid(columns: layout) {
//                ForEach(0..<1000) {text in
//                    Text("Row \(text)")
//                }
//            }
//        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
