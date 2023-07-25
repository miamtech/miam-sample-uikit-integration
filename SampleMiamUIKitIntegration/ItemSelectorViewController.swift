//
//  ItemSelectorViewController.swift
//  SampleUIKitIntegration
//
//  Created by didi on 7/4/23.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

class ItemSelectorViewController: UIHostingController<ItemSelector> {

   required init?(coder aDecoder: NSCoder) {
//            let itemSelector = ItemSelector(recipeId: "", onItemSelected: {})
            super.init(coder: aDecoder)
        }

        override init(rootView: ItemSelector) {
            super.init(rootView: rootView)
        }

        public init() {
            let itemSelector = ItemSelector(recipeId: "", onItemSelected: {})
            super.init(rootView: itemSelector)
        }

        override func viewDidLoad() {
            let recipeId = UserDefaults.standard.value(forKey: "miam_mealplanner_recipeId") as? String ?? ""

            super.viewDidLoad()
            self.title = "Mon assistant Budget repas"
            let itemSelector = ItemSelector(recipeId: recipeId, onItemSelected: {
                // added small delay to ensure image reloads 
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400)) {
                    self.navigationController?.popViewController(animated: true)
                }
            })
            self.rootView = itemSelector
            // Do any additional setup after loading the view.
        }
    }
