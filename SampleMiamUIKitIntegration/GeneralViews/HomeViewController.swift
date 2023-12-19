//
//  HomeViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by miam x didi on 28/11/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let carouselLabel = UILabel()
    let carousel = UIScrollView()
    let firstProduct = ProductView(frame: .zero)
    let secondProduct = ProductView()
    let imageView = UIImageView()
    let visualsLabel = UILabel()
    let firstVisual = UIImageView()
    let secondVisual = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupImageView()
        setupCarousel()
        setupVisualsView()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
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
    
    func setupCarousel() {
        scrollView.addSubview(carouselLabel)
        carouselLabel.text = "Nos produits du moment"
        carouselLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        carouselLabel.textColor = .black
        carouselLabel.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            carouselLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            carouselLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            carouselLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
        ])
        view.addSubview(carousel)
        let carouselHeight: CGFloat = 250
        carousel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            carousel.topAnchor.constraint(equalTo: carouselLabel.bottomAnchor, constant: 10),
            carousel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            carousel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            carousel.heightAnchor.constraint(equalToConstant: carouselHeight),
        ])
        
        
        if let firstProductFromBasket = PretendBasket.shared.items.first {
            firstProduct.configure(with: firstProductFromBasket)
            carousel.addSubview(firstProduct)
            firstProduct.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                firstProduct.topAnchor.constraint(equalTo: carousel.topAnchor, constant: 10),
                firstProduct.bottomAnchor.constraint(equalTo: carousel.bottomAnchor),
                firstProduct.widthAnchor.constraint(equalToConstant: CGFloat(300)),
                firstProduct.leadingAnchor.constraint(equalTo: carousel.leadingAnchor),
            ])
        }
        
        if let secondProductFromBasket = PretendBasket.shared.items.last {
            secondProduct.configure(with: secondProductFromBasket)
            carousel.addSubview(secondProduct)
            secondProduct.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                secondProduct.topAnchor.constraint(equalTo: carousel.topAnchor, constant: 10),
                secondProduct.bottomAnchor.constraint(equalTo: carousel.bottomAnchor),
                secondProduct.widthAnchor.constraint(equalToConstant: CGFloat(300)),
                secondProduct.leadingAnchor.constraint(equalTo: firstProduct.trailingAnchor, constant: 10),
                secondProduct.trailingAnchor.constraint(equalTo: carousel.trailingAnchor, constant: -30),
            ])
        }
    }

    func setupImageView() {
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "Hero_Slider")
        
        let imageHeight: CGFloat = 250
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor), // top of the scrollView
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0), // leading of the scrollView
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0), // trailing of the scrollView
            imageView.heightAnchor.constraint(equalToConstant: imageHeight), // fixed height for the imageView
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setupVisualsView() {
        scrollView.addSubview(visualsLabel)
        visualsLabel.text = "Faites vous plaisir"
        visualsLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        visualsLabel.textColor = .black
        visualsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            visualsLabel.topAnchor.constraint(equalTo: carousel.bottomAnchor, constant: 10),
            visualsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            visualsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])

        scrollView.addSubview(firstVisual)
        firstVisual.translatesAutoresizingMaskIntoConstraints = false
        firstVisual.contentMode = .scaleAspectFit
        firstVisual.clipsToBounds = true
        firstVisual.isUserInteractionEnabled = true
        firstVisual.image = UIImage(named: "Home_Visual")
        let screenWidth = (view.window?.screen.bounds.width ?? 500) * 0.95
        let visualWidth: CGFloat = screenWidth
        NSLayoutConstraint.activate([
            firstVisual.topAnchor.constraint(equalTo: visualsLabel.bottomAnchor, constant: 30), // top of the scrollView
            firstVisual.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10), // leading of the scrollView
            firstVisual.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10), // trailing of the scrollView
            firstVisual.widthAnchor.constraint(equalToConstant: visualWidth), // fixed height for the imageView
            firstVisual.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        scrollView.addSubview(secondVisual)
        secondVisual.translatesAutoresizingMaskIntoConstraints = false
        secondVisual.contentMode = .scaleAspectFit
        secondVisual.clipsToBounds = true
        secondVisual.isUserInteractionEnabled = true
        secondVisual.image = UIImage(named: "Home_Visual_1")
        NSLayoutConstraint.activate([
            secondVisual.topAnchor.constraint(equalTo: firstVisual.bottomAnchor, constant: 10), // top of the scrollView
            secondVisual.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10), // leading of the scrollView
            secondVisual.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10), // trailing of the scrollView
            secondVisual.widthAnchor.constraint(equalToConstant: visualWidth),
            secondVisual.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            secondVisual.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
    }
}
