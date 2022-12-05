//
//  AnnouncementCell.swift
//  Darb
//
//  Created by Naveed ur Rehman on 21/11/2022.
//

import UIKit
import StyledString
import AAExtensions

protocol AnnouncementDelegate {
    func didTapAnnouncemnt(index: Int)
}

class AnnouncementCell: UICollectionViewCell {
    
    @IBOutlet weak var annTitle: UILabel!
    @IBOutlet weak var annDescrip: UITextView!
    
    @IBOutlet weak var shadV: UIView!
    
    
    var delegate: AnnouncementDelegate?
    
//    The school is pleased to announce the opening of registration to “KIDS ART WORKSHOP”.
//    Time: 9 am - 2pm
//    Place: The school’s art studio.
    
    func setDescrip(model: AnnouncementModel) {
        annDescrip.attributedText = model.text.htmlAttributed(family: "Roboto-Regular")
    }
    
    @IBAction func announceTap(_ sender: Any) {
        delegate?.didTapAnnouncemnt(index: self.tag)
    }
}
