//
//  ContentView.swift
//  SettingExample
//
//  Created by A. Zheng (github.com/aheze) on 2/22/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import Setting
import SwiftUI

struct MaybeLabel: View {
    var text: String
    var systemImage: String
    
    init(_ text: String, systemImage: String) {
        self.text = text
        self.systemImage = systemImage
    }
    
    var body: some View {
        if #available(iOS 14.0, macOS 11.0, *) {
            Label(text, systemImage: systemImage)
        } else {
            Text(text)
        }
    }
}



struct ContentView: View {
//    @AppStorage("selectedIndex") var selectedIndex = 1
    @State var selectedIndex = 1
    var body: some View {
        TabView(selection: $selectedIndex) {
            PreferencesView()
                .tabItem {
                    MaybeLabel("Preferences", systemImage: "text.book.closed")
                }
                .tag(0)

            SettingsView()
                .tabItem {
                    MaybeLabel("Settings", systemImage: "gearshape")
                }
                .tag(1)

            ControlPanelView()
                .tabItem {
                    MaybeLabel("Control Panel", systemImage: "dial.high")
                }
                .tag(2)

            PlaygroundView()
                .tabItem {
                    MaybeLabel("Playground", systemImage: "gamecontroller")
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
