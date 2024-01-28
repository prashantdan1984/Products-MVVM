//
//  ProductCell.swift
//  Products MVVM
//
//  Created by Prashantdan on 27/01/24.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var ProductBG: UIView!
    @IBOutlet weak var productimageview: UIImageView!
    @IBOutlet weak var producttitle: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var productrate: UIButton!
    @IBOutlet weak var productdiscription: UILabel!
    @IBOutlet weak var productprice: UILabel!
    @IBOutlet weak var productbuy: UIButton!
    
    var product: Product? {
        didSet { //Property observer
            productDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ProductBG.clipsToBounds = false
        ProductBG.layer.cornerRadius = 15.0
        ProductBG.backgroundColor = .systemGray6
       // ProductBG.backgroundColor = UIColor.systemBrown.cgColor
        
        productimageview.layer.cornerRadius = 10.0
        productimageview.layer.borderColor = UIColor.systemBrown.cgColor
        productimageview.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productDetailConfiguration() {
        guard let product = product else {
            return
        }
        producttitle.text = product.title
        productCategory.text = product.category
        productdiscription.text = product.description
        productprice.text = "$\(product.price)"
        productrate.setTitle("\(product.rating.rate)", for: .normal)
        productimageview.setImage(with: product.image)
    }
}
