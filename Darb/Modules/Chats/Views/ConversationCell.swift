//
//  ConversationCell.swift
//  Darb
//
//  Created by Naveed ur Rehman on 25/11/2022.
//

import UIKit

class ConversationCell: UITableViewCell {

    @IBOutlet weak var naameLbls: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var msgTimeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
