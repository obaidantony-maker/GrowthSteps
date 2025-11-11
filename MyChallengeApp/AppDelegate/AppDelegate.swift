//
//  AppDelegate.swift
//  MyChallengeApp
//
//  Created by D K on 15.10.2025.
//

import UIKit
import SwiftUI
import OneSignalFramework

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    static var orientationLock: UIInterfaceOrientationMask = .portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        AppDelegate.orientationLock
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        start()
        OneSignal.initialize("5afc8638-f441-448c-90f4-e2e19dc6957c", withLaunchOptions: launchOptions)
        OneSignal.Notifications.requestPermission({ accepted in
            print("User accepted notifications: \(accepted)")
        }, fallbackToSettings: true)

        return true
    }
    
    private func start() {
        self.window = .init()
        let rootViewController = UIHostingController(rootView: ContentView())
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }
}

