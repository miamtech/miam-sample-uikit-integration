//
//  MealViewController.swift
//  SampleUIKitIntegration
//
//  Created by Vincent Kergonna on 12/07/2022.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MealzUIModuleIOS

class MealPlannerFormViewController: UIViewController {
    deinit { print("deinit: MealPlannerFormViewController") }
    // Your SwiftUI View
    var swiftUIView: MealPlannerForm<
        MealPlannerFormParameters,
        BasePageViewParameters
    > {
        return MealPlannerForm(
            params: MealPlannerFormParameters(
                actions: MealPlannerFormActions(
                    onNavigateToMealPlannerResults: { [weak self] recipes in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.pushViewController(MealPlannerResultsViewController(), animated: true)
                    })
            ),
            baseViews: BasePageViewParameters()
        )
        
    }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<MealPlannerForm<
        MealPlannerFormParameters,
        BasePageViewParameters
    >>?
    
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
