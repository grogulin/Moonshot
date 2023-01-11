//
//  AstronautView.swift
//  Moonshot
//
//  Created by Ярослав Грогуль on 10.01.2023.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var detailsScrollItems : [DetailsScrollView<MissionView>.item]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 20)
                
                
                Text("Bio")
                    .font(.system(size: 25, design: .monospaced).bold())
                    .padding(.bottom, 10)
                    .padding([.leading, .trailing])
                
                Text(astronaut.description)
                    .padding([.leading, .trailing])
                    .padding(.bottom, 10)
                
                Text("Missions")
                    .font(.system(size: 25, design: .monospaced).bold())
                    .padding(.bottom, 10)
                    .padding([.leading, .trailing])
                
                DetailsScrollView(items: detailsScrollItems)
            }
        }
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(Background(isMainPage: true))
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        
        
        var tempMissions = [DetailsScrollView<MissionView>.item]()
        self.detailsScrollItems = tempMissions
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        for mission in missions {
            for member in mission.crew {
                if member.name == astronaut.id {
                    let result = DetailsScrollView.item(
                        image: mission.image,
                        header: mission.displayName,
                        subHeader: mission.formattedLaunchDate) {
                            MissionView(mission: mission, astronauts: astronauts)
                        }
                    
                    tempMissions.append(result)
                    break
                }
            }
        }
        
        self.detailsScrollItems = tempMissions
        
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [String: Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts["young"]!)
            .preferredColorScheme(.dark)
    }
}
