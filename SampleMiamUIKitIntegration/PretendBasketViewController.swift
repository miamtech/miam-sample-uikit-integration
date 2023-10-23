//
//  PretendBasketViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 23/10/2023.
//

import UIKit
import Combine

class PretendBasketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    private var cancellables: Set<AnyCancellable> = []
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pretend Basket"
        
        // Observe changes in PretendBasket.shared.items
        PretendBasket.shared.$items
            .sink { [weak self] _ in
                // This will be called every time items changes
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        // Configure the tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        view.addSubview(tableView)
        
        // Register a basic UITableViewCell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0/255, green: 85/255, blue: 98/255, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PretendBasket.shared.items.count
    }
    
    // Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = PretendBasket.shared.items[indexPath.row].name

        return cell
    }
}
