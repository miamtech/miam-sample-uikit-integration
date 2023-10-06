//
//  CatalogViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 08/08/2023.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

// simple function to share navigation between CatalogView & CatalogResultsView
public func sharedCatalogViewParams(navigationController: UINavigationController?) -> DefaultCatalogViewParamsWithMealPlanner {
    return DefaultCatalogViewParamsWithMealPlanner(
        filtersTapped: {
            navigationController?.pushViewController(CatalogSearchViewController(), animated: true)
        },
        searchTapped: {
            navigationController?.pushViewController(CatalogSearchViewController(), animated: true)
        },
        favoritesTapped: {
            navigationController?.pushViewController(CatalogResultsViewController(), animated: true)
        },
        preferencesTapped: {
            navigationController?.pushViewController(PreferencesViewController(), animated: true)
        },
        launchMealPlanner: {
            navigationController?.pushViewController(MealPlannerFormViewController(), animated: true)
        },
        myMealsButtonTapped: {
            navigationController?.pushViewController(MyMealsViewController(), animated: true)
        })
}

class CatalogViewController: UIViewController {
    deinit { print("deinit: CatalogViewController") }
    // Your SwiftUI View
    var swiftUIView: CatalogViewTemplate<
        DefaultCatalogViewParamsWithMealPlanner,
        DefaultCatalogPackageRowParams> {
            return CatalogViewTemplate.init(
                params: sharedCatalogViewParams(navigationController: self.navigationController),
                catalogPackageRowParams: DefaultCatalogPackageRowParams(
                    showRecipes: { [weak self] in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.pushViewController(CatalogResultsViewController(), animated: true)
                    },
                    onRecipeTapped: { [weak self] recipeId in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.pushViewController(RecipeDetailsViewController(recipeId), animated: true)
                    }),
                config: MiamRecipesListViewConfig
            )
        }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<CatalogViewTemplate<
        DefaultCatalogViewParamsWithMealPlanner,
        DefaultCatalogPackageRowParams>>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Catalog"
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
