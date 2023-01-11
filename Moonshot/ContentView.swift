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

struct Background: View {
    let isMainPage: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, .lightBackground], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            GeometryReader { geo in
                Image("background3")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(180))
                    .frame(width: geo.size.width)
                    .blur(radius: self.isMainPage ? 0 : 20)
            }
            .ignoresSafeArea()
        }
    }
}
    
struct ContentView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingAsList = false
    
    var columns: [GridItem] {
        [
            GridItem(.adaptive(minimum: showingAsList ? .infinity : 150))
        ]
    }
    
    
    
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
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
                                        .font(.headline.monospaced())
                                        .foregroundColor(.white)

                                    Text(mission.formattedLaunchDate)
                                        .font(.caption.monospaced())
                                        .foregroundColor(.white.opacity(0.7))
                                    Spacer()
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.thinMaterial)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .preferredColorScheme(.dark)
            .background(Background(isMainPage: true))
            .toolbar {
                Button {
                    withAnimation {
                        showingAsList.toggle()
                    }
                } label: {
                    Image(systemName: showingAsList ? "square.grid.2x2" : "list.bullet")
                        .foregroundColor(.white)
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
