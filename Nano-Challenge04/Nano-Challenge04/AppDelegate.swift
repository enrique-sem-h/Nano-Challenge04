//
//  AppDelegate.swift
//  Nano-Challenge04
//
//  Created by Luca Lacerda on 13/11/23.
//

import SwiftUI
import CloudKit

class AppDelegate: NSObject, UIApplicationDelegate,UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { authorized, error in
            if authorized {
                DispatchQueue.main.async(execute: {
                    application.registerForRemoteNotifications()
                })
            }
        })
        
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        let predicate = NSPredicate(value: true)
        
        let subscription = CKQuerySubscription(recordType: "NewCup", predicate: predicate,subscriptionID: "NewCup",options: .firesOnRecordCreation)
        
        let info = CKSubscription.NotificationInfo()
        
        info.titleLocalizationKey = "%1$@"
        info.titleLocalizationArgs = ["date"]
        
        
        info.alertLocalizationKey = "%1$@"
        info.alertLocalizationArgs = ["ml"]
        
        info.shouldBadge = true
        
        info.soundName = "default"
        
        subscription.notificationInfo = info
        CKContainer.default().publicCloudDatabase.save(subscription, completionHandler: { subscription, error in
            if error == nil {
                print("Subscribed")
            } else {
                print("Not subscribed")
            }
        })
    }
}
