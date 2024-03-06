//
//  CatalogFeatureViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by Diarmuid McGonagle on 06/03/2024.
//

import UIKit
import MealzNavModuleIOS
import MiamIOSFramework

class CatalogFeatureViewController: AbstractMealzViewController {
    
    override func viewDidLoad() {
        feature = MealzCatalogFeatureUIKit(
            hideTitles: true,
            recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig,
            catalogFeatureConstructor: MealzViewConfig.catalogConfig,
            myMealsViewOptions: MealzViewConfig.myMealsView,
            mealPlannerFeatureConstructor: MealzViewConfig.mealPlannerConfig // only if you want Meal Planner feature
        )
        
        super.viewDidLoad()
    }
}

// i only use above because i want to use Storyboard
//let catalogFeature = MealzCatalogFeatureUIKit(
//    recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig,
//    catalogFeatureConstructor: MealzViewConfig.catalogConfig,
//    myMealsViewOptions: MealzViewConfig.myMealsView
//)
