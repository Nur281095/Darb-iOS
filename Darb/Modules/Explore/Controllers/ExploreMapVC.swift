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
    
    var school: SchoolListModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.setTitle("", for: .normal)
        listBtn.setTitle("", for: .normal)
        filterBtn.setTitle("", for: .normal)
        self.navigationController?.isNavigationBarHidden = true
        shadV.addShadow(12)
        
        setData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    func setData() {
        if let school {
            if !school.gallery.isEmpty {
                img.sd_setImage(with: URL(string: school.gallery[0].name)!)
            } else {
                img.image = nil
            }
            name.text = school.name
            address.text = school.location ?? ""
            rateV.rating = Double(school.totalReviews ?? "0") ?? 0.0
            ratingLbl.text = school.totalReviews ?? "0.0"
            configureMap(school: school)
        }
    }
    
    private func configureMap(school: SchoolListModel) {
        mapV.showsUserLocation = true
        mapV.showsCompass = true
        mapV.isZoomEnabled = true
        mapV.showsBuildings = true
        mapV.showsTraffic = true
        let coordinate = CLLocationCoordinate2D(latitude: Double(school.lat ?? "0") ?? 0.0, longitude: Double(school.lang ?? "0") ?? 0.0)
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapV.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        mapV.addAnnotation(pin)
    }
    
    @IBAction func backtap(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func listTap(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func schoolTap(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .explore).loadViewController(withIdentifier: .schoolDetailVC) as! SchoolDetailVC
        vc.school = school
        self.show(vc, sender: self)
    }
    
    @IBAction func filterTap(_ sender: Any) {
//        let vc = UIStoryboard.storyBoard(withName: .explore).loadViewController(withIdentifier: .schoolFilterVC) as! SchoolFilterVC
//        self.show(vc, sender: self)
    }
}
