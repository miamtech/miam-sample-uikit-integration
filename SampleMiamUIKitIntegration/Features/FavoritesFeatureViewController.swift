//
//  FavoritesFeatureViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by Diarmuid McGonagle on 06/03/2024.
//

import UIKit
import MealzNavModuleIOS

class FavoritesFeatureViewController: AbstractMealzViewController {
    
    override func viewDidLoad() {
        feature = MealzFavoritesFeatureUIKit(
            hideTitles: true,
            recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig,
            favoritesFeatureConstructor: MealzViewConfig.favoritesConfig
        )
        
        super.viewDidLoad()
    }
}

// i only use above because i want to use Storyboard
//let favoritesFeature = MealzFavoritesFeatureUIKit(
//recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig,
//favoritesFeatureConstructor: MealzViewConfig.favoritesConfig
//)
