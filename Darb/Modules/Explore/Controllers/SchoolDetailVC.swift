//
//  SchoolDetailVC.swift
//  Darb
//
//  Created by Naveed ur Rehman on 28/11/2022.
//

import UIKit
import ImageSlideshow
import MapKit
import StyledString

class SchoolDetailVC: BaseVC, ImageSlideshowDelegate {

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
    
    
    var school: SchoolListModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = btnBack(isOrignal: false)
        contactBtn.setTitle("", for: .normal)
        setData()
    }
    
    func setData() {
        if let school {
            if !school.gallery.isEmpty {
                setupSlider(galleryArr: school.gallery)
            }
            schoolName.text = school.name
            ratingLbl.set(image: UIImage(named: "ic_star")!, with: " \(school.totalReviews ?? "0.0")")
            if school.descriptionField == "" {
                
                let str = StyledString("INSTITUTION STRUCTURE AND CURRICULUM").with(foregroundColor: .black).with(font: UIFont(name: AppFonts.roboto_bold, size: 14))
                descripLbl.attributedText = str.nsAttributedString
            } else {
                let str = StyledString("INSTITUTION DESCRIPTION\n\n").with(foregroundColor: .black).with(font: UIFont(name: AppFonts.roboto_bold, size: 14)) + StyledString("\(school.descriptionField ?? "")\n\n").with(foregroundColor: .black).with(font: UIFont(name: AppFonts.roboto, size: 12)) + StyledString("INSTITUTION STRUCTURE AND CURRICULUM").with(foregroundColor: .black).with(font: UIFont(name: AppFonts.roboto_bold, size: 14))
                descripLbl.attributedText = str.nsAttributedString
            }
            
            stdType.text = school.studentType
            lvlOfEdu.text = school.levelOfEducation
            curriculum.text = school.offeredCurriculum
            building.text = school.buildings
            classRoom.text = school.classrooms
            lab.text = school.laborarities
            transport.text = school.transportation
            locLbl.text = school.location
            webSite.text = school.website
            mail.text = school.mail
            phone.text = school.phone
            
            configureMap(school: school)
        }
        slider.backgroundColor = UIColor(hexString: "#F2F2F2")
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
    func setupSlider(galleryArr: [Gallery]){
        var images = [SDWebImageSource]()
        for img in galleryArr {
            images.append(SDWebImageSource(urlString: img.name)!)
        }
        slider.setImageInputs(images)
        slider.pageIndicator?.numberOfPages = images.count
        slider.pageIndicatorPosition = PageIndicatorPosition(vertical: .customBottom(padding: 10))
        slider.slideshowInterval = 3.0
        slider.contentScaleMode = UIViewContentMode.scaleAspectFill
        slider.delegate = self
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        slider.addGestureRecognizer(gestureRecognizer)
    }
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        
    }
    @objc func didTap() {
        slider.presentFullScreenController(from: self)
    }
    
    @IBAction func applyTap(_ sender: Any) {
        let vc = UIStoryboard.storyBoard(withName: .explore).loadViewController(withIdentifier: .schoolEnrollVC) as! SchoolEnrollVC
        vc.school = school
        vc.progTyp = .half
        self.show(vc, sender: self)
    }
    
    
    @IBAction func contactTap(_ sender: Any) {
        
        let vc = UIStoryboard.storyBoard(withName: .chat).loadViewController(withIdentifier: .chatVC) as! ChatVC
        
        vc.schoolID = school.adminId
        vc.otherName = school.name
        
        self.show(vc, sender: self)
    }
    
}
