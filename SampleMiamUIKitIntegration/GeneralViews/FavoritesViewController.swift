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

var FavoritesPageRecipesListViewConfig = RecipesListViewConfig(
    recipesListColumns: 2,
    recipesListSpacing: 8,
    recipeCardDimensions: CGSize(width: 300, height: 300),
    recipeCardFillMaxWidth: true
)

class FavoritesViewController: UIViewController {
    deinit { print("deinit: FavoritesViewController") }
    // Your SwiftUI View
    var swiftUIView: FavoritesViewTemplate<
        DefaultFavoritesParams> {
        return FavoritesViewTemplate.init(
            params: DefaultFavoritesParams(
                showRecipes: { [weak self] _ in },
                noResultsRedirect: { [weak self] in },
                onRecipeTapped: { [weak self] recipeId in
                    guard let strongSelf = self else { return }
                    strongSelf.navigationController?.pushViewController(RecipeDetailsViewController(recipeId), animated: true)
                }),
            config: FavoritesPageRecipesListViewConfig
        )
    }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<FavoritesViewTemplate<
        DefaultFavoritesParams>>?

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
