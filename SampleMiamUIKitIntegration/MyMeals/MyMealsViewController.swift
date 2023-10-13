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

var myMealsBasketViewConfig = BasketRecipesGridConfig(
    recipeHorizontalSpacing: 6.0,
    recipeVerticalSpacing: 6.0,
    productHorizontalSpacing: 6.0,
    productVerticalSpacing: 6.0,
    recipeOverviewDimensions: CGSize(width: 300, height: 150),
    isExpandable: true)

class MyMealsViewController: UIViewController {
    
    deinit { print("deinit: MyMealsViewController") }
    // Your SwiftUI View
    var swiftUIView: MyMealsViewTemplate<
        MyMealsParameters,
        BasketRecipeParameters
    > {
        return MyMealsViewTemplate.init(
            params: MyMealsParameters(
                onNoResultsRedirect: { [weak self] in
                
                }
            ),
            basketRecipesParams: BasketRecipeParameters(
                onReplaceProduct: { [weak self] recipeId in
                    guard let strongSelf = self else { return }
                    strongSelf.navigationController?.pushViewController(ItemSelectorViewController(recipeId), animated: true)
                },
                onShowRecipeDetails: { [weak self] recipeId in
                    guard let strongSelf = self else { return }
                    strongSelf.navigationController?.pushViewController(RecipeDetailsViewController(recipeId), animated: true)
            }),
            gridConfig: myMealsBasketViewConfig
        )
    }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<MyMealsViewTemplate<
        MyMealsParameters,
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
