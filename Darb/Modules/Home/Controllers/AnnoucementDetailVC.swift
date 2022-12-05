//
//  AnnoucementDetailVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 21/11/2022.
//

import UIKit
import WebKit

class AnnoucementDetailVC: BaseVC {

    @IBOutlet weak var desrcip: UILabel!
    @IBOutlet weak var web: WKWebView!
    @IBOutlet weak var sampleImg: UIImageView!
    
    var announcement: AnnouncementModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        self.navigationItem.title = "Announcement details"
        
        desrcip.attributedText = announcement.text.htmlAttributed(family: "Roboto-Regular")
        sampleImg.isHidden = true
        if announcement.file != nil {
            if let url = URL(string: announcement.file.name) {
                web.load(URLRequest(url: url))
                web.isHidden = false
            } else {
                web.isHidden = false
            }
        } else {
            web.isHidden = true
        }
    }
    

    
    @IBAction func enrollTap(_ sender: Any) {
    }
    
}
