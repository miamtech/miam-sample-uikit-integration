//
//  ProfilViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by Walerowicz on 30/11/2023.
//

import UIKit

class ProfilViewController: UIViewController {
    @IBOutlet weak var womanButton: UIButton! {
        didSet {
            womanButton.setImage(UIImage(named: "radio_on"), for: .selected)
            womanButton.setImage(UIImage(named: "radio_off"), for: .normal)
            womanButton.adjustsImageWhenHighlighted = false;
        }
    }
    @IBOutlet weak var manButton: UIButton! {
        didSet {
            manButton.setImage(UIImage(named: "radio_on"), for: .selected)
            manButton.setImage(UIImage(named: "radio_off"), for: .normal)
            manButton.adjustsImageWhenHighlighted = false;
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func perfomSwitch(_ sender: UIButton) {
        sender.isSelected = true
        if(sender == womanButton){ manButton.isSelected = false }
        else { womanButton.isSelected = false }
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
