//
//  MealViewController.swift
//  SampleUIKitIntegration
//
//  Created by Vincent Kergonna on 12/07/2022.
//

import UIKit
import SwiftUI
import MiamIOSFramework

class MealViewController: UIHostingController<MyMealsView> {
    // Initialize our controller with RecipeCardView as a root view and show
    // recipe 1.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: MyMealsView())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor.blue
        navigationController?.navigationBar.backgroundColor = UIColor.yellow
        navigationController?.navigationBar.backItem?.title = ""
    }
}
