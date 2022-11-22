//
//  ChildCell.swift
//  Darb
//
//  Created by Naveed ur Rehman on 22/11/2022.
//

import UIKit

class ChildCell: UITableViewCell {

    @IBOutlet weak var nameLbls: UILabel!
    @IBOutlet weak var shadV: UIView!
    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
