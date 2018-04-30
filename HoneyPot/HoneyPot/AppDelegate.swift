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
import RevealingSplashView

typealias FIRUser = FirebaseAuth.User
let heartAttackNotificationName = Notification.Name("heartAttack")

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var strDeviceToken = ""
    var urlContents = ""
    var navTitle = ""
 let revealingSplashView = RevealingSplashView(iconImage:UIImage(named: "Icon-App-20x20 03-06-14-899")! , iconInitialSize: CGSize(width:123,height:123), backgroundImage:UIImage(named: "appBackGround")! )
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
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
        if application.applicationState == .background {
            self.vcTransition(from: userInfo)
        }else {
            self.vcTransition(from: userInfo)
        }
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
    
    @objc func vcTransition(from userInfo: [AnyHashable : Any]) {
        if let logFileText = userInfo["logFile"] as? String {
            print("notification pressed")
            if let mainTabBarController = self.window?.rootViewController as? HomeViewController {
                if let homeNavController = mainTabBarController.viewControllerList.first as? UINavigationController {
                    print(logFileText)
                    self.navTitle = logFileText
                    let urlString = "http://18.218.88.192:8080/ActiveHoneypotWeb/logfiles/\(logFileText)"
                    grabTextFile(homeNavController: homeNavController,urlString: urlString, navTitle: self.navTitle)
                }
            }
        }
    }
    
    
    @objc func grabTextFile(homeNavController: UINavigationController,urlString: String, navTitle: String){
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        if let messageURL = URL(string: urlString) {
            let sharedSession = URLSession.shared
            let downloadTask = sharedSession.downloadTask(with: messageURL) { (location, response, error) in
                if let location = location {
                    do{
                        self.urlContents = try String(contentsOf: location, encoding: String.Encoding.utf8)
                        dispatchGroup.leave()
                    }catch {
                        print("Couldn't load string from \(location)")
                    }
                } else if let error = error {
                    print("Unable to load data: \(error)")
                }
            }
            downloadTask.resume()
        } else {
            print("\(urlString) isn't a valid URL")
        }
        
        dispatchGroup.notify(queue: .main) {
            print(self.urlContents)
            self.presentVc(homeNavController: homeNavController,navTitle: self.navTitle, urlContents: self.urlContents)
        }
        
    }
    
    
    @objc func presentVc(homeNavController:UINavigationController,navTitle: String, urlContents: String){
        let logFileVC = LogFileViewController()
        print(urlContents)
        logFileVC.navigationItem.title = navTitle
        logFileVC.textView.text = urlContents
        print(self.urlContents)
        homeNavController.pushViewController(logFileVC, animated: false)
    }
    
    
    
    
    
    
}

extension AppDelegate {
    func configureInitialRootViewController(for window: UIWindow?) {
        // print("Look for current user here")
        // print(Auth.auth().currentUser ?? "")
        let defaults = UserDefaults.standard
        var initialViewController: UIViewController
        NotificationCenter.default.addObserver(self, selector: #selector(handleHeartAttack), name: heartAttackNotificationName, object: nil)

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
        revealingSplashView.animationType = .heartBeat
        window?.addSubview(revealingSplashView)
        revealingSplashView.startAnimation()
    }
    
    
    @objc func handleHeartAttack(){
        print("Trying to handle heart attack")
        revealingSplashView.heartAttack = true
        NotificationCenter.default.removeObserver(self, name: heartAttackNotificationName, object: nil)
    }
}

