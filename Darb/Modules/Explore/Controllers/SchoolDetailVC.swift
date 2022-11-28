//
//  SchoolDetailVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 28/11/2022.
//

import UIKit
import ImageSlideshow
import MapKit

class SchoolDetailVC: BaseVC {

    @IBOutlet weak var slideH: NSLayoutConstraint! //176
    @IBOutlet weak var slider: ImageSlideshow!
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var contactBtn: UIButton!
    @IBOutlet weak var descripLbl: UILabel!
    @IBOutlet weak var stdType: UILabel!
    @IBOutlet weak var lvlOfEdu: UILabel!
    @IBOutlet weak var curriculum: UILabel!
    @IBOutlet weak var building: UILabel!
    @IBOutlet weak var classRoom: UILabel!
    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var transport: UILabel!
    @IBOutlet weak var locLbl: UILabel!
    @IBOutlet weak var mapV: MKMapView!
    @IBOutlet weak var webSite: UILabel!
    @IBOutlet weak var mail: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func applyTap(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
