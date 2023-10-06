//
//  CatalogResultsViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 21/09/2023.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

var MiamRecipesListViewConfig = RecipesListViewConfig(
    recipesListColumns: 2,
    recipesListSpacing: 8,
    recipeCardDimensions: CGSize(width: 300, height: 380),
    recipeCardFillMaxWidth: true
)

class CatalogResultsViewController: UIViewController {
    deinit { print("deinit: CatalogViewController") }
    // Your SwiftUI View
    var swiftUIView: CatalogResultsViewTemplate<
        DefaultCatalogViewParamsWithMealPlanner,
        DefaultRecipesListParameters> {
            return CatalogResultsViewTemplate.init(
                params: sharedCatalogViewParams(navigationController: self.navigationController),
                recipesListParams: DefaultRecipesListParameters(
                    showRecipes: { [weak self] _ in },
                    noResultsRedirect: { [weak self] in },
                    onRecipeTapped: { [weak self] recipeId in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.pushViewController(RecipeDetailsViewController(recipeId), animated: true)
                    }),
                config: MiamRecipesListViewConfig
//                closeCatalogAction: { [weak self] in
//                    guard let strongSelf = self else { return }
//                    strongSelf.navigationController?.popViewController(animated: true)
//                }
            )
        }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<CatalogResultsViewTemplate<
        DefaultCatalogViewParamsWithMealPlanner,
        DefaultRecipesListParameters>>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Results"
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


