//
//  ItemSelectorViewController.swift
//  SampleUIKitIntegration
//
//  Created by didi on 7/4/23.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

class ItemSelectorViewController: UIViewController {
//    public let recipeId: String
    public let ingredientId: String
    
    init(
//        _ recipeId: String,
        ingredientId: String
    ) {
//        self.recipeId = recipeId
        self.ingredientId = ingredientId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit { print("deinit: ItemSelectorViewController")}

    // Your SwiftUI View
    var swiftUIView: ItemSelector<ItemSelectorParameters> {
        return ItemSelector(
            params: ItemSelectorParameters(onItemSelected: { [weak self] in
                // added small delay to ensure image reloads
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400)) {
                    guard let strongSelf = self else { return }
                    strongSelf.navigationController?.popViewController(animated: true)
                }
            }), ingredientId: ingredientId)
    }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<ItemSelector<ItemSelectorParameters>>?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Mon assistant Budget repas"
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
