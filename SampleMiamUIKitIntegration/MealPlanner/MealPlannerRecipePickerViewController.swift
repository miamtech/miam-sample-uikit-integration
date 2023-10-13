//
//  MealPlannerRecipePickerViewController.swift
//  SampleUIKitIntegration
//
//  Created by didi on 6/21/23.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

class MealPlannerRecipePickerViewController: UIViewController {
    deinit { print("deinit: MealPlannerRecipePickerViewController") }
    // Your SwiftUI View
    var swiftUIView: MealPlannerRecipePickerView<
        MealPlannerRecipePickerParameters> {
        return MealPlannerRecipePickerView(
            params:
                MealPlannerRecipePickerParameters(
                    onShowRecipeDetails: { [weak self] recipeId in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.pushViewController(RecipeDetailsViewController(
                            recipeId,
                            isForMealPlanner: true
                        ), animated: true)
                    },
                    onSelectRecipeForMealPlanner: { [weak self] _ in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.popViewController(animated: true)
                },
                    onOpenFiltersOptions: { [weak self] filtersInstance in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.pushViewController(
                            FiltersViewController(filtersInstance), animated: true)
                }),
            gridConfig: localRecipesListViewConfig)
            
    }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<MealPlannerRecipePickerView<
        MealPlannerRecipePickerParameters>>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mon assistant Budget repas"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Retour", style: .plain, target: nil, action: nil)
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
