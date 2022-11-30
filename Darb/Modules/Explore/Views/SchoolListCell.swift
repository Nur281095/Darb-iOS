//
//  SchoolListCell.swift
//  Darb
//
//  Created by Naveed ur Rehman on 23/11/2022.
//

import UIKit
import SDWebImage

class SchoolListCell: UICollectionViewCell {
    
    @IBOutlet weak var shadV: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var address: UILabel!
    
    
    func configCell(model: SchoolListModel) {
        if !model.gallery.isEmpty {
            image.sd_setImage(with: URL(string: model.gallery[0].name)!)
        } else {
            image.image = nil
        }
        name.text = model.name
        address.text = model.location ?? ""
        rating.set(image: UIImage(named: "ic_star")!, with: " \(model.totalReviews ?? "0.0")")
    }
}
