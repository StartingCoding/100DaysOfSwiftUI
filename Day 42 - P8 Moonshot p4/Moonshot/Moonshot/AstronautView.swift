//
//  AstronautView.swift
//  Moonshot
//
//  Created by Loris on 20/02/21.
//

import SwiftUI

struct AstronautView: View {
    let missions: [Mission]
    let astronaut: Astronaut
    let missionsForAstronaut: [Mission]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .layoutPriority(1)
                    
                    HStack {
                        Text("Missions:")
                            .underline(true, color: .orange)
                            .font(.subheadline)
                            .padding()
                        
                        ForEach(missionsForAstronaut) { mission in
                            Text(mission.displayName)
                                .padding()
                                .overlay(Capsule().stroke(Color.blue))
                                .font(.footnote)
                        }
                    }
                    
                    Text(astronaut.description)
                        .padding()
                        .layoutPriority(1)
                }
                .layoutPriority(1)
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(missions: [Mission], astronaut: Astronaut) {
        self.missions = missions
        self.astronaut = astronaut
        
        var missionForAstronaut = [Mission]()
        
        for mission in missions {
            for member in mission.crew {
                if member.name == astronaut.id {
                    missionForAstronaut.append(mission)
                }
            }
        }
        
        self.missionsForAstronaut = missionForAstronaut
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(missions: missions, astronaut: astronauts[0])
    }
}
