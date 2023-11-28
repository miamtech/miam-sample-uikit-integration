//
//  ChangeStoreMapViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by miam x didi on 27/11/2023.
//

import UIKit
import MapKit
import MiamIOSFramework
import SwiftUI

class ChangeStoreMapViewController: UIViewController, MKMapViewDelegate {
    
    let scrollView = UIScrollView()
    let mapView = MKMapView()
    let storeLocationsViewController = StoreLocationsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupMapView()
        setupStoreLocations()
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Store"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.glyphImage = UIImage(named: "MiamLogo")
                annotationView?.markerTintColor = UIColor(Color.miamNeutralColor(.textPrimary))
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
    
    func setupMapView() {
        scrollView.addSubview(mapView)
        
        let initialLocation = CLLocationCoordinate2D(latitude: 50.62925, longitude: 3.057256)
        let regionRadius: CLLocationDistance = 1000
        let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)

        let tiboAnnotation = MKPointAnnotation()
        tiboAnnotation.title = "Tibo's Grocery"
        tiboAnnotation.coordinate = CLLocationCoordinate2D(latitude: 50.62965, longitude: 3.052286)
        mapView.addAnnotation(tiboAnnotation)
        
        let lilleCentreAnnotation = MKPointAnnotation()
        lilleCentreAnnotation.title = "LilleCentre"
        lilleCentreAnnotation.coordinate = CLLocationCoordinate2D(latitude: 50.62925, longitude: 3.057256)
        mapView.addAnnotation(lilleCentreAnnotation)
        
        let kevinAnnotation = MKPointAnnotation()
        kevinAnnotation.title = "Kevin's epicerie"
        kevinAnnotation.coordinate = CLLocationCoordinate2D(latitude: 50.62725, longitude: 3.059256)
        mapView.addAnnotation(kevinAnnotation)
        
        let thomasAnnotation = MKPointAnnotation()
        thomasAnnotation.title = "Thomas's Deli"
        thomasAnnotation.coordinate = CLLocationCoordinate2D(latitude: 50.63185, longitude: 3.057716)
        mapView.addAnnotation(thomasAnnotation)

        mapView.delegate = self
        
        let mapHeight: CGFloat = 350
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.contentMode = .scaleAspectFill
        mapView.clipsToBounds = true
        mapView.isUserInteractionEnabled = true
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: mapHeight),
            mapView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mapView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        let searchBar = UISearchBar()
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.white
            textfield.layer.cornerRadius = 10.0
            textfield.clipsToBounds = true
            searchBar.backgroundImage = UIImage() // Set the background image to an empty image
            textfield.clearButtonMode = .never // Remove the clear button if needed
            // Set placeholder text color
            textfield.attributedPlaceholder = NSAttributedString(string: "Rechercher un magasin", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            textfield.textColor = UIColor.black // Set text color
        }
        // set constraints for searchBar
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
        ])
    }
    
    func setupStoreLocations() {
        let hoursLabel = UILabel()
        scrollView.addSubview(hoursLabel)
        hoursLabel.text = "Locations"
        hoursLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        hoursLabel.textColor = .black
        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hoursLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 10),
            hoursLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            hoursLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -80)
        ])
        
        scrollView.addSubview(storeLocationsViewController)
        let storeLocationsHeight: CGFloat = 450
        storeLocationsViewController.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storeLocationsViewController.topAnchor.constraint(equalTo: hoursLabel.bottomAnchor, constant: 10),
            storeLocationsViewController.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            storeLocationsViewController.heightAnchor.constraint(equalToConstant: storeLocationsHeight), // fixed height for the imageView
            storeLocationsViewController.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            storeLocationsViewController.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
    }
    
}

class StoreLocationsViewController: UIView, UITableViewDataSource {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let shops = ["Lille Centre", "Tibo's Grocer", "Kevin's Epicerie", "Thomas's Deli", "Damien's marché", "Aglaé's market", "Didi's liquor store"]
    let address = "5/7 place de la gare" // This could be an array if different for each day
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(tableView) // Add tableView to the view hierarchy
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "storeCell")
        tableView.isScrollEnabled = false
            
            tableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: topAnchor),
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath)

        // Create a default content configuration for the cell
        var content = cell.defaultContentConfiguration()
        content.text = shops[indexPath.row]
        content.secondaryText = address
        content.textProperties.color = .black
        content.textProperties.font = .systemFont(ofSize: 18, weight: .bold)
        content.secondaryTextProperties.color = .black

        // Apply the configuration to the cell
        cell.contentConfiguration = content

        return cell
    }

}
