//
//  MealPlannerFeatureViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by Diarmuid McGonagle on 06/03/2024.
//

import UIKit
import MealzNavModuleIOS

class MealPlannerFeatureViewController: AbstractMealzViewController {
    
    override func viewDidLoad() {
        feature = MealzMealPlannerFeatureUIKit(
            recipeDetailsConstructor: MealzViewConfig.mealPlannerRecipeDetailsConfig,
            mealPlannerFeatureConstructor: MealzViewConfig.mealPlannerConfig
        )
        
        super.viewDidLoad()
    }
}


// i only use above because i want to use Storyboard
//let mealPlannerFeature = MealzMealPlannerFeatureUIKit(
//    recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig,
//    mealPlannerFeatureConstructor: MealzViewConfig.mealPlannerConfig
//)

