//
//  AppDelegate.swift
//  ShareEducation
//
//  Created by yanmingjun on 2019/10/22.
//  Copyright © 2019 yanmingjun. All rights reserved.
//

import UIKit
import Moya_ObjectMapper
import SwiftDate
import Moya
import IQKeyboardManagerSwift

let mainNavigationController: UINavigationController = {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.window?.rootViewController as! UINavigationController
}()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        let backImage = UIImage(named: "icon_back")?.withRenderingMode(.alwaysOriginal)
        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
        let barButtonItem = UIBarButtonItem.appearance()
        barButtonItem.title = ""
        
        window?.makeKeyAndVisible()
        
//        WXApi.registerApp("wxd930ea5d5a258f4f", universalLink: "http://www.netcoclass.com:8080/")
//        showSplashIfNeeded()
        configUmeng(launchOptions)
        
        return true
    }
    
    @discardableResult fileprivate func loadShareData() -> Cancellable {
        return serviceProvider.request(.initData) { result in
            do {
                let response = try result.get()
                let initData = try response.mapObject(InitData.self)
                let shareData: ShareData = ShareData.shared
                shareData.gradetypes = initData.gradetypes
                shareData.areas = initData.areas
                shareData.courses = initData.courses
                shareData.resourcetypes = initData.resourcetypes
                shareData.postNotification()
                try shareData.saveOnDisk()
            } catch {
                
            }
        }
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        loadShareData()
        return true
    }
    
    func showSplashIfNeeded() {
        if SplashView.canShowSplash {
            let splashView = SplashView(frame: window!.bounds)
            splashView.show(in: window!)
        }
    }
    
    func configUmeng(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        UMConfigure.initWithAppkey("5f3d1dc1fa5e894f08bd7569", channel: "AppStore")
//        [UMConfigure initWithAppkey:@"Your appkey" channel:@"App Store"];

        WXApi.registerApp("wx42d5e6c490be185b", enableMTA: true)
        
        
        let entity = UMessageRegisterEntity()
        entity.types = Int(UMessageAuthorizationOptions.badge.rawValue |  UMessageAuthorizationOptions.sound.rawValue | UMessageAuthorizationOptions.alert.rawValue)
        UNUserNotificationCenter.current().delegate = self
        UMessage.registerForRemoteNotifications(launchOptions: launchOptions, entity: entity) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                
            }
        }

    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var token = ""
        for byte in Array<UInt8>(deviceToken) {
            token += String(format: "%02x", byte & 0x000000FF)
        }
        print(token)
        UMessage.registerDeviceToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        
        if url.host == "safepay" {
            AlipaySDK.defaultService()?.processOrder(withPaymentResult: url, standbyCallback: { (resultDic) in
                PaymentManager.default.onAlipayResult(resultDic)
            })
        } else {
            WXApi.handleOpen(url, delegate: PaymentManager.default)
        }
        return true
    }
    
    


//    // MARK: UISceneSession Lifecycle
//    @available(iOS 13, *)
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    @available(iOS 13, *)
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger is UNPushNotificationTrigger {
            UMessage.setAutoAlert(false)
            UMessage.didReceiveRemoteNotification(userInfo)
        } else {
            
        }
        completionHandler([.sound, .badge, .alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            UMessage.didReceiveRemoteNotification(userInfo)
        }
    }
}

