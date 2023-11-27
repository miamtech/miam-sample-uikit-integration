//
//  NotImplementedViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by miam x didi on 27/11/2023.
//

import UIKit

class NotImplementedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the background color of the view
        view.backgroundColor = .white

        // Create a label
        let label = UILabel()
        label.text = NSLocalizedString("not_implemented", comment: "Not Implemented Yet")
        label.textAlignment = .center

        // Add the label to the view
        view.addSubview(label)

        // Set constraints to center the label
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
