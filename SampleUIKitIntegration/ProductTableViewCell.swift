//
//  ProductTableViewCell.swift
//  SampleUIKitIntegration
//
//  Created by Vincent Kergonna on 13/10/2022.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    public let productName = UITextView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented.")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        let subviews = [productName]
        subviews.forEach { view in
            contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        addConstraint(NSLayoutConstraint(item: productName, attribute: .top, relatedBy: .equal,
                                         toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: productName, attribute: .leading, relatedBy: .equal,
                                         toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: productName, attribute: .trailing, relatedBy: .equal,
                                         toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 0.0))
//        addConstraint(NSLayoutConstraint(item: productName, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 20.0))
        addConstraint(NSLayoutConstraint(item: productName, attribute: .bottom, relatedBy: .equal,
                                         toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0.0))
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: UIView.noIntrinsicMetric, height: 240.0)
//    }
    
    func setTitle(_ title: String) {
        productName.text = title
        invalidateIntrinsicContentSize()
        setNeedsLayout()
    }
}
