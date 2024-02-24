//
//  AppDelegate.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 16.02.24.
//

import UIKit
import RealmSwift
import Network

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NetworkPathMonitor.shared.startMonitoring()
        return true
    }
}

