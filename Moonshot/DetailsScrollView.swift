//
//  DetailsScrollView.swift
//  Moonshot
//
//  Created by Ярослав Грогуль on 10.01.2023.
//

import SwiftUI



struct DetailsScrollView<Content: View>: View {
//struct DetailsScrollView: View {
    
    struct item {
        var image: String
        var header: String
        var subHeader: String
        var content: () -> Content
    }
    
    var items: [item]

//    let crew : [MissionView.CrewMember]
//    var content: () -> Content
    
//    init(image, @ViewBuilder content: @escaping () -> Content) {
    init(items: [DetailsScrollView.item]) {
        var tempItems = [item]()
        for item in items {
            let item = DetailsScrollView.item(image: item.image, header: item.header, subHeader: item.subHeader) {
                item.content()
            }
            tempItems.append(item)
        }
        
        self.items = tempItems
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(items, id: \.header) { item in
                    NavigationLink {
//                        AstronautView(astronaut: crewMember.astronaut)
                        item.content()
                    } label: {
                        HStack {
//                            Image(crewMember.astronaut.id)
                            Image(item.image)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(.white, lineWidth: 1)
                                )

                            VStack(alignment: .center) {
//                                Text(crewMember.astronaut.name)
                                Text(item.header)
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, design: .monospaced))
                                    .lineLimit(nil)


//                                Text(crewMember.role)
                                Text(item.subHeader)
                                    .foregroundColor(.secondary)
                                    .font(.system(size: 14, design: .monospaced))
                            }
                            .frame(width: 104)
                        }
                        .padding(.horizontal)
                        .frame(width: 250)
                    }
                }
            }
        }
    }

}

struct DetailsScrollView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        DetailsScrollView(
            items: [
                DetailsScrollView.item(image: "armstrong", header: "Neil", subHeader: "armstrong") {
                    AstronautView(astronaut: Astronaut(id: "armstrong", name: "Neil", description: "No.."))
                }
            ]
        )
    }
}
