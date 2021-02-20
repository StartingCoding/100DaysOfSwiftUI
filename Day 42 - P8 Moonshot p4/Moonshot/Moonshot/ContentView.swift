//
//  ContentView.swift
//  Moonshot
//
//  Created by Loris on 20/02/21.
//

// https://creativecommons.org/licenses/by-sa/3.0

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingCrew = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(missions: missions, mission: mission, astronauts: astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
//                        HStack {
//                            if showingCrew {
//                                ForEach(mission.crew) { member in
//                                    Text("\(member)")
//                                }
//                            } else {
//                                mission.formattedLaunchDate
//                            }
//                        }
//                        Text(mission.formattedLaunchDate)
                        SubTitle(mission: mission, showingCrew: showingCrew)
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(showingCrew ? "LaunchDate" : "Crew") {
                showingCrew.toggle()
            })
        }
    }
}

struct SubTitle: View {
    let mission: Mission
    let showingCrew: Bool
    var crewMembers: String {
        var result = ""
        
        for member in mission.crew {
            result.append(member.name.capitalized)
            result.append(" ")
        }
        
        return result
    }
    
    var body: some View {
        if showingCrew {
            Text(crewMembers)
        } else {
            Text(mission.formattedLaunchDate)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
