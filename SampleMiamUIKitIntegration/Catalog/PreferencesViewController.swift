//
//  PreferencesViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 22/09/2023.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework
import miamCore

/**
 This is a sample UIKit implementation of Preferences
 */
class PreferencesViewController: UIViewController {
    deinit { print("deinit: PreferencesViewController") }
    // Your SwiftUI View
    var swiftUIView: PreferencesViewTemplate<
        PreferencesParameters
    > {
            return PreferencesViewTemplate.init(
                params: PreferencesParameters(
                    onClosed: { [weak self] in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.popViewController(animated: true)
                    },
                    onGoToSearch: { [weak self] in
                        guard let strongSelf = self else { return }
                        strongSelf.navigationController?.pushViewController(PreferencesSearchViewController(), animated: true)
                    })
            )
        }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<
        PreferencesViewTemplate<PreferencesParameters>
    >?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Preferences"
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
