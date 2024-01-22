//
//  CatalogSearchViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 21/09/2023.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MealzUIModuleIOS
import miamCore

class CatalogSearchViewController: UIViewController {
    public let filterInstance: FilterInstance
    
    init(_ filterInstance: FilterInstance) {
        self.filterInstance = filterInstance
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit { print("deinit: CatalogSearchViewController") }
    // Your SwiftUI View
    var swiftUIView: CatalogSearch<
        CatalogSearchParameters,
        BasePageViewParameters
    > {
        return CatalogSearch.init(
            params: CatalogSearchParameters(
                actions: CatalogSearchActions(
                    onApplied: { [weak self] in
                        // complex to remove this view from stack after redirecting to Results page so Results can directly navigate back to CatalogView
                        guard let strongSelf = self, let viewA = self?.navigationController?.viewControllers.first else { return }
                        let viewB = CatalogResultsViewController()
                        strongSelf.navigationController?.setViewControllers([viewA, viewB], animated: true)
                    }
                )),
            baseViews: BasePageViewParameters(),
            filterInstance: filterInstance
        )
    }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<CatalogSearch<
        CatalogSearchParameters,
        BasePageViewParameters
    >>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search"
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
