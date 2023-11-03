//
//  ViewWithHeaderVIewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by Walerowicz on 31/10/2023.
//

import Foundation
import Combine
import UIKit
import MiamNeutraliOSFramework
import SwiftUI

class ViewWithHeaderViewController: UIViewController {
    @IBOutlet weak var totalAmountBackground: UIView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!

    var embeddedVC: UINavigationController? = nil
    private var cancellables: Set<AnyCancellable> = []

    @IBAction func backOrMenu() {
        self.embeddedVC?.popViewController(animated: true)
    }
    
    @IBAction func showBasket() {
        guard  let embeddedVC = embeddedVC else { return }
        if !embeddedVC.viewControllers.contains(where: { $0.isKind(of: PretendBasketViewController.self)
        }) {
            self.embeddedVC?.pushViewController(PretendBasketViewController(), animated: true)
        }
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let embeddedVC = segue.destination as? UINavigationController {
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
                    strongSelf.totalAmountLabel.text = "\(total) €"
                }
            }
            .store(in: &cancellables)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

extension ViewWithHeaderViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if self.embeddedVC?.viewControllers.count ?? 0 > 1 {
            leftButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        }else{
            leftButton.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        }
    }
    
}
