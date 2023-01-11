//
//  MissionView.swift
//  Moonshot
//
//  Created by Ярослав Грогуль on 10.01.2023.
//

import SwiftUI



struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut

    }
    
    let mission: Mission
    
    var detailsScrollItems : [DetailsScrollView<AstronautView>.item]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.6)
                        .padding(.top)
                        .padding(.bottom, 10)
                    
                    Text("Launch date: \(mission.longFormattedLaunchDate)")
                        .padding(.bottom, 20)
                        .font(.system(size: 16, design: .monospaced))
                    
                    VStack(alignment: .leading) {
                        Text("Mission highlights")
                            .font(.system(size: 25, design: .monospaced).bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                            .padding(.bottom, 10)
                        
                        Text("Crew members")
                            .font(.system(size: 25, design: .monospaced).bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    DetailsScrollView(items: detailsScrollItems)
                }
                .padding(.bottom)
            }
//            .background(.ultraThinMaterial)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(Background(isMainPage: false))
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.detailsScrollItems = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return DetailsScrollView.item(image: astronaut.id, header: astronaut.name, subHeader: member.role) {
                    AstronautView(astronaut: astronaut)
                }
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[5], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
