//
//  MyStoreViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by miam x didi on 27/11/2023.
//

import UIKit
import MiamIOSFramework
import SwiftUI

class MyStoreViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let imageView = UIImageView()
    var changeStoreButton = UIButton()
    let contactLabel = UILabel()
    var hoursLabel = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupImageView()
                setupContactLabel()
        //        setupHoursLabel()
        
        self.view.backgroundColor = .white
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupImageView() {
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "GroceryStore")
        
        let imageHeight: CGFloat = 250
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor), // top of the scrollView
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0), // leading of the scrollView
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0), // trailing of the scrollView
            imageView.heightAnchor.constraint(equalToConstant: imageHeight), // fixed height for the imageView
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Add a dark overlay
        let darkOverlay = UIView()
        darkOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Adjust alpha for darkness
        darkOverlay.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(darkOverlay)
        
        NSLayoutConstraint.activate([
            darkOverlay.topAnchor.constraint(equalTo: imageView.topAnchor),
            darkOverlay.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            darkOverlay.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            darkOverlay.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
        
        // Create and add a label to the imageView
        let titleLabel = UILabel()
        titleLabel.text = "Lille Centre"
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(titleLabel)
        
        let addressLabel = UILabel()
        addressLabel.text = "5/7 place de la gare"
        addressLabel.font = UIFont.systemFont(ofSize: 20)
        addressLabel.textColor = .white
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(addressLabel)
        
        let postCodeLabel = UILabel()
        postCodeLabel.text = "59000"
        postCodeLabel.font = UIFont.systemFont(ofSize: 20)
        postCodeLabel.textColor = .white
        postCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(postCodeLabel)
        
        // Create the stack view and add your views
        let stackView = UIStackView(arrangedSubviews: [titleLabel, addressLabel, postCodeLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 4 // Adjust the spacing as needed
        
        // Add the stack view to the image view
        imageView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for the stack view
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        ])
        
        var config = UIButton.Configuration.filled()
        config.titlePadding = 10  // Padding around the title
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)  // Padding around the button's content
        config.baseBackgroundColor = .white
        
        changeStoreButton = UIButton(configuration: config, primaryAction: nil)
        changeStoreButton.setTitle("Changer de magasin", for: .normal)
        changeStoreButton.setTitleColor(UIColor(Color.miamColor(.primary)), for: .normal)
        changeStoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        changeStoreButton.layer.cornerRadius = 10
        
        // Shadow properties
        changeStoreButton.layer.shadowColor = UIColor.black.cgColor
        changeStoreButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        changeStoreButton.layer.shadowRadius = 3
        changeStoreButton.layer.shadowOpacity = 0.3

        changeStoreButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(changeStoreButton)
        // Constraints for the button
        NSLayoutConstraint.activate([
            changeStoreButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            changeStoreButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20)
            
        ])
    }
    
    func setupContactLabel() {
        scrollView.addSubview(contactLabel)
        NSLayoutConstraint.activate([
            contactLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            contactLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            contactLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            contactLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Create and add a label to the imageView
        let titleLabel = UILabel()
        titleLabel.text = "Contactez-nous"
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contactLabel.addSubview(titleLabel)
        
        let telephoneLabel = UILabel()
        telephoneLabel.text = "Par téléphone : 03 03 03 03 03"
        telephoneLabel.font = UIFont.systemFont(ofSize: 20)
        telephoneLabel.textColor = .black
        telephoneLabel.translatesAutoresizingMaskIntoConstraints = false
        contactLabel.addSubview(telephoneLabel)
        
        let emailLabel = UILabel()
        emailLabel.text = "Par mail : contact@miam.tech"
        emailLabel.font = UIFont.systemFont(ofSize: 20)
        emailLabel.textColor = .black
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        contactLabel.addSubview(emailLabel)
        
        // Create the stack view and add your views
        let stackView = UIStackView(arrangedSubviews: [titleLabel, telephoneLabel, emailLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 12 // Adjust the spacing as needed
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contactLabel.addSubview(stackView)
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for the stack view
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contactLabel.leadingAnchor, constant: 20), // Adjust constant as needed
            stackView.topAnchor.constraint(equalTo: contactLabel.topAnchor, constant: 20), // Adjust constant as needed
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: contactLabel.trailingAnchor, constant: -20) // This constraint ensures the stackView doesn't exceed the width of contactLabel
        ])
    }
}
