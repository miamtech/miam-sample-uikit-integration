//
//  MyMealsViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 02/10/2023.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework
import miamCore

var MyMealsBasketViewConfig = BasketRecipesViewConfig(
    recipesSpacing: 8.0,
    productsSpacing: 8.0,
    recipeOverviewDimensions: CGSize(width: 150, height: 150),
    isExpandable: true
)

class MyMealsViewController: UIViewController {
    
    deinit { print("deinit: MyMealsViewController") }
    // Your SwiftUI View
    var swiftUIView: MyMealsViewTemplate<
        DefaultBaseViewParams,
        BasketRecipeParameters
    > {
        return MyMealsViewTemplate.init(
            params: DefaultBaseViewParams(),
            basketRecipesParams: BasketRecipeParameters(
                onReplaceRecipe: { [weak self] in
                    // item selector
                },
                onShowRecipeDetails: { [weak self] recipeId in
                    guard let strongSelf = self else { return }
                    strongSelf.navigationController?.pushViewController(RecipeDetailsViewController(recipeId), animated: true)
            }),
            config: MyMealsBasketViewConfig
        )
    }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<MyMealsViewTemplate<
        DefaultBaseViewParams,
        BasketRecipeParameters>>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Meals"
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
