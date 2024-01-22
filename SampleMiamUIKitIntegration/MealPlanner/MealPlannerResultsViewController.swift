//
//  MealPlannerResultsViewController.swift
//  SampleUIKitIntegration
//
//  Created by didi on 6/21/23.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MealzUIModuleIOS

class MealPlannerResultsViewController: UIViewController {
    deinit { print("deinit: MealPlannerResultsViewController") }
    // Your SwiftUI View
    var swiftUIView: MealPlannerResults<
        MealPlannerResultsParameters,
        BasePageViewParameters
    > {
        return MealPlannerResults(
            params:
                MealPlannerResultsParameters(
                    actions: MealPlannerResultsActions(
                        onShowRecipeDetails: { [weak self] recipeId in
                            guard let strongSelf = self else { return }
                            strongSelf.navigationController?.pushViewController(RecipeDetailsViewController(recipeId, isForMealPlanner: true), animated: true)
                        },
                        onOpenReplaceRecipe: { [weak self] indexOfRecipe in
                            guard let strongSelf = self else { return }
                            strongSelf.navigationController?.pushViewController(MealPlannerRecipePickerViewController(indexOfRecipe), animated: true)
                        },
                        onNavigateToBasket: {[weak self] in
                            guard let strongSelf = self else { return }
                            strongSelf.navigationController?.pushViewController(MealPlannerBasketViewController(), animated: true)
                        })
                ),
            baseViews: BasePageViewParameters(),
            gridConfig: MealPlannerRecipesListGridConfig(
                spacing: CGSize(width: 0, height: 0),
                recipeCardDimensions: CGSize(width: 300, height: 200)))
    }
    
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<MealPlannerResults<
        MealPlannerResultsParameters,
        BasePageViewParameters
    >>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Mon assistant Budget repas"
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
