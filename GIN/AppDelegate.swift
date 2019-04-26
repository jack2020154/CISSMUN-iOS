//
//  AppDelegate.swift
//  GIN
//
//  Created by Stanley Liu on 5/24/17.
//  Copyright © 2017 Stanley Liu. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let appVersion = 1.1
    var updatedVersion: Double = 0.0


    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        // Setting appearances/formatting for navigation bar
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 20)!
        ]
        UINavigationBar.appearance().titleTextAttributes = attrs
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Avenir", size: 16.0)!], for: UIControl.State.normal)
        
        // Load user conference
        loadConference()
        
        return true
    }
    
    func getVersion() {
        if let url = URL(string: "http://hosted.concordiashanghai.org/appVersion.txt") {
            do {
                updatedVersion = Double(try String(contentsOf: url, encoding: .utf8))!
            } catch {updatedVersion = appVersion}
            
        } else {
            print("URL was bad")
        }
        
    }
    
    func checkVersion(vc: UIViewController) {
        getVersion()
            
        if (appVersion != updatedVersion)
        {
            let alert = UIAlertController(title: "New Version Available", message: "There is a newer version available for download! Please update the app by visiting the Apple Store.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Update", style: UIAlertAction.Style.default, handler: { alertAction in
                UIApplication.shared.open(URL(string : "https://itunes.apple.com/us/app/cissmun/id1323501359?ls=1&mt=8")!, options: [:], completionHandler: nil)
                alert.dismiss(animated: true, completion: nil)
            }))
            vc.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func loadConference() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        var identifier = "GIN"
        if let conf = UserDefaults.standard.object(forKey: "myConference") as? Bool {
            if conf {
                identifier = "MUN"
            }
        } else {
            identifier = "Main"
        }
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: identifier, bundle: nil)

        let exampleViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: identifier)
        
        self.window?.rootViewController = exampleViewController
        
        self.window?.makeKeyAndVisible()
        
        //checkVersion(vc: exampleViewController)
        
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print ("Permission granted: \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
        
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

