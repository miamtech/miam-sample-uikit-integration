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

/// This sets the Templates for the CatalogRecipesList Overview
public class MiamNeutralRecipesListParams: RecipesListViewParameters {
    weak var navigationController: UINavigationController?
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    public lazy var showRecipes: (MiamIOSFramework.CatalogPackage) -> Void = {[weak self] _ in}
    public lazy var noResultsRedirect: () -> Void = {[weak self] in}
    public lazy var onRecipeTapped: (String) -> Void = { [weak self] recipeId in
        guard let strongSelf = self else { return }
        strongSelf.navigationController?.pushViewController(RecipeDetailsViewController(recipeId), animated: true)
    }
}

var MiamRecipesListViewConfig = RecipesListViewConfig(
    recipesListColumns: 2,
    recipesListSpacing: 8,
    recipeCardDimensions: CGSize(width: 300, height: 380),
    recipeCardFillMaxWidth: true
)

class CatalogResultsViewController: UIViewController {
    deinit {
        print("deinit: CatalogViewController is being deallocated")
    }
    // Your SwiftUI View
    var swiftUIView: CatalogResultsViewTemplate<
        MiamNeutralCatalogViewParams,
        MiamNeutralRecipesListParams> {
            return CatalogResultsViewTemplate.init(
                params: MiamNeutralCatalogViewParams(navigationController: self.navigationController),
                recipesListParams: MiamNeutralRecipesListParams(navigationController: self.navigationController),
                config: MiamRecipesListViewConfig
//                closeCatalogAction: { [weak self] in
//                    guard let strongSelf = self else { return }
//                    strongSelf.navigationController?.popViewController(animated: true)
//                }
            )
        }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<CatalogResultsViewTemplate<
        MiamNeutralCatalogViewParams,
        MiamNeutralRecipesListParams>>?
    
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


