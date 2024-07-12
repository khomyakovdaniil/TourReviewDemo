//
//  AppDelegate.swift
//  TourReviewDemo
//
//  Created by  Даниил Хомяков on 11.07.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        DIContainer.registerDependencies()
        
        return true
    }


}

