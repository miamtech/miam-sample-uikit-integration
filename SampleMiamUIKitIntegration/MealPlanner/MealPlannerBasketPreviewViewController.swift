//
//  BasketPreviewViewController.swift
//  SampleUIKitIntegration
//
//  Created by didi on 6/21/23.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

class MealPlannerBasketPreviewViewController: UIViewController {
    deinit {
        print("deinit: MealPlannerBasketPreviewViewController is being deallocated")
    }
    // Your SwiftUI View
    var swiftUIView: MealPlannerBasketPreviewView<
        MiamNeutralMealPlannerBasketPreviewLoading,
        MiamNeutralMealPlannerBasketPreviewRecipeOverview,
        MiamNeutralMealPlannerRecipeCardLoading,
        MiamNeutralMealPlannerBasketPreviewProduct,
        MiamNeutralMealPlannerBasketPreviewFooter,
        MiamNeutralMealPlannerBasketPreviewSectionTitle,
        MiamNeutralMealPlannerBasketPreviewSectionProduct
    > {
        return MealPlannerBasketPreviewView.init(
            loadingTemplate: MiamNeutralMealPlannerBasketPreviewLoading(),
            recipeOverviewTemplate: MiamNeutralMealPlannerBasketPreviewRecipeOverview(),
            recipeLoadingTemplate: MiamNeutralMealPlannerRecipeCardLoading(),
            productTemplate: MiamNeutralMealPlannerBasketPreviewProduct(),
            footerTemplate: MiamNeutralMealPlannerBasketPreviewFooter(),
            sectionTitleTemplate: MiamNeutralMealPlannerBasketPreviewSectionTitle(),
            sectionProductTemplate: MiamNeutralMealPlannerBasketPreviewSectionProduct(),
            replaceProduct: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.navigationController?.pushViewController(ItemSelectorViewController(), animated: true)
            },
            continueShopping: { [weak self] in },
            showBasket: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.navigationController?.pushViewController(MealPlannerRecapPurchaseViewController(), animated: true)
            },
            onRecipeTapped: { [weak self] recipeId in
                guard let strongSelf = self else { return }
                strongSelf.navigationController?.pushViewController(RecipeDetailsViewController(recipeId), animated: true)
            }
        )
    }
    
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<MealPlannerBasketPreviewView<
        MiamNeutralMealPlannerBasketPreviewLoading,
        MiamNeutralMealPlannerBasketPreviewRecipeOverview,
        MiamNeutralMealPlannerRecipeCardLoading,
        MiamNeutralMealPlannerBasketPreviewProduct,
        MiamNeutralMealPlannerBasketPreviewFooter,
        MiamNeutralMealPlannerBasketPreviewSectionTitle,
        MiamNeutralMealPlannerBasketPreviewSectionProduct
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
