//
//  SponsorDetailsViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 03/10/2023.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MealzUIModuleIOS
import miamCore

/**
 This is a sample UIKit implementation of Sponsor Details
 */
class SponsorDetailsViewController: UIViewController {
    public let sponsor: Sponsor
    
    init(sponsor: Sponsor) {
        self.sponsor = sponsor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit { print("deinit: SponsorDetailsViewController") }
    // Your SwiftUI View
    var swiftUIView: SponsorDetails<
        SponsorDetailsParameters
    > {
        return SponsorDetails.init(
            params: SponsorDetailsParameters(),
            sponsor: sponsor
        )
    }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<SponsorDetails<
        SponsorDetailsParameters>>?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(sponsor.name)"
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
