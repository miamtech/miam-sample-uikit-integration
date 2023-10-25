//
//  ExplainCarouselViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 20/10/2023.
//

import UIKit
import MiamIOSFramework
import SwiftUI

class ExplainCarouselViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title of the ViewController
        self.title = "Recipe Carousel"
        
        // Set the view's background color
        self.view.backgroundColor = .white
        
        let productTitle = createLabel(text: "By Product", alignment: .center, fontSize: 24, isBold: true)
        self.view.addSubview(productTitle)
        
        let productText = createLabel(text: "Passing a ``productId`` to the Recipe Carousel is when you would like to generate recipes for one particular product (ingredient). For example, if the user is on 'cream' & you would like to show recipe suggestions, you would pass in the productId of the cream product.\nThe Recipe Carousel can also have multiple rows, based on your configuration", alignment: .left, fontSize: 16)
        productText.textColor = UIColor(Color.miamColor(.primaryDark))
        self.view.addSubview(productText)
        
        let productExampleText = createLabel(text: "Here are some examples for Mozzarella:", alignment: .center, fontSize: 16, isBold: true)
        self.view.addSubview(productExampleText)
        
        // Create the three buttons
        let buttonOne = createButton(withTitle: "One", action: #selector(navigateToOne))
        let buttonTwo = createButton(withTitle: "Two", action: #selector(navigateToTwo))
        let buttonThree = createButton(withTitle: "Three", action: #selector(navigateToThree))
        
        // Create a horizontal stack view to layout buttons
        let productButtons = UIStackView(arrangedSubviews: [buttonOne, buttonTwo, buttonThree])
        productButtons.axis = .horizontal
        productButtons.spacing = 10
        productButtons.translatesAutoresizingMaskIntoConstraints = false
        productButtons.distribution = .fillEqually
        self.view.addSubview(productButtons)
        
        // Create a vertical stack view to layout the label and buttons
        let stackView = UIStackView(arrangedSubviews: [productTitle, productText, productExampleText, productButtons])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        // Layout constraints for the stack view
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -20)
        ])
    }
    
    // Create a button helper function
    func createButton(withTitle title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
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
    
    // Button navigation functions
    @objc func navigateToOne() {
        let viewController = RecipeCarouselViewController(productId: "239658", numberOfResults: 10)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func navigateToTwo() {
        let gridConfig = RecipesCarouselGridConfig(
            numberOfRows: 2,
            spacing: CGSize(width: 6, height: 6),
            recipeCardDimensions: CGSize(width: 200, height: 250))
        let viewController = RecipeCarouselViewController(productId: "239658", numberOfResults: 10, gridConfig: gridConfig)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func navigateToThree() {
        let gridConfig = RecipesCarouselGridConfig(
            numberOfRows: 3,
            spacing: CGSize(width: 6, height: 6),
            recipeCardDimensions: CGSize(width: 200, height: 170))
        let viewController = RecipeCarouselViewController(productId: "239658", numberOfResults: 10, gridConfig: gridConfig)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

