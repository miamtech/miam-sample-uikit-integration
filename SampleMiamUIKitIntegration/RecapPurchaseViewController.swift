////
////  RecapPurchaseViewController.swift
////  SampleUIKitIntegration
////
////  Created by didi on 6/21/23.
////
//
//import UIKit
//import SwiftUI
//import MiamIOSFramework
//import MiamNeutraliOSFramework
//
//class RecapPurchaseViewController: UIHostingController<MealPlannerRecapView<MiamNeutralMealPlannerRecapView>> {
//
//
//    required init?(coder aDecoder: NSCoder) {
//        let recapPurchase = MealPlannerRecapView.init(
//            template: MiamNeutralMealPlannerRecapView(onClose: {}),
//            onTapGesture: {}
//        )
//        super.init(coder: aDecoder, rootView: recapPurchase)
//    }
//
//    override init(rootView: MealPlannerRecapView<MiamNeutralMealPlannerRecapView>) {
//        super.init(rootView: rootView)
//    }
//
//    public init() {
//        let recapPurchase = MealPlannerRecapView.init(
//            template: MiamNeutralMealPlannerRecapView(onClose: {}),
//            onTapGesture: {}
//        )
//        super.init(rootView: recapPurchase)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = "Mon assistant Budget repas"
//        let recapPurchase = MealPlannerRecapView.init(
//            template: MiamNeutralMealPlannerRecapView(
//                   onClose: {
//                       print("closing")
//                   }),
//            onTapGesture: { print("promoting")}
//        )
//        self.rootView = recapPurchase
//        // Do any additional setup after loading the view.
//    }
//}
