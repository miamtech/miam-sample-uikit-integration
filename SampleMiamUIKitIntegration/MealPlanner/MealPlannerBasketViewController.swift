//
//  MealPlannerBasketViewController.swift
//  SampleUIKitIntegration
//
//  Created by didi on 6/21/23.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

public var localBasketGridConfig = BasketRecipesGridConfig(
    recipeHorizontalSpacing: 6,
    recipeVerticalSpacing: 6,
    productHorizontalSpacing: 6,
    productVerticalSpacing: 6,
    recipeOverviewDimensions: CGSize(width: 300, height: 150),
    isExpandable: true)

class MealPlannerBasketViewController: UIViewController {
    deinit { print("deinit: MealPlannerBasketViewController") }
    // Your SwiftUI View
    var swiftUIView: MealPlannerBasketView<
        MealPlannerBasketParameters,
        BasketRecipeParameters
    > {
        return MealPlannerBasketView(
            params: MealPlannerBasketParameters(
                onNavigateToRecap: { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.navigationController?.pushViewController(MealPlannerRecapPurchaseViewController(), animated: true)
                },
                onNavigateToBasket: { [weak self] in }),
            basketRecipesParams: BasketRecipeParameters(
                onReplaceProduct: { [weak self] recipeId in
                    guard let strongSelf = self else { return }
                    strongSelf.navigationController?.pushViewController(ItemSelectorViewController(recipeId), animated: true)
                },
                onShowRecipeDetails: { [weak self] recipeId in
                    guard let strongSelf = self else { return }
                    strongSelf.navigationController?.pushViewController(RecipeDetailsViewController(recipeId), animated: true)
                }),
            gridConfig: localBasketGridConfig
        )
    }
    
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<MealPlannerBasketView<
        MealPlannerBasketParameters,
        BasketRecipeParameters
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
