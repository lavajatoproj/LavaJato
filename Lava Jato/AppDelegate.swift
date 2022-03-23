//
//  AppDelegate.swift
//  Lava Jato
//
//  Created by Olimpio Junior on 04/02/22.
//

import GooglePlaces
import GoogleMaps
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ApplicationDelegate.shared.application(
                   application,
                   didFinishLaunchingWithOptions: launchOptions
               )
        
        UITabBar.appearance().tintColor = UIColor.ColorDefault
<<<<<<< HEAD
        UINavigationBar.appearance().barTintColor = UIColor.ColorDefault
=======
        
        FirebaseApp.configure()

        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
          if error != nil || user == nil {
            // Show the app's signed-out state.
          } else {
            // Show the app's signed-in state.
          }
        }
        
>>>>>>> 8f79e7f (create Google login and update WhatSapp)
        GMSServices.provideAPIKey("AIzaSyBkMktW0sYUqwpDXhyXFfoPRLFYh5JeFlk")
        GMSPlacesClient.provideAPIKey("AIzaSyBkMktW0sYUqwpDXhyXFfoPRLFYh5JeFlk")

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
      _ app: UIApplication,
      open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
      var handled: Bool

      handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }
      return false
    }
    //Tratamento da URL final recebida no processo de authenticacão do Google
//    @available(iOS 9.0, *)
//    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any])
//      -> Bool {
//      return GIDSignIn.sharedInstance.handle(url)
//    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}
