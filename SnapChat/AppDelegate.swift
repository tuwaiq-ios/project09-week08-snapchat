//
//  AppDelegate.swift
//  SnapChat
//
//  Created by Amal on 04/04/1443 AH.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotificationsUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate , MessagingDelegate , UNUserNotificationCenterDelegate{



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound])  { success, _ in
            guard success else {
                return
            }
            print ("Success in APNS registry")
        }
        
        application.registerForRemoteNotifications()
        return true
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else {
                return
            }

            print("Token: \(token)")
        }
    }
}
