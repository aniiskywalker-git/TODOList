//
//  NTTData_ChallengeApp.swift
//  NTTData-Challenge
//
//  Created by Ana Victoria Frias on 23/10/23.
//

import SwiftUI

@main
struct NTTData_ChallengeApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var persistence = PersistenceController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .onChange(of: scenePhase, perform: { newScenePhase in
                    do {
                        if newScenePhase == .background {
                            try persistence.container.viewContext.save()
                        }
                    } catch let error {
                        print(error.localizedDescription)
                    }
                    
                })
        }
    }
}
