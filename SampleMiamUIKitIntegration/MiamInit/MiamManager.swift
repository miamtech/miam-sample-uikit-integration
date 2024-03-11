//
//  MiamManager.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 23/10/2023.
//

import Foundation
import miamCore
import MiamIOSFramework
import MealzUIModuleIOS

public class MiamManager: ObservableObject {
    public static let sharedInstance = MiamManager()
    
    // need to be private
    private init() {
        //        let supplierKey = "ewoJInN1cHBsaWVyX2lkIjogIjE0IiwKCSJwbGF1c2libGVfZG9tYWluZSI6ICJtaWFtLnRlc3QiLAoJIm1pYW1fb3JpZ2luIjogIm1pYW0iLAoJIm9yaWdpbiI6ICJtaWFtIiwKCSJtaWFtX2Vudmlyb25tZW50IjogIlVBVCIKfQ=="
        let supplierKey = "ewoJInN1cHBsaWVyX2lkIjogIjciLAoJInBsYXVzaWJsZV9kb21haW5lIjogIm1pYW0uY291cnNlc3UuYXBwIiwKCSJtaWFtX29yaWdpbiI6ICJjb3Vyc2VzdSIsCgkib3JpZ2luIjogIm1pYW0uY291cnNlc3UuYXBwIiwKCSJtaWFtX2Vudmlyb25tZW50IjogIlBST0QiCn0="
        
        I18nResolver.shared.registerAppBundle(bundle: MealzUIModuleIOS.bundle)
        
        let demoBasketService = DemoBasketService(initialBasketList: PretendBasket.shared.items)
        
        Mealz.shared.Core(init: { coreBuilder in
            // set supplier key
            coreBuilder.sdkRequirement(init: { requirementBuilder in
                requirementBuilder.key = supplierKey
            })
            // set listeners & notifiers
            coreBuilder.subscriptions(init:  { subscriptionBuilder in
                subscriptionBuilder.basket(init: { basketSubscriptionBuilder in
                    // subscribe
                    basketSubscriptionBuilder.subscribe(subscriber: demoBasketService)
                    // push updates
                    basketSubscriptionBuilder.register(publisher: demoBasketService)
                })
            })
        })
        // set store
        Mealz.shared.user.setStoreId(storeId: "25910")
        // set userID
        Mealz.shared.user.updateUserId(userId: "test_\(UUID())", authorization: Authorization.userId)
        // allow profiling -> can we use your personal data to provide custom recipes?
        Mealz.shared.user.setProfilingAllowance(allowance: true)
        // allow users to heart recipes
        Mealz.shared.user.setEnableLike(isEnable: true)
        // show toast to users on certain events
        Mealz.shared.notifications.toaster.listen(callBack: { event in
            switch event as? ToasterNotification {
            case ToasterNotification.RecipeAdded():
                LogHandler.companion.info("MealzNotification: Recipe Added")
            case ToasterNotification.RecipeLiked():
                LogHandler.companion.info("MealzNotification: Recipe Liked")
            default:
                break
            }
        })
        // listen to analytics events
        Mealz.shared.notifications.analytics.listen { event in
            LogHandler.companion.info("Mealz.Notifications.analytics \(String(describing: event))")
        }
        
        // show "Sponsored" tag on products that are sponsored
        Mealz.shared.environment.setAllowsSponsoredProducts(isAllowed: true)
        
        LogHandler.companion.logLevel = .allLogs
    }
}
