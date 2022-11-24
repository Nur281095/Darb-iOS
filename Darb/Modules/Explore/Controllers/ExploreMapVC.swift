//
//  ExploreMapVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 23/11/2022.
//

import UIKit
import MapKit
import Cosmos

class ExploreMapVC: BaseVC {

    @IBOutlet weak var mapV: MKMapView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    
    @IBOutlet weak var listBtn: UIButton!
    @IBOutlet weak var seacrh: UITextField!
    @IBOutlet weak var shadV: UIView!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var rateV: CosmosView!
    @IBOutlet weak var ratingLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.setTitle("", for: .normal)
        listBtn.setTitle("", for: .normal)
        filterBtn.setTitle("", for: .normal)
        self.navigationController?.isNavigationBarHidden = true
        shadV.addShadow(12)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func backtap(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func listTap(_ sender: Any) {
        
    }
    
    @IBAction func filterTap(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .explore).loadViewController(withIdentifier: .schoolFilterVC) as! SchoolFilterVC
        self.show(vc, sender: self)
    }
}
