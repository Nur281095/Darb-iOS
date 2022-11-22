//
//  NotiCell.swift
//  Darb
//
//  Created by Naveed ur Rehman on 21/11/2022.
//

import UIKit

class NotiCell: UITableViewCell {
    
    @IBOutlet weak var notTitle: UILabel!
    @IBOutlet weak var descripLbl: UILabel!
    @IBOutlet weak var shadV: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
