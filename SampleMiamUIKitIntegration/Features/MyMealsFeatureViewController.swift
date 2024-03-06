//
//  MyMealsFeatureViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by Diarmuid McGonagle on 06/03/2024.
//

import UIKit
import MealzNavModuleIOS

class MyMealsFeatureViewController: AbstractMealzViewController {
    
    override func viewDidLoad() {
        feature = MealzMyMealsFeatureUIKit(
            hideTitles: true,
            recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig,
            myMealsContructor: MealzViewConfig.myMealsConfig
        )
        
        super.viewDidLoad()
    }
}

// i only use above because i want to use Storyboard
//let myMealsFeature = MealzMyMealsFeatureUIKit(
//    recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig,
//    myMealsContructor: MealzViewConfig.myMealsConfig
//)
