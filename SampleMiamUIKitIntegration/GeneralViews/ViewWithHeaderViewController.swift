//
//  ViewWithHeaderVIewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by Walerowicz on 31/10/2023.
//

import Foundation
import Combine
import UIKit
import MealzUIModuleIOS

class ViewWithHeaderViewController: UIViewController {
    @IBOutlet weak var totalAmountBackground: UIView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var shopButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    var embeddedVC: UITabBarController? = nil
    private var cancellables: Set<AnyCancellable> = []
    
    @IBAction func showMenu() {
        guard let vc = self.embeddedVC?.selectedViewController as? UINavigationController else { return }
        vc.popViewController(animated: true)
    }
    
    @IBAction func showBasket() {
        self.present(PretendBasketViewController(), animated: true)
    }
    
    @IBAction func showShop() {
        self.present(MyStoreViewController(), animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let embeddedVC = segue.destination as? UITabBarController {
            self.embeddedVC = embeddedVC
            self.embeddedVC?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalAmountBackground.layer.cornerRadius = totalAmountBackground.bounds.height/2
        totalAmountBackground.layer.shadowColor = UIColor.lightGray.cgColor
        totalAmountBackground.layer.shadowOpacity = 0.5
        totalAmountBackground.layer.shadowOffset = CGSizeMake(0, 5)
        totalAmountBackground.layer.shadowRadius = 5
        
        PretendBasket.shared.$items
            .sink { [weak self] items in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    let total = items.map({($0.price ?? 0) * Double($0.quantity)}).reduce(0, + )
                    strongSelf.totalAmountLabel.text = total.currencyFormatted
                }
            }
            .store(in: &cancellables)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func checkLeftButton(countViewInStack: Int) {
        if countViewInStack > 1 {
            leftButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        }else{
            leftButton.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        }
    }
}

extension ViewWithHeaderViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        checkLeftButton(countViewInStack: navigationController.viewControllers.count)
    }
}

extension ViewWithHeaderViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let vc = viewController as? UINavigationController {
            vc.delegate = self
            checkLeftButton(countViewInStack: vc.viewControllers.count)
        }
    }
}
