//
//  ExplainBasketTagViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 20/10/2023.
//

import UIKit
import MiamIOSFramework
import SwiftUI
import MiamNeutraliOSFramework
import miamCore

class ExplainBasketTagViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Basket Tag"
        self.view.backgroundColor = .white
        
        let inlineTitle = createLabel(text: "Inline Basket Tag", alignment: .center, fontSize: 22, isBold: true)
        self.view.addSubview(inlineTitle)
        
        let text = createLabel(text: "The Meal Planner is a Miam Feature where users enter a budget, number of guests, & number of meals they are looking for. Miam will then provide recipes for their selected criteria.", alignment: .left, fontSize: 16)
        text.textColor = UIColor(Color.miamColor(.primaryDark))
        self.view.addSubview(text)
        
        let buttonText = createLabel(text: "You can launch the Basket Tag on another page: ", alignment: .center, fontSize: 16, isBold: true)
        self.view.addSubview(buttonText)
        
        let sampleBasketProduct = MiamNeutralBasketProduct()
        let sampleBasketProductView = sampleBasketProduct.content(
            quantity: .constant(4),
            data: BasketProductData(
                price: 4.23,
                name: "Mozzarella",
                description: "Fresh cheese from southern France",
                pictureURL: (URL(string: "https://storage.googleapis.com/assets.miam.tech/pictures/recipes/studios-fg/14654-quiche-courgettes-et-mozzarella/14654-quiche-courgettes-et-mozzarella_1280x853.jpg") ?? URL(string: ""))!,
                sharedRecipeCount: 0,
                isSubstitutable: false,
                pricePerUnit: 4.23,
                isLoading: false),
            actions: BasketProductActions(onDeleteProduct: {}, onUpdateGuests: { _ in }, onChangeProduct: {})).onTapGesture { [weak self] in
                
                guard let strongSelf = self else { return }
                strongSelf.navigationController?.pushViewController(BasketTagViewController("239658"), animated: true)
            }
        let sampleProduct = UIHostingController(rootView: sampleBasketProductView)

        // Create a vertical stack view to layout the label and buttons
        let stackView = UIStackView(arrangedSubviews: [text, buttonText, sampleProduct.view])
        stackView.axis = .vertical
        stackView.spacing = 10
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
    
    func createLabel(text: String, alignment: NSTextAlignment, fontSize: CGFloat, isBold: Bool = false) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = alignment
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        return label
    }

}
