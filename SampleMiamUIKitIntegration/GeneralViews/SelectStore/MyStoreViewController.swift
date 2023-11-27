//
//  MyStoreViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by miam x didi on 27/11/2023.
//

import UIKit

class MyStoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a label
        let label = UILabel()
        label.text = "My Store"
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
