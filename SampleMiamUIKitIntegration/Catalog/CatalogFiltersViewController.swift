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
public struct MiamNeutralCatalogCatalogFilterViewParameters: CatalogFilterViewParameters {
    public var header = MiamNeutralCatalogFilterHeader()
    public var section = MiamNeutralCatalogFilterSection()
    public var callToAction = MiamNeutralCatalogFiltersCallToAction()
    // Use defaults
    @DefaultBackgroundViewTemplate public var background
}

class CatalogFiltersViewController: UIViewController {
    deinit {
        print("deinit: CatalogFiltersViewController is being deallocated")
    }
    // Your SwiftUI View
    var swiftUIView: CatalogFilterViewTemplate<
        MiamNeutralCatalogCatalogFilterViewParameters> {
        return CatalogFilterViewTemplate.init(
            viewParameters: MiamNeutralCatalogCatalogFilterViewParameters(),
            singletonFilterViewModel: MiamDI.shared.recipeFilterViewModel,
            apply: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.navigationController?.pushViewController(CatalogResultsViewController(),animated: true)
            }, close: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.navigationController?.popViewController(animated: true)
            }
        )
    }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<CatalogFilterViewTemplate<
        MiamNeutralCatalogCatalogFilterViewParameters>>?

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
