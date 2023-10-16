//
//  BasketTagViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 16/10/2023.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework
import miamCore

class BasketTagViewController: UIViewController {
    public let retailerProductId: String
    
    init(_ retailerProductId: String) {
        self.retailerProductId = retailerProductId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit { print("deinit: BasketTagViewController") }
    
    // Your SwiftUI View
    var swiftUIView: BasketTagViewTemplate<
        BasketTagParameters
    > {
        return BasketTagViewTemplate.init(
            params: BasketTagParameters(
                onShowRecipeDetails: { [weak self] recipeId in
                    guard let strongSelf = self else { return }
                    strongSelf.navigationController?.pushViewController(RecipeDetailsViewController(recipeId), animated: true)
                }),
            retailerProductId: retailerProductId)
    }
    
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<BasketTagViewTemplate<
        BasketTagParameters
>>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Basket Tag"
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
