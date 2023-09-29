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

/// This sets the Templates for the CatalogFiltersPage Overview
public class MiamNeutralCatalogFilterViewParameters: CatalogFilterViewParameters {
    
    weak var navigationController: UINavigationController?
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    public lazy var applyFilters: () -> Void = { [weak self] in
        return {
            guard let strongSelf = self, let viewA = self?.navigationController?.viewControllers.first else { return }
            let viewB = CatalogResultsViewController()
            strongSelf.navigationController?.setViewControllers([viewA, viewB], animated: true)
        }}()
    public lazy var closeFilters: () -> Void = { [weak self] in
        return {
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.popViewController(animated: true)
        }}()
}

class CatalogFiltersViewController: UIViewController {
    deinit {
        print("deinit: CatalogFiltersViewController is being deallocated")
    }
    // Your SwiftUI View
    var swiftUIView: CatalogFilterViewTemplate<
        MiamNeutralCatalogFilterViewParameters> {
        return CatalogFilterViewTemplate.init(
            params: MiamNeutralCatalogFilterViewParameters(navigationController: self.navigationController),
            singletonFilterViewModel: MiamDI.shared.recipeFilterViewModel
        )
    }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<CatalogFilterViewTemplate<
        MiamNeutralCatalogFilterViewParameters>>?

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
