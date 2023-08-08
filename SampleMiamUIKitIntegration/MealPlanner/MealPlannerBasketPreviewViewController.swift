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
class MealPlannerBasketPreviewViewController: UIHostingController<MealPlannerBasketPreviewView<
    MiamNeutralMealPlannerBasketPreviewLoading,
    MiamNeutralMealPlannerBasketPreviewRecipeOverview,
    MiamNeutralMealPlannerRecipeCardLoading,
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
                  MiamNeutralMealPlannerRecipeCardLoading,
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
            recipeLoadingTemplate: MiamNeutralMealPlannerRecipeCardLoading(),
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
            recipeLoadingTemplate: MiamNeutralMealPlannerRecipeCardLoading(),
            productTemplate: MiamNeutralMealPlannerBasketPreviewProduct(),
            footerTemplate: MiamNeutralMealPlannerBasketPreviewFooter(),
            sectionTitleTemplate: MiamNeutralMealPlannerBasketPreviewSectionTitle(),
            sectionProductTemplate: MiamNeutralMealPlannerBasketPreviewSectionProduct(),
            replaceProduct: { recipe in
                UserDefaults.standard.set(recipe, forKey: "miam_mealplanner_recipeId")
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(ItemSelectorViewController(), animated: true)
                }
            },
            continueShopping: {},
            showBasket: {
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(MealPlannerRecapPurchaseViewController(), animated: true)
                }
            },
            onRecipeTapped: { recipe in
                UserDefaults.standard.set(recipe, forKey: "miam_mealplanner_recipeId")
                DispatchQueue.main.async { self.navigationController?.pushViewController(MealPlannerRecipeDetailsViewController(), animated: true)
                }
            }
        )
        self.rootView = budgetPreview
        // Do any additional setup after loading the view.


    }
}
