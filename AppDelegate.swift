//
// AppDelegate.swift
// Beyond Fit
//
// Created by Andrew on 30/09/2021
//


import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> bool {
        let homeVC = UIStoryboard(name: "Splash", bundle: nil).instantiateInitiialViewController() as! SplashVC

      //let homeVav = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = homeVC
        return true



      
        }
  
}
