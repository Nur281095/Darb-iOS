//
//  ChatCell.swift
//  Darb
//
//  Created by Naveed ur Rehman on 29/11/2022.
//

import UIKit

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var msgView: UIView!
    @IBOutlet weak var nameLbls: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
