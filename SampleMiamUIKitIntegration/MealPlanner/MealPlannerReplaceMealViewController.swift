//
//  ReplaceMealViewController.swift
//  SampleUIKitIntegration
//
//  Created by didi on 6/21/23.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework


// This view Controller is implemented in a static manner because when I was popping the view off, it was always firing twice.
// My experience in UIKit is not great, so this is the solution I found that worked. You will probably have a better way
// to handle this
// TODO: add MiamNeutralRecipeCard
class MealPlannerReplaceMealViewController: UIHostingController<MealPlannerRecipePickerView<
        MiamNeutralMealPlannerSearch,
        MiamRecipeCard>
> {

    var onRecipeSelectedAction: ((String) -> Void)?
    var isPoppingViewController = false
    var onRecipeTappedAction: ((String) -> Void)?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: MealPlannerReplaceMealViewController.createRootView(onRecipeTapped: onRecipeTappedAction))
        setupRecipeSelectedAction()
        setupOnRecipeTappedAction()
    }

    override init(rootView: MealPlannerRecipePickerView<
          MiamNeutralMealPlannerSearch,
          MiamRecipeCard>) {
        super.init(rootView: MealPlannerReplaceMealViewController.createRootView(onRecipeTapped: onRecipeTappedAction))
        setupRecipeSelectedAction()
        setupOnRecipeTappedAction()
    }

    public init() {
        super.init(rootView: MealPlannerReplaceMealViewController.createRootView(onRecipeTapped: onRecipeTappedAction))
        setupRecipeSelectedAction()
        setupOnRecipeTappedAction()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ajouter une idée repas"
        self.rootView = MealPlannerReplaceMealViewController.createRootView(onRecipeSelected: onRecipeSelectedAction, onRecipeTapped: onRecipeTappedAction)
    }

    private static func createRootView(onRecipeSelected: ((String) -> Void)? = nil, onRecipeTapped: ((String) -> Void)? = nil) -> MealPlannerRecipePickerView<
            MiamNeutralMealPlannerSearch,
            MiamRecipeCard> {
        return MealPlannerRecipePickerView(
            searchTemplate: MiamNeutralMealPlannerSearch(),
            cardTemplate: MiamRecipeCard(), maxBudget: 23.2,
            onRecipeSelected: onRecipeSelected ?? { _ in },
            onRecipeTapped: onRecipeTapped ?? { _ in }
        )
    }

    private func setupRecipeSelectedAction() {
        onRecipeSelectedAction = { _ in
            DispatchQueue.main.async { [weak self] in
                // because its popping 2 screens at a time
                guard let self = self, !self.isPoppingViewController else { return }
                self.isPoppingViewController = true
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func setupOnRecipeTappedAction() {
        onRecipeTappedAction = { recipe in
            UserDefaults.standard.set(recipe, forKey: "miam_mealplanner_recipeId")
            DispatchQueue.main.async { [weak self] in
                self?.navigationController?.pushViewController(MealPlannerRecipeDetailsViewController(), animated: true)
            }
        }
    }
}
