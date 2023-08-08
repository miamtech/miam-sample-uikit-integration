//
//  MealPlannerViewController.swift
//  SampleUIKitIntegration
//
//  Created by didi on 6/21/23.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

class MealPlannerViewController: UIHostingController<MealPlannerPlannerView<MiamNeutralMealPlannerToolbar, MiamNeutralMealPlannerStickyFooter, MiamBudgetPlannerLoading, MiamBudgetPlannerEmpty, MiamNeutralMealPlannerRecipeCard, MiamNeutralMealPlannerRecipeCardLoading, MiamNeutralMealPlannerRecipePlaceholder>> {

    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

    override init(rootView: MealPlannerPlannerView<MiamNeutralMealPlannerToolbar, MiamNeutralMealPlannerStickyFooter, MiamBudgetPlannerLoading, MiamBudgetPlannerEmpty, MiamNeutralMealPlannerRecipeCard, MiamNeutralMealPlannerRecipeCardLoading, MiamNeutralMealPlannerRecipePlaceholder>) {
        super.init(rootView: rootView)
    }

    public init() {
        let mealPlannerView = MealPlannerPlannerView.init(
            toolbarTemplate: MiamNeutralMealPlannerToolbar(),
            footerTemplate: MiamNeutralMealPlannerStickyFooter(),
            loadingTemplate: MiamBudgetPlannerLoading(),
            emptyTemplate: MiamBudgetPlannerEmpty(),
            recipeCardTemplate: MiamNeutralMealPlannerRecipeCard(),
            loadingCardTemplate: MiamNeutralMealPlannerRecipeCardLoading(),
            placeholderCardTemplate: MiamNeutralMealPlannerRecipePlaceholder(),
            selectedRecipe: .constant("2"),
            showRecipe: {_ in },
            validateRecipes: {},
            replaceRecipe: {_ in })
        super.init(rootView: mealPlannerView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mon assistant Budget repas"
        let mealPlannerView = MealPlannerPlannerView.init(
            toolbarTemplate: MiamNeutralMealPlannerToolbar(),
            footerTemplate: MiamNeutralMealPlannerStickyFooter(),
            loadingTemplate: MiamBudgetPlannerLoading(),
            emptyTemplate: MiamBudgetPlannerEmpty(),
            recipeCardTemplate: MiamNeutralMealPlannerRecipeCard(),
            loadingCardTemplate: MiamNeutralMealPlannerRecipeCardLoading(),
            placeholderCardTemplate: MiamNeutralMealPlannerRecipePlaceholder(),
            selectedRecipe: .constant("2"),
            showRecipe: { recipe in
                UserDefaults.standard.set(recipe, forKey: "miam_mealplanner_recipeId")
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(MealPlannerRecipeDetailsViewController(), animated: true)
                }
            },
            validateRecipes: {
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(MealPlannerBasketPreviewViewController(), animated: true)
                }
            },
            replaceRecipe: { _ in
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(MealPlannerReplaceMealViewController(), animated: true)
                }
            })
        self.rootView = mealPlannerView
        
        
    }
}
