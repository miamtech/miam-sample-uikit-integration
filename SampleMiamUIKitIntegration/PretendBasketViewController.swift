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
    
    deinit { cancellables.forEach { $0.cancel() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("tab_basket", comment: "")

        // Observe changes in PretendBasket.shared.items
        PretendBasket.shared.$items
            .sink { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.tableView.reloadData() // This will be called every time items changes
            }
            .store(in: &cancellables)
        
        // Configure the tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.rowHeight = 75
        view.addSubview(tableView)
        
        tableView.register(PretendBasketTableViewCell.self, forCellReuseIdentifier: "pretendBasketCell")

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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pretendBasketCell", for: indexPath) as! PretendBasketTableViewCell
        cell.textLabel?.text = PretendBasket.shared.items[indexPath.row].name
        let url = URL(string: PretendBasket.shared.items[indexPath.row].imageUrl ?? "")
        cell.cellImageView.image = UIImage(named: "")
        DispatchQueue.global().async {
            if let url = url {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.cellImageView.image = UIImage(data: data!)
                }
            }
        }
        return cell
    }
}

class PretendBasketTableViewCell: UITableViewCell {
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(cellImageView)
        NSLayoutConstraint.activate([
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellImageView.heightAnchor.constraint(equalToConstant: 60),
            cellImageView.widthAnchor.constraint(equalToConstant: 60)
        ])

        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel!.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 10), // 10 point gap between image and text
            textLabel!.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel!.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10)
        ])
    }
}
