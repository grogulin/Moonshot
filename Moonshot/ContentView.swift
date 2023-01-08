//
//  ContentView.swift
//  Moonshot
//
//  Created by Ярослав Грогуль on 08.01.2023.
//

import SwiftUI

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
    var body: some View {
//        GeometryReader { geo in
//            Image("example2")
//                .resizable()
//                .scaledToFit()
//                .frame(width: geo.size.width * 0.9)
//                .frame(width: geo.size.width, height: geo.size.height)
//        }
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(0..<13) {num in
                    switch num {
                    case 0..<10:
                        Text("\(10-num)")
                            .font(.system(size:400, weight: .heavy))
                    case 10:
                        Text("Ignition...")
                            .font(.system(size:100, weight: .heavy))
                            .rotationEffect(.degrees(270))
                    case 11:
                        Text("Lift Off!")
                            .font(.system(size:100, weight: .heavy))
                            .rotationEffect(.degrees(270))
                    case 12:
                        Text("All systems are good...")
                            .font(.system(size:60, weight: .heavy))
                            .lineLimit(nil)
                            .rotationEffect(.degrees(270))
                            .multilineTextAlignment(.center)
                    default:
                        Text("F*")
                    }
                    
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
