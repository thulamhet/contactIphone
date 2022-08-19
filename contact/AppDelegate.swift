//
//  AppDelegate.swift
//  contact
//
//  Created by Nguyễn Công Thư on 17/08/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let homeVC = HomeViewController()
        let homeNavi = UINavigationController(rootViewController: homeVC)
        homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        
        let recentsVC = RecentsViewController()
        let recentsNavi = UINavigationController(rootViewController: recentsVC)
        recentsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 0)
        
        let voicemailVC = VoicemailViewController()
        let voicemailNavi = UINavigationController(rootViewController: voicemailVC)
        voicemailVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        
        let favoritesVC = FavoritesViewController()
        let favoritesNavi = UINavigationController(rootViewController: favoritesVC)
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        let keypadVC = KeypadViewController()
        let keypadNavi = UINavigationController(rootViewController: keypadVC)
        keypadVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        
        //tabbar controller
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [favoritesNavi, recentsNavi, homeNavi, keypadNavi, voicemailNavi]
        tabbarController.selectedIndex = 2
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
        return true
    }


}

