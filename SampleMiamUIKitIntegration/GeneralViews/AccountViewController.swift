//
//  AccountViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by miam x didi on 27/11/2023.
//

import UIKit
import MiamIOSFramework
import SwiftUI

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let options = [
        NSLocalizedString("account_my_profile", comment: "My Profile"),
        NSLocalizedString("account_orders", comment: "Orders"),
        NSLocalizedString("account_lists", comment: "Lists"),
        NSLocalizedString("account_client_card", comment: "Client Card"),
        NSLocalizedString("account_payment_methods", comment: "Payment Methods"),
        NSLocalizedString("account_settings", comment: "Settings"),
        NSLocalizedString("account_sign_out", comment: "Sign out"),
        NSLocalizedString("account_components", comment: "UI Components")
    ]
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        view.addSubview(tableView)
        
        // Register a basic UITableViewCell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    // Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        
        // Set the icon for each option
        let iconName = getIconNameForOption(option: options[indexPath.row])
        cell.imageView?.image = UIImage(named: iconName)
        cell.imageView?.tintColor = UIColor(Color.miamNeutralColor(.textPrimary))
        
        // Add an arrow at the end of each cell
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    
    // Handle cell tap
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let option = options[indexPath.row]
        var viewController: UIViewController?
        
        switch option {
        case NSLocalizedString("account_components", comment: "UI Components"):
            viewController = ComponentsViewController()
        default:
            viewController = NotImplementedViewController()
            break
        }
        
        if let vc = viewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func getIconNameForOption(option: String) -> String {
        switch option {
        case NSLocalizedString("account_my_profile", comment: "My Profile"):
            return "Account"
        case NSLocalizedString("account_orders", comment: "Orders"):
            return "Basket"
        case NSLocalizedString("account_lists", comment: "Lists"):
            return "Rayons"
        case NSLocalizedString("account_client_card", comment: "Client Card"):
            return "Barcode"
        case NSLocalizedString("account_payment_methods", comment: "Payment Methods"):
            return "CreditCard"
        case NSLocalizedString("account_settings", comment: "Settings"):
            return "Admin"
        case NSLocalizedString("account_sign_out", comment: "Sign out"):
            return "Logout"
        case NSLocalizedString("account_components", comment: "UI Components"):
            return "Home"
        default:
            return "Basket" // A default icon if no specific icon is set
        }
    }
}
