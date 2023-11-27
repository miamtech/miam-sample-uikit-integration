//
//  MyProfileViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by miam x didi on 27/11/2023.
//

import UIKit
import MiamIOSFramework
import SwiftUI

class MyProfileViewController: UIViewController {
    
    let genderSegmentedControl: UISegmentedControl = {
        let items = ["Madame", "Monsieur"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0 // Default to first option
        return sc
    }()
    
    let firstNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Prénom"
        return tf
    }()
    
    let lastNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Nom"
        return tf
    }()
    
    let genderTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Civilité"
        return label
    }()
    
    let firstNameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Prénom"
        return label
    }()

    let lastNameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Nom"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
    }
    
    private let acceptPersonalizationSwitch = AcceptPersonalizationSwitchView()
    private let genderToggle = GenderToggleView()
    
    func setupSubviews() {
        // Add subviews
        view.addSubview(genderTitleLabel)
//        view.addSubview(genderSegmentedControl)
        view.addSubview(genderToggle)
        view.addSubview(firstNameTitleLabel)
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTitleLabel)
        view.addSubview(lastNameTextField)
        view.addSubview(acceptPersonalizationSwitch)
        // Set translatesAutoresizingMaskIntoConstraints to false to use Auto Layout
//        genderSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        genderToggle.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        genderTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        firstNameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        lastNameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        acceptPersonalizationSwitch.translatesAutoresizingMaskIntoConstraints = false
        // Auto Layout constraints
        NSLayoutConstraint.activate([
            genderTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            genderTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genderTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            // Gender Segmented Control
            genderToggle.topAnchor.constraint(equalTo: genderTitleLabel.topAnchor, constant: 40),
            genderToggle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genderToggle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            firstNameTitleLabel.topAnchor.constraint(equalTo: genderToggle.bottomAnchor, constant: 20),
            firstNameTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // First Name Text Field
            firstNameTextField.topAnchor.constraint(equalTo: firstNameTitleLabel.bottomAnchor, constant: 20),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            lastNameTitleLabel.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 20),
            lastNameTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lastNameTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Last Name Text Field
            lastNameTextField.topAnchor.constraint(equalTo: lastNameTitleLabel.bottomAnchor, constant: 20),
            lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            acceptPersonalizationSwitch.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 20),
            acceptPersonalizationSwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            acceptPersonalizationSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        // Additional UI setup for text fields
        let textFields = [firstNameTextField, lastNameTextField]
        for textField in textFields {
            textField.borderStyle = .roundedRect
        }
    }
}

class AcceptPersonalizationSwitchView: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "J'accepte que SUPAMRKT me propose des recettes personnalisées"
        label.numberOfLines = 0 // Allows multiple lines if needed
        return label
    }()
    
    private let switchControl: UISwitch = {
        let switchControl = UISwitch()
        // You can customize the switch here, for example:
        // switchControl.onTintColor = .green
        return switchControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = UIColor(Color.miamColor(.borderLight))
           layer.cornerRadius = 10
           layer.masksToBounds = true
        
        addSubview(label)
        addSubview(switchControl)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            switchControl.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: 8),
            switchControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            switchControl.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        // This is to ensure the switch does not compress the label
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        switchControl.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    // Ensure the view itself does not become too large
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 44)
    }
}

class GenderToggleView: UIView {
    
    private let filledCircleImage = UIImage(named: "CheckedCircle")
    private let emptyCircleImage = UIImage(named: "UncheckedCircle")

    private let madameButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Madame", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let monsieurButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Monsieur", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        // Initialize with the correct images
        madameButton.setImage(filledCircleImage, for: .normal)
        monsieurButton.setImage(emptyCircleImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(madameButton)
        addSubview(monsieurButton)
        
        madameButton.translatesAutoresizingMaskIntoConstraints = false
        monsieurButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            madameButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            madameButton.topAnchor.constraint(equalTo: topAnchor),
            madameButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            monsieurButton.leadingAnchor.constraint(equalTo: madameButton.trailingAnchor, constant: 8),
            monsieurButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            monsieurButton.topAnchor.constraint(equalTo: topAnchor),
            monsieurButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            monsieurButton.widthAnchor.constraint(equalTo: madameButton.widthAnchor)
        ])
        
        // Initial selection state
        madameButton.isSelected = true
    }
    
    @objc private func genderButtonTapped(_ sender: UIButton) {
            let isSelected = sender == madameButton
            madameButton.isSelected = isSelected
            monsieurButton.isSelected = !isSelected
            
            madameButton.setImage(isSelected ? filledCircleImage : emptyCircleImage, for: .normal)
            monsieurButton.setImage(!isSelected ? filledCircleImage : emptyCircleImage, for: .normal)
        }
}

