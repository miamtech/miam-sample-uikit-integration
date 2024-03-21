//
//  ProductView.swift
//  SampleMiamUIKitIntegration
//
//  Created by miam x didi on 28/11/2023.
//

import UIKit
import MealzIOSFramework
import SwiftUI
import Combine

class ProductView: UIView {
    
    var product: PretendProduct? {
        didSet {
            guard let product = product else { return }
            titleLabel.text = product.name
            priceLabel.text = product.price?.currencyFormatted
            let weight = Double.random(in: 0...4.5)
            let pricePerUnit = (product.price ?? 2) / weight
            pricePerUnitLabel.text = pricePerUnit.currencyFormatted + "/kg"
            weightLabel.text = String(format: "%0.1f", weight * 100) + " g"
        }
    }
    
    func configure(with product: PretendProduct) {
        self.product = product
    }

    let background = UIView()
    let productImageView = UIImageView()
    let titleLabel = UILabel()
    let weightLabel = UILabel()
    let priceLabel = UILabel()
    let pricePerUnitLabel = UILabel()
    let favoriteButton = UIImageView()
    let addToCartButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCard()
    }
    
    private func setupCard() {
        if let imageUrl = product?.imageUrl {
            productImageView.downloaded(from: imageUrl)
        }
        addSubview(productImageView)
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        
        productImageView.image = UIImage(named: "Home")
        let url = URL(string: product?.imageUrl ?? "")
        
        DispatchQueue.global().async {
            if let url = url {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.productImageView.image = UIImage(data: data!)
                }
            }
        }
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            productImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        productImageView.contentMode = .scaleAspectFit
        
        addSubview(favoriteButton)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            favoriteButton.heightAnchor.constraint(equalToConstant: 20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        favoriteButton.image = UIImage(named: "Heart")
        favoriteButton.tintColor = UIColor(Color.miamColor(.primaryDark))
        favoriteButton.contentMode = .scaleAspectFit
        
        addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0 // Allows label to wrap text
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10)
        ])
        
        addSubview(weightLabel)
        weightLabel.font = UIFont.systemFont(ofSize: 18)
        weightLabel.textColor = .black
        weightLabel.backgroundColor = UIColor(Color.miamColor(.greyLighter))
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weightLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            weightLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            weightLabel.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        addSubview(priceLabel)
        priceLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        priceLabel.textColor = UIColor(Color.miamColor(.primaryDark))
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            priceLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        addSubview(pricePerUnitLabel)
        pricePerUnitLabel.font = UIFont.systemFont(ofSize: 18)
        pricePerUnitLabel.textColor = UIColor(Color.miamColor(.lightGrey))
        pricePerUnitLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pricePerUnitLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            pricePerUnitLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            pricePerUnitLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        addSubview(addToCartButton)
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addToCartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            addToCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),
            addToCartButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
