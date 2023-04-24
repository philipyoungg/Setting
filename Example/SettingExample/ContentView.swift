//
//  ContentView.swift
//  SettingExample
//
//  Created by A. Zheng (github.com/aheze) on 2/22/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import Setting
import SwiftUI


struct ContentView: View {
//    @AppStorage("selectedIndex") var selectedIndex = 1
    @State var selectedIndex = 1
    var body: some View {
        TabView(selection: $selectedIndex) {
            PreferencesView()
                .tabItem {
//                    Label("Preferences", systemImage: "text.book.closed")
                    Text("Preferences")
                }
                .tag(0)

            SettingsView()
                .tabItem {
//                    Label("Settings", systemImage: "gearshape")
                    Text("Settings")
                }
                .tag(1)

            ControlPanelView()
                .tabItem {
//                    Label("Control Panel", systemImage: "dial.high")
                    Text("Control Panel")
                }
                .tag(2)

            PlaygroundView()
                .tabItem {
//                    Label("Playground", systemImage: "gamecontroller")
                    Text("Playground")
                }
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
