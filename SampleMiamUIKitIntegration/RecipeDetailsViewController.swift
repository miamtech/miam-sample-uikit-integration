////
////  RecipeDetailsViewController.swift
////  SampleUIKitIntegration
////
////  Created by didi on 7/6/23.
////
//
//import UIKit
//import SwiftUI
//import MiamIOSFramework
//import MiamNeutraliOSFramework
//
//class RecipeDetailsViewController: UIHostingController<
//    RecipeDetailsViewTemplate<
//        MiamNeutralRecipeDetailsHeaderView,
//        MiamNeutralRecipeDetailsIngredientsView,
//        MiamNeutralRecipeDetailsStepsView,
//        MiamNeutralRecipeDetailsFooterView>
//    > {
//
//        required init?(coder aDecoder: NSCoder) {
//                 super.init(coder: aDecoder)
//             }
//
//             override init(rootView: RecipeDetailsViewTemplate<
//                           MiamNeutralRecipeDetailsHeaderView,
//                           MiamNeutralRecipeDetailsIngredientsView,
//                           MiamNeutralRecipeDetailsStepsView,
//                           MiamNeutralRecipeDetailsFooterView>
//                       ) {
//                 super.init(rootView: rootView)
//             }
//
//             public init() {
//                 let recipeDetails = RecipeDetailsViewTemplate.init(
//                    headerContent: MiamNeutralRecipeDetailsHeaderView(),
//                    ingredientsContent: MiamNeutralRecipeDetailsIngredientsView(),
//                    stepsContent: MiamNeutralRecipeDetailsStepsView(),
//                    footerContent: MiamNeutralRecipeDetailsFooterView(),
//                    recipeId: "",
//                    isForMealPlanner: true,
//                    sponsorDetailsTapped: {_ in},
//                    close: {})
//                 super.init(rootView: recipeDetails)
//             }
//
//             override func viewDidLoad() {
//                 let recipeId = UserDefaults.standard.value(forKey: "miam_mealplanner_recipeId") as? String ?? ""
//                 self.title = "Catalogue"
//                 super.viewDidLoad()
//                 let recipeDetails = RecipeDetailsViewTemplate.init(
//                    headerContent: MiamNeutralRecipeDetailsHeaderView(),
//                    ingredientsContent: MiamNeutralRecipeDetailsIngredientsView(),
//                    stepsContent: MiamNeutralRecipeDetailsStepsView(),
//                    footerContent: MiamNeutralRecipeDetailsFooterView(),
//                    recipeId: recipeId,
//                    isForMealPlanner: true,
//                    sponsorDetailsTapped: {_ in},
//                    close: {
//                         self.navigationController?.popViewController(animated: true)
//                 })
//                 self.rootView = recipeDetails
//                 // Do any additional setup after loading the view.
//             }
//         }
