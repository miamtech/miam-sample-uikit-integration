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

class MealPlannerViewController: UIViewController {
    deinit {
        print("deinit: MealPlannerViewController is being deallocated")
    }
    // Your SwiftUI View
    var swiftUIView: MealPlannerPlannerView<
        MiamNeutralMealPlannerToolbar, MiamNeutralMealPlannerStickyFooter, MiamBudgetPlannerLoading, MiamBudgetPlannerEmpty, MiamNeutralMealPlannerRecipeCard, MiamNeutralMealPlannerRecipeCardLoading, MiamNeutralMealPlannerRecipePlaceholder
    > {
        return MealPlannerPlannerView(
            toolbarTemplate: MiamNeutralMealPlannerToolbar(),
            footerTemplate: MiamNeutralMealPlannerStickyFooter(),
            loadingTemplate: MiamBudgetPlannerLoading(),
            emptyTemplate: MiamBudgetPlannerEmpty(),
            recipeCardTemplate: MiamNeutralMealPlannerRecipeCard(),
            loadingCardTemplate: MiamNeutralMealPlannerRecipeCardLoading(),
            placeholderCardTemplate: MiamNeutralMealPlannerRecipePlaceholder(),
            showRecipe: { [weak self] recipeId in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    strongSelf.navigationController?.pushViewController(RecipeDetailsViewController(recipeId), animated: true)
                }
            },
            validateRecipes: { [weak self] in
                DispatchQueue.main.async {
                    guard let strongSelf = self else { return }
                    strongSelf.navigationController?.pushViewController(MealPlannerBasketPreviewViewController(), animated: true)
                }
            },
            replaceRecipe: { [weak self] _ in
                DispatchQueue.main.async {
                    guard let strongSelf = self else { return }
                    strongSelf.navigationController?.pushViewController(MealPlannerReplaceMealViewController(), animated: true)
                }
            })
    }
    
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<MealPlannerPlannerView<
        MiamNeutralMealPlannerToolbar, MiamNeutralMealPlannerStickyFooter, MiamBudgetPlannerLoading, MiamBudgetPlannerEmpty, MiamNeutralMealPlannerRecipeCard, MiamNeutralMealPlannerRecipeCardLoading, MiamNeutralMealPlannerRecipePlaceholder
>>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mon assistant Budget repas"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Retour", style: .plain, target: nil, action: nil)
        // Initialize the hosting controller with your SwiftUI view
        hostingController = UIHostingController(rootView: swiftUIView)
        guard let hostingController = hostingController, let hcView = hostingController.view
        else { return }
        // Since hostingController is optional, using guard to safely unwrap its view
        hcView.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostingController)
        view.addSubview(hcView)
        NSLayoutConstraint.activate([
            hcView.topAnchor.constraint(equalTo: view.topAnchor),
            hcView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hcView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hcView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
}
