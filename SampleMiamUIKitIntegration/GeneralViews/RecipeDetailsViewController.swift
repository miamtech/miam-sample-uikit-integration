//
//  RecipeDetailsViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 05/10/2023.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MealzUIModuleIOS
import miamCore

class RecipeDetailsViewController: UIViewController {
    public let recipeId: String
    public let isForMealPlanner: Bool
    
    init(_ recipeId: String, isForMealPlanner: Bool = false) {
        self.recipeId = recipeId
        self.isForMealPlanner = isForMealPlanner
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit { print("deinit: RecipeDetailsViewController") }
    
    // Your SwiftUI View
    var swiftUIView: RecipeDetails<
        RecipeDetailParameters,
        RecipeDetailsProductParameters,
        BasePageViewParameters
    > {
        return RecipeDetails.init(
            params: RecipeDetailParameters(
                actions: RecipeDetailsActions(
                    onClosed: { [weak self] in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.popViewController(animated: true)
                    },
                    onSponsorDetailsTapped: { [weak self] sponsor in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.pushViewController(SponsorDetailsViewController(sponsor: sponsor), animated: true)
                    },
                    onContinueToBasket: { [weak self] in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.pushViewController(MyMealsViewController(), animated: true)
                    },
                    onReplaceProduct: { [weak self] ingredientId in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.pushViewController(ItemSelectorViewController(ingredientId: ingredientId), animated: true)
                    }
                )
            ),
            productParams: RecipeDetailsProductParameters(),
            baseViews: BasePageViewParameters(),
            recipeId: recipeId,
            isForMealPlanner: isForMealPlanner)
    }
    
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<RecipeDetails<
        RecipeDetailParameters,
        RecipeDetailsProductParameters,
        BasePageViewParameters
    >>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Recipe Details"
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
