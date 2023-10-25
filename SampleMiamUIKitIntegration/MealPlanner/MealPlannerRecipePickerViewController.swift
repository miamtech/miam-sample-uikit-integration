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
    public let indexOfRecipe: Int
    
    init(_ indexOfRecipe: Int) {
        self.indexOfRecipe = indexOfRecipe
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit { print("deinit: MealPlannerRecipePickerViewController") }
    // Your SwiftUI View
    var swiftUIView: MealPlannerRecipePicker<
        MealPlannerRecipePickerParameters> {
        return MealPlannerRecipePicker(
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
            gridConfig: localRecipesListViewConfig,
            indexOfReplacedRecipe: indexOfRecipe)
            
    }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<MealPlannerRecipePicker<
        MealPlannerRecipePickerParameters>>?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Mon assistant Budget repas"
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
