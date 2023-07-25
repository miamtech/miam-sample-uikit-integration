//
//  BasketPreviewViewController.swift
//  SampleUIKitIntegration
//
//  Created by didi on 6/21/23.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework
//
class BasketPreviewViewController: UIHostingController<MealPlannerBasketPreviewView<
    MiamNeutralMealPlannerBasketPreviewLoading,
    MiamNeutralMealPlannerBasketPreviewRecipeOverview,
    MiamNeutralMealPlannerBasketPreviewProduct,
    MiamNeutralMealPlannerBasketPreviewFooter,
    MiamNeutralMealPlannerBasketPreviewSectionTitle,
    MiamNeutralMealPlannerBasketPreviewSectionProduct>
> {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(rootView: MealPlannerBasketPreviewView<
                  MiamNeutralMealPlannerBasketPreviewLoading,
                  MiamNeutralMealPlannerBasketPreviewRecipeOverview,
                  MiamNeutralMealPlannerBasketPreviewProduct,
                  MiamNeutralMealPlannerBasketPreviewFooter,
                  MiamNeutralMealPlannerBasketPreviewSectionTitle,
                  MiamNeutralMealPlannerBasketPreviewSectionProduct>) {
        super.init(rootView: rootView)
    }

    public init() {
        let budgetPreview = MealPlannerBasketPreviewView.init(
            loadingTemplate: MiamNeutralMealPlannerBasketPreviewLoading(),
            recipeOverviewTemplate: MiamNeutralMealPlannerBasketPreviewRecipeOverview(),
            productTemplate: MiamNeutralMealPlannerBasketPreviewProduct(),
            footerTemplate: MiamNeutralMealPlannerBasketPreviewFooter(),
            sectionTitleTemplate: MiamNeutralMealPlannerBasketPreviewSectionTitle(),
            sectionProductTemplate: MiamNeutralMealPlannerBasketPreviewSectionProduct(),
//            validateRecipes: {},
            replaceProduct: {_ in},
            continueShopping: {},
            showBasket: {},
            onRecipeTapped: {_ in}
        )
        super.init(rootView: budgetPreview)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mon assistant Budget repas"
        let budgetPreview = MealPlannerBasketPreviewView.init(
            loadingTemplate: MiamNeutralMealPlannerBasketPreviewLoading(),
            recipeOverviewTemplate: MiamNeutralMealPlannerBasketPreviewRecipeOverview(),
            productTemplate: MiamNeutralMealPlannerBasketPreviewProduct(),
            footerTemplate: MiamNeutralMealPlannerBasketPreviewFooter(),
            sectionTitleTemplate: MiamNeutralMealPlannerBasketPreviewSectionTitle(),
            sectionProductTemplate: MiamNeutralMealPlannerBasketPreviewSectionProduct(),
//            validateRecipes: {
//                DispatchQueue.main.async {
//                    self.navigationController?.pushViewController(RecapPurchaseViewController(), animated: true)
//                }
//            },
            replaceProduct: { recipe in
                UserDefaults.standard.set(recipe, forKey: "miam_mealplanner_recipeId")
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(ItemSelectorViewController(), animated: true)
                }
            },
            continueShopping: {},
            showBasket: {},
            onRecipeTapped: { recipe in
                UserDefaults.standard.set(recipe, forKey: "miam_mealplanner_recipeId")
//                DispatchQueue.main.async { self.navigationController?.pushViewController(RecipeDetailsViewController(), animated: true)
//                }
            }
        )
        self.rootView = budgetPreview
        // Do any additional setup after loading the view.


    }
}
////

//class BasketPreviewViewController: CustomUIHostingController<MealPlannerBasketPreviewView<
//MiamNeutralMealPlannerBasketPreviewLoading,
//    MiamNeutralMealPlannerBasketPreviewRecipeOverview,
//    MiamNeutralMealPlannerBasketPreviewProduct,
//    MiamMealPlannerBasketPreviewFooter,
//    MiamNeutralMealPlannerBasketPreviewSectionTitle,
//    MiamNeutralMealPlannerBasketPreviewSectionProduct>
//> {
//
//    required init?(coder aDecoder: NSCoder) {
//            super.init(coder: aDecoder)
//        }
//
//    public init() {
//        let budgetPreview = MealPlannerBasketPreviewView.init(
//            loadingTemplate: MiamNeutralMealPlannerBasketPreviewLoading(),
//            recipeOverviewTemplate: MiamNeutralMealPlannerBasketPreviewRecipeOverview(),
//            productTemplate: MiamNeutralMealPlannerBasketPreviewProduct(),
//            footerTemplate: MiamMealPlannerBasketPreviewFooter(),
//            sectionTitleTemplate: MiamNeutralMealPlannerBasketPreviewSectionTitle(),
//            sectionProductTemplate: MiamNeutralMealPlannerBasketPreviewSectionProduct(),
//            continueShopping: {},
//            showBasket: {}
////            validateRecipes: {}
//        )
//        super.init(rootView: budgetPreview)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = "Mon assistant Budget repas"
//        let budgetPreview = MealPlannerBasketPreviewView.init(
//            loadingTemplate: MiamNeutralMealPlannerBasketPreviewLoading(),
//            recipeOverviewTemplate: MiamNeutralMealPlannerBasketPreviewRecipeOverview(),
//            productTemplate: MiamNeutralMealPlannerBasketPreviewProduct(),
//            footerTemplate: MiamMealPlannerBasketPreviewFooter(),
//            sectionTitleTemplate: MiamNeutralMealPlannerBasketPreviewSectionTitle(),
//            sectionProductTemplate: MiamNeutralMealPlannerBasketPreviewSectionProduct(),
//            continueShopping: {},
//            showBasket: {}
//            //            validateRecipes: {
//            //                DispatchQueue.main.async {
//            //                    self.navigationController?.pushViewController(RecapPurchaseViewController(), animated: true)
//            //                }
//            //            }
//        )
//        self.rootView = budgetPreview
//        // Do any additional setup after loading the view.
//        // Set the background color
//        self.view.backgroundColor = UIColor(red: 191.0 / 255, green: 221.0 / 255, blue: 232.0/255, alpha: 1.0)
//    }
//
//}
