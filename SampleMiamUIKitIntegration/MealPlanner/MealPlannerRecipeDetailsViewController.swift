//
//  MealPlannerRecipeDetailsViewController.swift
//  SampleUIKitIntegration
//
//  Created by didi on 7/6/23.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

class MealPlannerRecipeDetailsViewController: UIViewController {
    deinit {
        print("deinit: MealPlannerRecipeDetailsViewController is being deallocated")
    }
    let recipeId = UserDefaults.standard.value(forKey: "miam_catalog_recipeId") as? String ?? ""
    // Your SwiftUI View
    var swiftUIView: RecipeDetailsViewTemplate<
        MiamNeutralRecipeDetailsHeaderView,
        MiamNeutralRecipeDetailsIngredientsView,
        MiamNeutralRecipeDetailsStepsView,
        MiamNeutralRecipeDetailsFooterView
    > {
        return RecipeDetailsViewTemplate.init(
            headerContent: MiamNeutralRecipeDetailsHeaderView(),
            ingredientsContent: MiamNeutralRecipeDetailsIngredientsView(),
            stepsContent: MiamNeutralRecipeDetailsStepsView(),
            footerContent: MiamNeutralRecipeDetailsFooterView(),
            recipeId: recipeId,
            isForMealPlanner: true,
            sponsorDetailsTapped: { [weak self] sponsor in
                guard let strongSelf = self else { return }
                strongSelf.navigationController?.pushViewController(SponsorDetailsViewController(sponsor: sponsor), animated: true)
            },
            close: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.navigationController?.popViewController(animated: true)
            })
    }
    
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<RecipeDetailsViewTemplate<
        MiamNeutralRecipeDetailsHeaderView,
        MiamNeutralRecipeDetailsIngredientsView,
        MiamNeutralRecipeDetailsStepsView,
        MiamNeutralRecipeDetailsFooterView
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
