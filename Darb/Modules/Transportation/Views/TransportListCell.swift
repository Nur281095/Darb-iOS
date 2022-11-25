//
//  TransportListCell.swift
//  Darb
//
//  Created by Naveed ur Rehman on 25/11/2022.
//

import UIKit
import StyledString

class TransportListCell: UICollectionViewCell {
    
    @IBOutlet weak var shadV: UIView!
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var fromToDescrip: UILabel!
    
    @IBOutlet weak var statusBtn: UIButton!
    
   func setDescrip() -> NSAttributedString {
       let str = StyledString("For: ").with(foregroundColor: .black).with(font: UIFont(name: AppFonts.roboto_medium, size: 10)).with(lineSpacing: 6) + StyledString("Sarah Smith\n").with(foregroundColor: UIColor(hexString: "#979797")).with(font: UIFont(name: AppFonts.roboto, size: 10)).with(lineSpacing: 6) + StyledString("From: ").with(foregroundColor: .black).with(font: UIFont(name: AppFonts.roboto_medium, size: 10)).with(lineSpacing: 6) + StyledString("King Fahd, Riyadh\n").with(foregroundColor: UIColor(hexString: "#979797")).with(font: UIFont(name: AppFonts.roboto, size: 10)).with(lineSpacing: 6) + StyledString("To: ").with(foregroundColor: .black).with(font: UIFont(name: AppFonts.roboto_medium, size: 10)).with(lineSpacing: 6) + StyledString("KAl Aarid, Riyadh").with(foregroundColor: UIColor(hexString: "#979797")).with(font: UIFont(name: AppFonts.roboto, size: 10)).with(lineSpacing: 6)
        
        return str.nsAttributedString
    }
    
    @IBAction func statusTap(_ sender: Any) {
    }
}
