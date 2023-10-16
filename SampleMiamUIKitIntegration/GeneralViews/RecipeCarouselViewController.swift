//
//  RecipeCarouselViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 16/10/2023.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework
import miamCore

public var localRecipesCarouselViewConfig = RecipesCarouselGridConfig(
    rows: 2,
    horizontalSpacing: 6,
    verticalSpacing: 6,
    recipeCardDimensions: CGSize(width: 200, height: 300))

class RecipeCarouselViewController: UIViewController {
    public let productId: String?
    public let criteria: SuggestionsCriteria?
    public let numberOfResults: Int
    
    init(
        productId: String? = nil,
        criteria: SuggestionsCriteria? = nil,
        numberOfResults: Int
    ) {
        self.productId = productId
        self.criteria = criteria
        self.numberOfResults = numberOfResults
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit { print("deinit: RecipeCarouselViewController") }
    
    // Your SwiftUI View
    var swiftUIView: RecipeCarousel<
        RecipeCarouselParameters
    > {
        return RecipeCarousel.init(
            params: RecipeCarouselParameters(
                onNoResultsRedirect: { [weak self] in },
                onShowRecipeDetails: { [weak self] recipeId in
                    guard let strongSelf = self else { return }
                    strongSelf.navigationController?.pushViewController(RecipeDetailsViewController(recipeId), animated: true)
                }, onRecipeCallToActionTapped: { [weak self] recipeId in
                    guard let strongSelf = self else { return }
                    strongSelf.navigationController?.pushViewController(MyMealsViewController(), animated: true)
                }),
            gridConfig: localRecipesCarouselViewConfig,
            productId: productId,
            criteria: criteria,
            numberOfResults: numberOfResults
            )
    }
    
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<RecipeCarousel<
        RecipeCarouselParameters
>>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recipe Carousel"
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
