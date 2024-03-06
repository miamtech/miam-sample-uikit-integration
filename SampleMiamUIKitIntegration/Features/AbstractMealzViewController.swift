//
//  AbstractMealzViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by Diarmuid McGonagle on 06/03/2024.
//

import UIKit

open class AbstractMealzViewController: UIViewController {
    public var feature: UINavigationController?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        if let feature {
            // Add the custom navigation controller as a child view controller
            addChild(feature)
            feature.view.frame = self.view.bounds
            view.addSubview(feature.view)
            feature.didMove(toParent: self)
        }
    }
}
