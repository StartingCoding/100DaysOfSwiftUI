//
//  MissionView.swift
//  Moonshot
//
//  Created by Loris on 20/02/21.
//

import SwiftUI

struct MissionView: View {
    let missions: [Mission]
    let mission: Mission
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.7)
                        .padding(.top)
                    
                    Text(mission.formattedLaunchDate)
                        .padding()
                        .font(.subheadline)
                    
                    Text(mission.description)
                        .padding()
                        .layoutPriority(1)
                    
                    ForEach(astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(missions: missions, astronaut: crewMember.astronaut)) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .fill(Color.white)
                                    .shadow(color: Color(red: 0, green: 0, blue: 1, opacity: 0.3), radius: 4, x: 0.0, y: 0.0)
                                    .shadow(color: Color(red: 0, green: 0.5, blue: 1, opacity: 0.7), radius: 10, x: 0.0, y: 5.0)
                                    .padding()
                                
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 83, height: 60)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.primary, lineWidth: 1))
                                    
                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                        if crewMember.role.starts(with: "Command") {
                                            Label(
                                                title: { Text(crewMember.role).font(.subheadline) },
                                                icon: { Image(systemName: "star.circle.fill") }
                                            )
                                        } else {
                                            Text(crewMember.role)
                                        }
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.horizontal)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(missions: [Mission], mission: Mission, astronauts: [Astronaut]) {
        self.missions = missions
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("🔴 Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(missions: missions, mission: missions[0], astronauts: astronauts)
    }
}
