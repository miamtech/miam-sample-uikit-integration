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

    private var cancellables: Set<AnyCancellable> = []

    @IBAction func showMenu() {
        
    }
    
    @IBAction func showBasket() {
        self.present(PretendBasketViewController(), animated: true)
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
