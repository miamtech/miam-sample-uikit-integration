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
import miamCore

// simple function to share navigation between CatalogView & CatalogResultsView
public func sharedCatalogViewParams(navigationController: UINavigationController?) -> CatalogParameters {
    return CatalogParameters(
        onFiltersTapped: { filterInstance in
            navigationController?.pushViewController(FiltersViewController(filterInstance), animated: true)
        },
        onSearchTapped: { filterInstance in
            navigationController?.pushViewController(CatalogSearchViewController(filterInstance), animated: true)
        },
        onFavoritesTapped: {
            navigationController?.pushViewController(CatalogResultsViewController(), animated: true)
        },
        onPreferencesTapped: {
            navigationController?.pushViewController(PreferencesViewController(), animated: true)
        },
        onLaunchMealPlanner: {
            navigationController?.pushViewController(MealPlannerFormViewController(), animated: true)
        },
        onMealsInBasketButtonTapped: {
            navigationController?.pushViewController(MyMealsViewController(), animated: true)
        },
        viewOptions: CatalogViewOptions(useMealPlanner: true)
    )
}

class CatalogViewController: UIViewController {
    deinit { print("deinit: CatalogViewController") }
    // Your SwiftUI View
    var swiftUIView: CatalogView<
        CatalogParameters,
        CatalogPackageRowParameters> {
            return CatalogView.init(
                params: sharedCatalogViewParams(navigationController: self.navigationController),
                catalogPackageRowParams: CatalogPackageRowParameters(
                    onSeeAllRecipes: { [weak self] categoryId, categoryTitle in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.pushViewController(
                            CatalogResultsViewController(
                                categoryId,
                                categoryTitle: categoryTitle
                            ), animated: true)
                    },
                    onShowRecipeDetails: { [weak self] recipeId in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.pushViewController(RecipeDetailsViewController(recipeId), animated: true)
                    }, onRecipeCallToActionTapped: { [weak self] recipeId in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.pushViewController(MyMealsViewController(), animated: true)
                    },
                    viewOptions: CatalogPackageRowViewOptions(recipeCard: TypeSafeCatalogRecipeCard(MealzRecipeCard()))
                ),
                gridConfig: localRecipesListViewConfig
            )
        }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<CatalogView<
        CatalogParameters,
        CatalogPackageRowParameters>>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Catalog"
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
