//
//  AppDelegate.swift
//  SampleUIKitIntegration
//
//  Created by Vincent Kergonna on 13/06/2022.
//

import UIKit
import MiamIOSFramework
import miamCore
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LogHandler.companion.info("Are you ready ? \(ContextHandlerInstance.shared.instance.isReady())")
        BasketHandlerInstance.shared.instance.setListenToRetailerBasket(func: {})
        BasketHandlerInstance.shared.instance.setPushProductsToRetailerBasket(func: {_ in})
        BasketHandlerInstance.shared.instance.pushProductsToMiamBasket(retailerBasket: [])
        
        PointOfSaleHandler.shared.updateStoreId(storeId: "25910")
        PointOfSaleHandler.shared.setSupplierOrigin(origin:"app.coursesu.com")
        PointOfSaleHandler.shared.setSupplier(supplierId: 7)

            UserHandler.shared.updateUserId(userId: "randomUserId")
        

        // resets grocery cart - good for testing, do NOT include on actual production
        GroceriesListHandler.shared.resetGroceriesList()
            

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

