//
//  PretendBasketViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 23/10/2023.
//

import UIKit
import Combine
import MiamIOSFramework
import MealzUIModuleIOS
import SwiftUI

class PretendBasketViewController: UIViewController, UITableViewDelegate,       UITableViewDataSource {
    
    private let tableView = UITableView()
    private var cancellables: Set<AnyCancellable> = []
    
    deinit { cancellables.forEach { $0.cancel() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("tab_basket", comment: "")
        tableView.allowsSelection = false // disable selection
        
        PretendBasket.shared.$items
            .sink { [weak self] items in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            }
            .store(in: &cancellables)
        
        // Configure the tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.rowHeight = 100
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
        // Add trash bin button to the top right
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapTrashButton))
        navigationItem.rightBarButtonItem = trashButton
    }
    
    @objc func didTapTrashButton() {
        PretendBasket.shared.removeAll()
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PretendBasket.shared.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pretendBasketCell", for: indexPath) as! PretendBasketTableViewCell
        cell.delegate = self
        
        cell.textLabel?.text = PretendBasket.shared.items[indexPath.row].name + " " + String(PretendBasket.shared.items[indexPath.row].quantity)
        let url = URL(string: PretendBasket.shared.items[indexPath.row].imageUrl ?? "")
        cell.cellImageView.image = UIImage(named: "")
        cell.productId = PretendBasket.shared.items[indexPath.row].id
        
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

extension PretendBasketViewController: PretendBasketCellDelegate {
    func didSelectRecipeDetail(with recipeId: String) {
//        let detailsVC = RecipeDetailsViewController(recipeId)
//        navigationController?.pushViewController(detailsVC, animated: true)
    }
}


class PretendBasketTableViewCell: UITableViewCell {
    
    var onTrashButtonTapped: (() -> Void)?
    weak var delegate: PretendBasketCellDelegate?
    
    var productId: String? {
        didSet {
            configureBasketTags()
        }
    }
    
    @objc func trashButtonAction() {
        if let id = productId {
            PretendBasket.shared.remove(removedProductId: id)
        }
    }
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let trashButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var basketTags: UIView = {
        let view = UIView()
        return view
    }()
    
    private func configureBasketTags() {
        guard let id = productId else { return }
        let tags = BasketTag.init(
            params: BasketTagParameters(
                actions: BasketTagActions(
                    onShowRecipeDetails: { [weak self] recipeId in
                        guard let strongSelf = self else { return }
                        strongSelf.delegate?.didSelectRecipeDetail(with: recipeId)
                })),
            baseViews: BaseComponentViewParameters(),
            retailerProductId: id,
            scrollAlignment: .horizontal)
        let hostingController = UIHostingController(rootView: tags)
        // Clear any previous tags or views in basketTags
        basketTags.subviews.forEach { $0.removeFromSuperview() }
        guard let tagView = hostingController.view else { return }
        basketTags.addSubview(tagView)
        tagView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ // Add constraints for the tags view to fit in basketTags
            tagView.leadingAnchor.constraint(equalTo: basketTags.leadingAnchor),
            tagView.trailingAnchor.constraint(equalTo: basketTags.trailingAnchor),
            tagView.topAnchor.constraint(equalTo: basketTags.topAnchor),
            tagView.bottomAnchor.constraint(equalTo: basketTags.bottomAnchor)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isUserInteractionEnabled = true
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(trashButton)
        contentView.addSubview(cellImageView)
        contentView.addSubview(basketTags)
        basketTags.isUserInteractionEnabled = true
        NSLayoutConstraint.activate([
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellImageView.heightAnchor.constraint(equalToConstant: 60),
            cellImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
        // Constraints for trashButton
        NSLayoutConstraint.activate([
            trashButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            trashButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            trashButton.heightAnchor.constraint(equalToConstant: 30),
            trashButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        trashButton.addTarget(self, action: #selector(trashButtonAction), for: .touchUpInside)
        
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel!.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 10),
            textLabel!.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel!.trailingAnchor.constraint(lessThanOrEqualTo: trashButton.leadingAnchor, constant: -10) // Make sure the label doesn't overlap the trash button
        ])
        
        // Constraints for basketTags
        basketTags.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            basketTags.topAnchor.constraint(equalTo: textLabel!.bottomAnchor, constant: -10), // Position it 10 points below the textLabel
            basketTags.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10), // Ensure it doesn't extend beyond the bottom of the cell
            basketTags.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 10),
            basketTags.trailingAnchor.constraint(equalTo: trashButton.leadingAnchor, constant: -10)
        ])
    }
}

protocol PretendBasketCellDelegate: AnyObject {
    func didSelectRecipeDetail(with id: String)
}
