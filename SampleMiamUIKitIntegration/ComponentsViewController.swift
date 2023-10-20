//
//  ComponentsViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 20/10/2023.
//

import UIKit

class ComponentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let options = ["Favorites", "Meal Planner", "Carousel"]
        private let tableView = UITableView()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            title = "Components"
            
            // Configure the tableView
            tableView.delegate = self
            tableView.dataSource = self
            tableView.frame = view.bounds
            view.addSubview(tableView)
            
            // Register a basic UITableViewCell
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
        
        // Number of rows
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return options.count
        }
    
        // Cell configuration
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = options[indexPath.row]
            return cell
        }
        
    // Handle cell tap
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let option = options[indexPath.row]
        var viewController: UIViewController?
        
        switch option {
        case "Favorites":
            viewController = FavoritesViewController()
        case "Meal Planner":
            viewController = MealPlannerFormViewController()
        case "Carousel":
            viewController = ExplainCarouselViewController()
        default:
            break
        }
        
        if let vc = viewController {
            navigationController?.pushViewController(vc, animated: true)
        }
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
