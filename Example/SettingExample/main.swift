//  main.swift
//  SettingExample
//
//  Created by Philip Young on 2023-04-23.
//

import Foundation
import Cocoa
import SwiftUI

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)

import AppKit


class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
            // Create the SwiftUI view that provides the window contents.
            let contentView = ContentView()

            // Create the window and set the content view.
            window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered, defer: false)
            window.center()
            window.setFrameAutosaveName("Main Window")
            window.contentView = NSHostingView(rootView: contentView)
            window.makeKeyAndOrderFront(nil)
        }

        func applicationWillTerminate(_ aNotification: Notification) {
            // Insert code here to tear down your application
        }
}
