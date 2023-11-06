//
//  CatalogFiltersViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 07/08/2023.
//
import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework
import miamCore

/**
 This is a sample UIKit implementation of Filters
 */
class FiltersViewController: UIViewController {
    public let filterInstance: FilterInstance
    private let isForMealPlanner: Bool
    
    init(
        _ filterInstance: FilterInstance,
        isForMealPlanner: Bool = false
    ) {
        self.filterInstance = filterInstance
        self.isForMealPlanner = isForMealPlanner
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit { print("deinit: FiltersViewController")}
    // Your SwiftUI View
    var swiftUIView: FiltersView<
        FiltersParameters> {
        return FiltersView.init(
            params: FiltersParameters(
                onApplied: { [weak self] in
                    guard let strongSelf = self else { return }
                    if strongSelf.isForMealPlanner {
                        strongSelf.navigationController?.popViewController(animated: true)
                    } else {
                        // this is overly complex so that when the user taps the apply button,
                        // the next return will take them to Catalog, instead of back to filters
                        guard let viewA = strongSelf.navigationController?.viewControllers.first else { return }
                        let viewB = CatalogResultsViewController()
                        strongSelf.navigationController?.setViewControllers([viewA, viewB], animated: true)
                    }
                }, onClosed: { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.navigationController?.popViewController(animated: true)
                }
            ),
            filterInstance: filterInstance
        )
    }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<FiltersView<
        FiltersParameters>>?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Filters"
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
