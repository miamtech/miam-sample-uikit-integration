//
//  SettingViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by Walerowicz on 29/11/2023.
//

import UIKit
import MiamNeutraliOSFramework


struct MenuItem{
    let picto: String
    let title: String
    var hideChevon: Bool = false
    var next: UIViewController.Type? = nil
}



class SettingViewController: UIViewController {
    var menuItems : [MenuItem] {
        [
            MenuItem(picto: "SettingsUser", title: "settings_profile", next: ProfilViewController.self),
            MenuItem(picto: "SettingsBasket", title: "settings_command", next: MyMealsViewController.self),
            MenuItem(picto: "SettingsMenu", title: "settings_lists"),
            MenuItem(picto: "SettingsBarcode", title: "settings_card"),
            MenuItem(picto: "SettingsCreditCard", title: "settings_credit_card"),
            MenuItem(picto: "SettingsAdmin", title: "settings_contact"),
            MenuItem(picto: "SettingsLogout", title: "settings_logout", hideChevon: true)
        ]
    }
    
    @IBOutlet weak var tableview: UITableView! {
        didSet {
            tableview.delegate = self
            tableview.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

extension SettingViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let c = menuItems[indexPath.row].next {
            self.navigationController?.pushViewController(c.init(), animated: true)
        }
        
        
        
    }
    
}
extension SettingViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as? SettingsCell else { return UITableViewCell() }
        cell.cellTitle.text = NSLocalizedString( menuItems[indexPath.row].title, comment: menuItems[indexPath.row].title)
        cell.cellPicto.image = UIImage(named: menuItems[indexPath.row].picto)
        cell.chevronPicto.isHidden = menuItems[indexPath.row].hideChevon
        
        return cell
    }
    
    
}
