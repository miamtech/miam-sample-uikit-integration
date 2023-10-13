//
//  RecipesTableViewController.swift
//  SampleUIKitIntegration
//
//  Created by Vincent Kergonna on 13/09/2022.
//

import UIKit
import SwiftUI
import MiamIOSFramework

class RecipesTableViewController: UITableViewController {
    let ingredients = ["12726", "484202", "809586"]
    let products = ["Riz", "Pâtes", "Blé", "Sucre", "Moutarde", "Poivre", "Orange", "Haricots vert",
                    "Pommes de terre", "Paté Hénaff", "Sel", "Yaourts", "Pizza", "Pomme"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.title = "Recipes"
        self.tabBarItem.image = UIImage(systemName: "questionmark.square.fill")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        self.tableView.register(RecipeCardHostingTableViewCell<RecipeCardView>.self, forCellReuseIdentifier: "recipeCard")
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "contentConfiguration")
//        self.tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "productCell")
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return products.count
//    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell: UITableViewCell
        
//        if indexPath.row % 5 == 0 {
//            let recipeCardCell = tableView.dequeueReusableCell(withIdentifier: "recipeCard", for: indexPath) as! RecipeCardHostingTableViewCell<RecipeCardView>
//            recipeCardCell.set(rootView: RecipeCardView(recipeId: ingredients[0]), parentController: self)
//            cell = recipeCardCell
//        } else {
//            let productCell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
//            productCell.setTitle(products[indexPath.row])
//            cell = productCell
//        }
        
//        if #available(iOS 16.0, *) {
//            cell = tableView.dequeueReusableCell(withIdentifier: "contentConfiguration", for: indexPath)
//            cell.contentConfiguration = UIHostingConfiguration {
//                RecipeCardView(recipeId: products[indexPath.row])
//            }
//        } else {
            // Fallback on earlier versions
//            let recipeCardCell = tableView.dequeueReusableCell(withIdentifier: "recipeCard", for: indexPath) as! RecipeCardHostingTableViewCell<RecipeCardView>
//            recipeCardCell.set(rootView: RecipeCardView(recipeId: products[indexPath.row]), parentController: self)
//            cell = recipeCardCell
//        }
        
//        return cell
//    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}
