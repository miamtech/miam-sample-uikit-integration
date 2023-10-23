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
    recipeSpacing: CGSize(width: 5, height: 5),
    productSpacing: CGSize(width: 6, height: 6),
    recipeOverviewDimensions: CGSize(width: 300, height: 150),
    isExpandable: true)

class MyMealsViewController: UIViewController {
    
    deinit { print("deinit: MyMealsViewController") }
    // Your SwiftUI View
    var swiftUIView: MyMeals<
        MyMealsParameters,
        BasketRecipeParameters
    > {
        return MyMeals.init(
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
    private var hostingController: UIHostingController<MyMeals<
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
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0/255, green: 85/255, blue: 98/255, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor.white
    }
}
