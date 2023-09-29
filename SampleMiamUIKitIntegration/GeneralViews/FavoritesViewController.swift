//
//  FavoritesViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 25/09/2023.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework
import miamCore

/// This sets the Templates for the Favorites Overview
public class MiamNeutralFavoritesParams: FavoritesViewParameters {
    weak var navigationController: UINavigationController?
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    public lazy var showRecipes: (MiamIOSFramework.CatalogPackage) -> Void = {[weak self] _ in}
    public lazy var noResultsRedirect: () -> Void = {[weak self] in}
    public lazy var onRecipeTapped: (String) -> Void = { [weak self] recipe in
        UserDefaults.standard.set(recipe, forKey: "miam_catalog_recipeId")
        guard let strongSelf = self else { return }
        strongSelf.navigationController?.pushViewController(MealPlannerRecipeDetailsViewController(), animated: true)
    }
}

var FavoritesPageRecipesListViewConfig = RecipesListViewConfig(
    recipesListColumns: 2,
    recipesListSpacing: 8,
    recipeCardDimensions: CGSize(width: 300, height: 300),
    recipeCardFillMaxWidth: true
)

class FavoritesViewController: UIViewController {
    
    deinit {
        print("deinit: FavoritesViewController is being deallocated")
    }
    // Your SwiftUI View
    var swiftUIView: FavoritesViewTemplate<
        MiamNeutralFavoritesParams> {
        return FavoritesViewTemplate.init(
            params: MiamNeutralFavoritesParams(navigationController: self.navigationController),
            config: FavoritesPageRecipesListViewConfig
        )
    }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<FavoritesViewTemplate<
        MiamNeutralFavoritesParams>>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
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
