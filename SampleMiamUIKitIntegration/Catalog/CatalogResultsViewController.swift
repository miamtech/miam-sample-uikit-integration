//
//  CatalogResultsViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 21/09/2023.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MealzUIModuleIOS

public var localRecipesListViewConfig = CatalogRecipesListGridConfig(
    numberOfColumns: 2,
    spacing: CGSize(width: 6, height: 6),
    recipeCardDimensions: CGSize(width: 300, height: 340),
    recipeCardFillMaxWidth: true)

class CatalogResultsViewController: UIViewController {
    public let categoryId: String?
    public let categoryTitle: String?
    
    init(_ categoryId: String? = nil, categoryTitle: String? = nil) {
        self.categoryId = categoryId
        self.categoryTitle = categoryTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit { print("deinit: CatalogResultsViewController") }
    // Your SwiftUI View
    var swiftUIView: CatalogResults<
        CatalogParameters,
        CatalogRecipesListParameters,
        BaseViewParameters
    > {
            return CatalogResults(
                params: sharedCatalogViewParams(navigationController: self.navigationController),
                recipesListParams: CatalogRecipesListParameters(
                    onNoResultsRedirect: { [weak self] in },
                    onShowRecipeDetails: { [weak self] recipeId in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.pushViewController(RecipeDetailsViewController(recipeId), animated: true)
                    },
                    onRecipeCallToActionTapped: { [weak self] recipeId in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.pushViewController(MyMealsViewController(), animated: true)
                    }
                ),
                baseViews: BaseViewParameters(),
                categoryId: categoryId,
                title: categoryTitle,
                gridConfig: localRecipesListViewConfig
            )
        }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<CatalogResults<
        CatalogParameters,
        CatalogRecipesListParameters,
        BaseViewParameters
    >>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Results"
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


