//
//  AppDelegate.swift
//  SettingExample
//
//  Created by Philip Young on 2023-04-24.
//

import Foundation

import UIKit
import SwiftUI

@UIApplicationMain
class AppDelegate: NSObject, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: Initializing the application

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        // The launch process is almost done and the app is almost ready to run.
//        let contentView = ContentView()
//        let window = UIWindow()
//        self.window = window
//        window.rootViewController = UIHostingController(rootView: contentView)
//        window.makeKeyAndVisible()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: Text("AWJDIAWJDI").onAppear { print("HENLO", window.isKeyWindow)})
        
        // Make the window visible
            window.makeKeyAndVisible()
            
            // Set the window as the key window
            window.becomeKey()
        
        self.window = window
        print("YAY", window.isKeyWindow)
        return true
    }

    // MARK: Life cycle

    func applicationDidEnterBackground(_ application: UIApplication) {
        // The app is now in the background.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // The app is about to enter the foreground.
    }

    // MARK: Registrating remote notifications

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // The app successfully registered with Apple Push Notification service.
    }
}
