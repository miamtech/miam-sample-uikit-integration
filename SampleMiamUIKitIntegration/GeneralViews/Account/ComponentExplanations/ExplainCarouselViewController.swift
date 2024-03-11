//
//  ExplainCarouselViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 20/10/2023.
//

import UIKit
import MiamIOSFramework
import SwiftUI
import miamCore
import MealzNavModuleIOS

class ExplainCarouselViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var productStackView: UIStackView!
    var criteriaStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title of the ViewController
        navigationItem.title = "Recipe Carousel"
        
        // Set the view's background color
        self.view.backgroundColor = .white
        
        
        // Initialize and setup the scrollView
            scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(scrollView)
        
        // Constraints for scrollView
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
        
        productStackView = setupProductUI()
        criteriaStackView = setupCriteriaUI()
        
        // Create a vertical stack view to layout the label and buttons
        let stackView = UIStackView(arrangedSubviews: [productStackView, criteriaStackView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        // Layout constraints for the stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20), // Left padding
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20), // Right padding
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -40) // Adjust width for padding
        ])
    }
    
    func setupProductUI() -> UIStackView {
        let productTitle = createLabel(text: "By Product", alignment: .center, fontSize: 24, isBold: true)
        self.view.addSubview(productTitle)
        
        let productText = createLabel(text: "Passing a ``productId`` to the Recipe Carousel is when you would like to generate recipes for one particular product (ingredient). For example, if the user is on 'cream' & you would like to show recipe suggestions, you would pass in the productId of the cream product.\nThe Recipe Carousel can also have multiple rows, based on your configuration", alignment: .left, fontSize: 16)
        productText.textColor = UIColor(Color.mealzColor(.standardDarkText))
        self.view.addSubview(productText)
        
        let productExampleText = createLabel(text: "Here are some examples for Mozzarella:", alignment: .center, fontSize: 16, isBold: true)
        self.view.addSubview(productExampleText)
        
        let productButtonOne = createButton(withTitle: "One") { [weak self] in
            self?.navigateProduct()
        }
        
        let productButtonTwo = createButton(withTitle: "Two") { [weak self] in
            let gridConfig = RecipesCarouselGridConfig(
                numberOfRows: 2,
                spacing: CGSize(width: 6, height: 6),
                recipeCardDimensions: CGSize(width: 200, height: 260))
            self?.navigateProduct(withGridConfig: gridConfig)
        }
        
        let productButtonThree = createButton(withTitle: "Three") { [weak self] in
            let gridConfig = RecipesCarouselGridConfig(
                numberOfRows: 3,
                spacing: CGSize(width: 6, height: 6),
                recipeCardDimensions: CGSize(width: 200, height: 200))
            self?.navigateProduct(withGridConfig: gridConfig)
        }
        
        // Create a horizontal stack view to layout buttons
        let productButtons = UIStackView(arrangedSubviews: [productButtonOne, productButtonTwo, productButtonThree])
        productButtons.axis = .horizontal
        productButtons.spacing = 10
        productButtons.translatesAutoresizingMaskIntoConstraints = false
        productButtons.distribution = .fillEqually
        self.view.addSubview(productButtons)
        
        // Create a vertical stack view to layout the label and buttons
        let productStackView = UIStackView(arrangedSubviews: [productTitle, productText, productExampleText, productButtons])
        productStackView.axis = .vertical
        productStackView.spacing = 10
        productStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(productStackView)
        return productStackView
    }
    
    func setupCriteriaUI() -> UIStackView {
        let criteriaTitle = createLabel(text: "By Criteria", alignment: .center, fontSize: 24, isBold: true)
        self.view.addSubview(criteriaTitle)
        
        let criteriaText = createLabel(text: "Passing a critera of ``SuggestionsCriteria`` object to the Recipe Carousel is when you would like to generate recipes for the products that are curently on the user's page. For example, if they are searching your catalog & are on a page of 'produce,' then all the productIds of the product should be passed in. With this, all the recipes returned will be associated with this produce.", alignment: .left, fontSize: 16)
        criteriaText.textColor = UIColor(Color.miamColor(.primaryDark))
        self.view.addSubview(criteriaText)
        
        let criteriaExampleText = createLabel(text: "Here are some examples for Chicken products (notice Chicken breasts, wings, entire chickens, etc):", alignment: .center, fontSize: 14, isBold: true)
        self.view.addSubview(criteriaExampleText)
        
        let criteriaButtonOne = createButton(withTitle: "One") { [weak self] in
            self?.navigateCritera()
        }
        
        let criteriaButtonTwo = createButton(withTitle: "Two") { [weak self] in
            let gridConfig = RecipesCarouselGridConfig(
                numberOfRows: 2,
                spacing: CGSize(width: 6, height: 6),
                recipeCardDimensions: CGSize(width: 200, height: 260))
            self?.navigateCritera(withGridConfig: gridConfig)
        }
        
        let criteriaButtonThree = createButton(withTitle: "Three") { [weak self] in
            let gridConfig = RecipesCarouselGridConfig(
                numberOfRows: 3,
                spacing: CGSize(width: 6, height: 6),
                recipeCardDimensions: CGSize(width: 200, height: 200))
            self?.navigateCritera(withGridConfig: gridConfig)
        }
        
        // Create a horizontal stack view to layout buttons
        let criteriaButtons = UIStackView(arrangedSubviews: [criteriaButtonOne, criteriaButtonTwo, criteriaButtonThree])
        criteriaButtons.axis = .horizontal
        criteriaButtons.spacing = 10
        criteriaButtons.translatesAutoresizingMaskIntoConstraints = false
        criteriaButtons.distribution = .fillEqually
        self.view.addSubview(criteriaButtons)
        
        // Create a vertical stack view to layout the label and buttons
        let criteriaStackView = UIStackView(arrangedSubviews: [criteriaTitle, criteriaText, criteriaExampleText, criteriaButtons])
        criteriaStackView.axis = .vertical
        criteriaStackView.spacing = 10
        criteriaStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(criteriaStackView)
        return criteriaStackView
    }
    
    func createLabel(text: String, alignment: NSTextAlignment, fontSize: CGFloat, isBold: Bool = false) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = alignment
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        return label
    }
    
    // Refactored navigation function
    func navigateProduct(withGridConfig gridConfig: RecipesCarouselGridConfig = RecipesCarouselGridConfig()) {
        let vc = MealzRecipeCarouselFeatureUIKit(
            productId: "239658", numberOfResults: 10,
            recipeCarouselFeatureConstructor: RecipeCarouselFeatureConstructor(
                recipesCarouselGridConfig: gridConfig))
        self.navigationController?.present(vc, animated: true)
    }
    // Refactored navigation function
    func navigateCritera(withGridConfig gridConfig: RecipesCarouselGridConfig = RecipesCarouselGridConfig()) {
        let criteria = SuggestionsCriteria(shelfIngredientsIds: nil, currentIngredientsIds: ["5319173", "53755728", "53755778", "53755841", "53755837"], basketIngredientsIds: nil, groupId: nil)
        let vc = MealzRecipeCarouselFeatureUIKit(
            criteria: criteria, numberOfResults: 10,
            recipeCarouselFeatureConstructor: RecipeCarouselFeatureConstructor(
                recipesCarouselGridConfig: gridConfig))
        self.navigationController?.present(vc, animated: true)
    }

    // Refactored button creation function to accept a closure
    func createButton(withTitle title: String, action: @escaping () -> Void) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.addAction(UIAction(handler: { _ in
            action()
        }), for: .touchUpInside)
        return button
    }
}

