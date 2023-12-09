//
//  PokeIndexApp.swift
//  PokeIndex
//
//  Created by Ömer Ulusal on 23/11/2023.
//

import SwiftUI

@main
struct PokeIndexApp: App {
    @State var isUserLoggedIn: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isUserLoggedIn {
                LoginView()
            } else {
                TabView {
                    ContentView()
                        .tabItem {
                            VStack {
                                Image(systemName: "house.fill")
                                Text("Home")
                            }
                        }
                    
                    SettingsScreen()
                        .tabItem {
                            VStack {
                                Image(systemName: "gear.circle.fill")
                                Text("Settings")
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    TabView(selection: .constant(1)) {
        ContentView()
            .tabItem {
                VStack {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            }
            .tag(0)
        
        SettingsScreen()
            .tabItem {
                VStack {
                    Image(systemName: "gear.circle.fill")
                    Text("Settings")
                }
            }
            .tag(1)
    }
}
