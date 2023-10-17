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

class FiltersViewController: UIViewController {
    public let singletonFilterViewModel: SingletonFilterViewModel
    
    init(_ singletonFilterViewModel: SingletonFilterViewModel) {
        self.singletonFilterViewModel = singletonFilterViewModel
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
                    // this is overly complex so that when the user taps the apply button,
                    // the next return will take them to Catalog, instead of back to filters
                     guard let strongSelf = self, let viewA = self?.navigationController?.viewControllers.first else { return }
                     let viewB = CatalogResultsViewController()
                     strongSelf.navigationController?.setViewControllers([viewA, viewB], animated: true)
                }, onClosed: { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.navigationController?.popViewController(animated: true)
                }
            ),
            singletonFilterViewModel: singletonFilterViewModel
        )
    }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<FiltersView<
        FiltersParameters>>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filters"
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
