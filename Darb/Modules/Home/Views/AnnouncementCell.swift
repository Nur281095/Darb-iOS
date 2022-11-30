//
//  AnnouncementCell.swift
//  Darb
//
//  Created by Naveed ur Rehman on 21/11/2022.
//

import UIKit
import StyledString

class AnnouncementCell: UICollectionViewCell {
    
    @IBOutlet weak var annTitle: UILabel!
    @IBOutlet weak var annDescrip: UILabel!
    
    @IBOutlet weak var shadV: UIView!
    
//    The school is pleased to announce the opening of registration to “KIDS ART WORKSHOP”.
//    Time: 9 am - 2pm
//    Place: The school’s art studio.
    
    func setDescrip(model: AnnouncementModel) {
        
        let str = StyledString("The school is pleased to announce the opening of registration to “KIDS ART WORKSHOP”.\n").with(foregroundColor: UIColor.black).with(font: UIFont(name: AppFonts.roboto, size: 12)).with(lineSpacing: 6) + StyledString("Time: ").with(foregroundColor: .black).with(font: UIFont(name: AppFonts.roboto_bold, size: 12)).with(lineSpacing: 6) + StyledString("9am - 2pm\n").with(foregroundColor: UIColor.black).with(font: UIFont(name: AppFonts.roboto, size: 12)).with(lineSpacing: 6) + StyledString("Place: ").with(foregroundColor: .black).with(font: UIFont(name: AppFonts.roboto_bold, size: 12)).with(lineSpacing: 6) + StyledString("The school’s art studio.").with(foregroundColor: UIColor.black).with(font: UIFont(name: AppFonts.roboto, size: 12)).with(lineSpacing: 6)
        
        annDescrip.attributedText = str.nsAttributedString
    }
}
