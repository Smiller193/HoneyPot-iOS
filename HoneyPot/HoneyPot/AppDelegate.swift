//
//  AppDelegate.swift
//  HoneyPot
//
//  Created by Shawn Miller on 3/14/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

typealias FIRUser = FirebaseAuth.User

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var strDeviceToken = ""


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.white
        configureInitialRootViewController(for: window)
//        GMSServices.provideAPIKey("AIzaSyB88ZXgUfRZ82m_R5_sIixIoTNxtTtX0MI")
//        GMSPlacesClient.provideAPIKey("AIzaSyB88ZXgUfRZ82m_R5_sIixIoTNxtTtX0MI")
        attemptRegisterForNotifcations(application: application)
        // Override point for customization after application launch.
        return true
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("registerd for notifs and user device token is: \(deviceToken)")
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Registered with FCM with token: \(fcmToken)")
        self.strDeviceToken = fcmToken
    }
    
    //listen for user notifcations
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
    private func attemptRegisterForNotifcations(application: UIApplication) {
        print("attemping to register push apns...")
        //request auth
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        let options: UNAuthorizationOptions = [.alert,.badge,.sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, err) in
            if let error = err {
                print("auth failed: \(error)")
            }
            if granted {
                print("auth granted ....")
            }else{
                print("auth denied....")
            }
        }
        
        application.registerForRemoteNotifications()
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
        application.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate {
    func configureInitialRootViewController(for window: UIWindow?) {
        // print("Look for current user here")
        // print(Auth.auth().currentUser ?? "")
        let defaults = UserDefaults.standard
        var initialViewController: UIViewController
        // print(Auth.auth().currentUser ?? "")
        if Auth.auth().currentUser != nil,
            let userData = defaults.object(forKey: "currentUser") as? Data,
            let user = NSKeyedUnarchiver.unarchiveObject(with: userData) as? User {
            
            User.setCurrent(user, writeToUserDefaults: true)
            // print("root view controller set to home view controller")
            initialViewController = HomeViewController()
            
        } else {
            // print("root view controller set to login view controller")
            initialViewController = LoginViewController()
        }
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
}

