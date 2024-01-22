//
//  ExplainMealPlannerViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 20/10/2023.
//

import UIKit
import MiamIOSFramework
import SwiftUI
import MealzUIModuleIOS

class ExplainMealPlannerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Meal Planner"
        self.view.backgroundColor = .white
        
        let text = createLabel(text: "The Meal Planner is a Miam Feature where users enter a budget, number of guests, & number of meals they are looking for. Miam will then provide recipes for their selected criteria.", alignment: .left, fontSize: 16)
        text.textColor = UIColor(Color.mealzColor(.primary))
        self.view.addSubview(text)
        
        let buttonText = createLabel(text: "The Meal Planner is launched by a Button like below", alignment: .center, fontSize: 16, isBold: true)
        self.view.addSubview(buttonText)
        
        let mealzMealPlannerCallToAction = MealzMealPlannerCallToAction()
        let mealzMealPlannerCallToActionView = mealzMealPlannerCallToAction.content(params: MealPlannerCTAViewParameters() { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.pushViewController(MealPlannerFormViewController(), animated: true)
        })
        let mealPlannerCTA = UIHostingController(rootView: mealzMealPlannerCallToActionView)

        // Create a vertical stack view to layout the label and buttons
        let stackView = UIStackView(arrangedSubviews: [text, buttonText, mealPlannerCTA.view])
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
