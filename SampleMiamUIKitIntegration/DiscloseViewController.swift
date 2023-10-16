//
//  DiscloseViewController.swift
//  SampleUIKitIntegration
//
//  Created by didi on 6/28/23.
//

import UIKit
import MiamIOSFramework
import MiamNeutraliOSFramework
import SwiftUI
import miamCore

class DiscloseViewController: UIViewController {
    
    @IBOutlet weak var actionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling
        self.view.backgroundColor = UIColor.white
        
        // Remove the old UIKit button
        self.actionButton.removeFromSuperview()

        // Your SwiftUI Button
        let miamNeutralMealPlannerCallToAction = MiamNeutralMealPlannerCallToAction()
        let miamNeutralMealPlannerCallToActionView = miamNeutralMealPlannerCallToAction.content { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.pushViewController(MealPlannerFormViewController(), animated: true)
        }
        
        let testBasketTagButton = Button(action: {  [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.pushViewController(BasketTagViewController("239658"), animated: true)
        }, label: {
            VStack {
                Text("Test Basket Tag")
                    .foregroundColor(.white)
                    .font(.system(size: 24))
                Text("Add Pizza margherita to your basket, then try this button")
                    .foregroundColor(.white)
                    .font(.system(size: 12))
            }
            .padding(10)
            .background(Color.miamColor(.primary))
                .cornerRadius(12)
                .padding()
            })
        
        let criteria = SuggestionsCriteria(shelfIngredientsIds: nil, currentIngredientsIds: ["5319173"], basketIngredientsIds: nil, groupId: nil)
        
        let recipeCarouselCriteria = Button(action: {  [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.pushViewController(RecipeCarouselViewController(
                criteria: criteria,
                numberOfResults: 20
            ), animated: true)
        }, label: {
                Text("Recipe Carousel Criteria")
                .font(.system(size: 24))
                .padding(10)
            })
        
        let recipeCarouselProduct = Button(action: {  [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.pushViewController(RecipeCarouselViewController(
                productId: "5319173",
                numberOfResults: 20
            ), animated: true)
        }, label: {
                Text("Recipe Carousel Product")
                .font(.system(size: 24))
                .padding(10)
            })
        
        let buttonStack = VStack(spacing: 50) {
            miamNeutralMealPlannerCallToActionView
            testBasketTagButton
            recipeCarouselCriteria
            recipeCarouselProduct
        }
        
        // Create a UIHostingController with coursesUMealPlannerCallToActionView
        let hostingController = UIHostingController(rootView: buttonStack)
        
        // Add the hostingController as a child view controller
        self.addChild(hostingController)
        
        // Add hostingController's view to the current view
        self.view.addSubview(hostingController.view)
        
        
        
        
        // Set hostingController's view size and position
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            hostingController.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        // Notify the hostingController that it has been moved to the current view controller
        hostingController.didMove(toParent: self)
    }

}

