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
        
        IQKeyboardManager.shared.enable = true
        
        serviceProvider.request(.initData) { result in
            do {
                let response = try result.get()
                let initData = try response.mapObject(InitData.self)
                let shareData: ShareData = ShareData.shared
                shareData.gradetypes = initData.gradetypes
                shareData.areas = initData.areas
                shareData.courses = initData.courses
                shareData.resourcetypes = initData.resourcetypes
                try shareData.saveOnDisk()
            } catch {
                
            }
        }
        
        serviceProvider.request(.sendSMS(phone: "15330501673")) { result in
            do {
                let response = try result.get()
                let string = String(data:response.data, encoding: .utf8)
                print(string)
            } catch {
                
            }
        }
        window?.makeKeyAndVisible()
//        showSplashIfNeeded()
        
        return true
    }
    
    func showSplashIfNeeded() {
        if SplashView.canShowSplash {
            let splashView = SplashView(frame: window!.bounds)
            splashView.show(in: window!)
        }
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

