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

/// This sets the Templates for the CatalogFiltersPage Overview
public class MiamNeutralPreferencesViewParameters: PreferencesViewParameters {
    
    weak var navigationController: UINavigationController?
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    public lazy var closePreferences: () -> Void = { [weak self] in
        return {
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.popViewController(animated: true)
        }}()
    public lazy var goToSearchView: () -> Void = { [weak self] in
        return {
//            guard let strongSelf = self else { return }
//            strongSelf.navigationController?.pushViewController(PreferencesSearchVie(), animated: true)
        }}()
}

class PreferencesViewController: UIViewController {
    deinit {
        print("deinit: PreferencesViewController is being deallocated")
    }
    // Your SwiftUI View
    var swiftUIView: PreferencesViewTemplate<
        MiamNeutralPreferencesViewParameters> {
        return PreferencesViewTemplate.init(
            params: MiamNeutralPreferencesViewParameters(navigationController: self.navigationController)
        )
    }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<PreferencesViewTemplate<
        MiamNeutralPreferencesViewParameters>>?

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
