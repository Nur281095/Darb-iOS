//
//  ExploreMapVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 23/11/2022.
//

import UIKit
import MapKit
import AAExtensions
import Cosmos

class ExploreMapVC: BaseVC, MKMapViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var mapV: MKMapView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    
    @IBOutlet weak var listBtn: UIButton!
    @IBOutlet weak var seacrh: UITextField!
    @IBOutlet weak var shadV: UIView!
    
    @IBOutlet weak var searchV: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var rateV: CosmosView!
    @IBOutlet weak var ratingLbl: UILabel!
    
    var schoolListModel = [SchoolListModel]()
    var filterSchoolList = [SchoolListModel]()
    var selectedIndex = -1
    var isfilter = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if schoolListModel.isEmpty {
            shadV.isHidden = true
            searchV.isHidden = true
        } else {
            shadV.isHidden = false
            searchV.isHidden = false
        }
        configureMap()
        backBtn.setTitle("", for: .normal)
        listBtn.setTitle("", for: .normal)
        filterBtn.setTitle("", for: .normal)
        self.navigationController?.isNavigationBarHidden = true
        shadV.addShadow(12)
        mapV.delegate = self
        seacrh.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
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
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.aa_isEmpty {
            isfilter = false
            setData()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !textField.aa_isEmpty {
            isfilter = true
            filterSchoolList = schoolListModel.filter({$0.name.contains(textField.text!)})
        } else {
            isfilter = false
        }
        setData()
        textField.resignFirstResponder()
        return true
    }
    func setData() {
        mapV.removeAnnotations(mapV.annotations)
        if isfilter {
            if let schl = filterSchoolList.first {
                selectedIndex = 0
                setSchool(schl: schl)
            }
            for school in filterSchoolList {
                configureMap(school: school)
            }
        } else {
            if let schl = schoolListModel.first {
                selectedIndex = 0
                setSchool(schl: schl)
            }
            for school in schoolListModel {
                configureMap(school: school)
            }
        }
        
    }
    private func setSchool(schl: SchoolListModel) {
        if !schl.gallery.isEmpty {
            img.sd_setImage(with: URL(string: schl.gallery[0].name)!)
        } else {
            img.image = nil
        }
        name.text = schl.name
        address.text = schl.location ?? ""
        rateV.rating = Double(schl.totalReviews ?? "0") ?? 0.0
        ratingLbl.text = schl.totalReviews ?? "0.0"
    }
    private func configureMap(school: SchoolListModel? = nil) {
        mapV.showsUserLocation = true
        mapV.showsCompass = true
        mapV.isZoomEnabled = true
        mapV.showsBuildings = true
        mapV.showsTraffic = true
        var coordinate: CLLocationCoordinate2D?
        if let loc = AppLocation.loc {
            coordinate = loc
        } else {
            if let school {
                coordinate = CLLocationCoordinate2D(latitude: Double(school.lat ?? "0") ?? 0.0, longitude: Double(school.lang ?? "0") ?? 0.0)
            }
        }
//        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        if let coordinate {
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapV.setRegion(region, animated: true)
            if let school {
                let pin = MKPointAnnotation()
                pin.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                pin.title = school.name
                pin.subtitle = "\(school.id!)"
                mapV.addAnnotation(pin)
            }
        }
       
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("MKAnnotationView")
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print("MKAnnotation")
        if isfilter {
            if let index = filterSchoolList.firstIndex(where: {$0.id == annotation.subtitle??.aa_toInt}) {
                selectedIndex = index
                self.setSchool(schl: filterSchoolList[index])
            }
        } else {
            if let index = schoolListModel.firstIndex(where: {$0.id == annotation.subtitle??.aa_toInt}) {
                selectedIndex = index
                self.setSchool(schl: schoolListModel[index])
            }
        }
    }
    
    @IBAction func backtap(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func listTap(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func schoolTap(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .explore).loadViewController(withIdentifier: .schoolDetailVC) as! SchoolDetailVC
        if isfilter {
            vc.school = filterSchoolList[selectedIndex]
        } else {
            vc.school = schoolListModel[selectedIndex]
        }
        self.show(vc, sender: self)
    }
    
    @IBAction func filterTap(_ sender: Any) {
//        let vc = UIStoryboard.storyBoard(withName: .explore).loadViewController(withIdentifier: .schoolFilterVC) as! SchoolFilterVC
//        self.show(vc, sender: self)
    }
}
