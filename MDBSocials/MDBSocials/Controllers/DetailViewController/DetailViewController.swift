//
//  DetailViewController.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/19/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit
import CoreGraphics
import CoreLocation
import MapKit

class DetailViewController: UIViewController {
    
    var post: Post!
    var currentLocation: CLLocationCoordinate2D?
    let locationManager = CLLocationManager()

    var firstBlockView: UIView!
    var mainImageView: UIImageView!
    var mapView: MKMapView!
    
    var secondBlockView: UIView!
    var descriptionLabel: UILabel!
    var posterNameLabel: UILabel!

    var thirdBlockView: UIView!
    var imInterestedButton: UIButton!
    var viewInterestedButton: UIButton!
    var interestedLabel: UILabel!
    
    var fourthBlockView: UIView!
    var lyftLogo: UIImageView!
    var lyftInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        setupFirstBlock()
        setupSecondBlock()
        setupThirdBlock()
        setupFourthBlock()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = post.eventName!
        mainImageView.image = post.image ?? UIImage(named: "defaultImage")
        setInterestedButtonState()
        populateLabelInfo()
        //queryLyft()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        queryLyft()
    }
    
    func setupFirstBlock(){
        let yPos = CGFloat(85)
        firstBlockView = UIView(frame: CGRect(x: 15, y: yPos, width: view.frame.width - 30, height: 200))
        firstBlockView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        firstBlockView.layer.cornerRadius = 10
        view.addSubview(firstBlockView)
        
        mainImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: firstBlockView.frame.width/2 - 20, height: firstBlockView.frame.height - 20))
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = 10
        mainImageView.layer.masksToBounds = true
        firstBlockView.addSubview(mainImageView)
        
        mapView = MKMapView(frame: CGRect(x: firstBlockView.frame.width/2 + 10, y: 10, width: firstBlockView.frame.width/2 - 20, height: firstBlockView.frame.height - 20))
        mapView.mapType = .standard
        mapView.layer.cornerRadius = 10
        mapView.layer.masksToBounds = true
        firstBlockView.addSubview(mapView)
    }
    
    func setupSecondBlock(){
        let yPos = firstBlockView.frame.minY + firstBlockView.frame.height + 20
        secondBlockView = UIView(frame: CGRect(x: 15, y: yPos , width: view.frame.width - 30, height: 90))
        secondBlockView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        secondBlockView.layer.cornerRadius = 10
        view.addSubview(secondBlockView)
        
        posterNameLabel = UILabel(frame: CGRect(x: 15, y: 5, width: view.frame.width - 30, height: 30))
        posterNameLabel.textAlignment = .left
        posterNameLabel.font = UIFont(name: "Helvetica Bold", size: 18)

        posterNameLabel.textColor = .white
        secondBlockView.addSubview(posterNameLabel)
        
        let divider = UIView(frame: CGRect(x: 15, y: 40, width: secondBlockView.frame.width - 30, height: 3))
        divider.backgroundColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        secondBlockView.addSubview(divider)
        
        descriptionLabel = UILabel(frame: CGRect(x: 15, y: 50, width: secondBlockView.frame.width - 30, height: 30))
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .left
        secondBlockView.addSubview(descriptionLabel)
    }
    
    func setupThirdBlock(){
        let yPos = secondBlockView.frame.minY + secondBlockView.frame.height + 20
        thirdBlockView = UIView(frame: CGRect(x: 15, y: yPos, width: view.frame.width - 30, height: 125))
        thirdBlockView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        thirdBlockView.layer.cornerRadius = 10
        view.addSubview(thirdBlockView)
        
        interestedLabel = UILabel(frame: CGRect(x: 15, y: 5, width: thirdBlockView.frame.width - 30, height: 30))
        interestedLabel.textColor = .white
        thirdBlockView.addSubview(interestedLabel)
        
        let divider = UIView(frame: CGRect(x: 15, y: 40, width: thirdBlockView.frame.width - 30, height: 3))
        divider.backgroundColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        thirdBlockView.addSubview(divider)

        imInterestedButton = UIButton(frame: CGRect(x: 10, y: 60, width: thirdBlockView.frame.width/2 - 20, height: 50))
        imInterestedButton.addTarget(self, action: #selector(tappedImInterested), for: .touchUpInside)
        imInterestedButton.layer.cornerRadius = 10
        imInterestedButton.titleLabel?.numberOfLines = 2
        //imInterestedButton.titleLabel?.adjustsFontSizeToFitWidth = true
        thirdBlockView.addSubview(imInterestedButton)
        
        viewInterestedButton = UIButton(frame: CGRect(x: thirdBlockView.frame.width/2 + 10, y: 60, width: thirdBlockView.frame.width/2 - 20, height: 50))
        viewInterestedButton.addTarget(self, action: #selector(tappedViewInterested), for: .touchUpInside)
        viewInterestedButton.layer.cornerRadius = 10
        viewInterestedButton.setTitle("View Interested", for: .normal)
        viewInterestedButton.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        viewInterestedButton.backgroundColor = .white
        viewInterestedButton.titleLabel?.adjustsFontSizeToFitWidth = true
        thirdBlockView.addSubview(viewInterestedButton)
    }
    
    func setupFourthBlock(){
        let yPos = thirdBlockView.frame.minY + thirdBlockView.frame.height + 20
        fourthBlockView = UIView(frame: CGRect(x: 15, y: yPos, width: view.frame.width - 30, height: 80))
        fourthBlockView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        fourthBlockView.layer.cornerRadius = 10
        view.addSubview(fourthBlockView)
        
        lyftLogo = UIImageView(frame: CGRect(x: 10, y: 10, width: fourthBlockView.frame.height - 20, height: fourthBlockView.frame.height - 20))
        lyftLogo.image = #imageLiteral(resourceName: "lyftLogo")
        fourthBlockView.addSubview(lyftLogo)
        
        lyftInfoLabel = UILabel(frame: CGRect(x: 80, y: 10, width: fourthBlockView.frame.width - 80, height: fourthBlockView.frame.height - 20))
        lyftInfoLabel.textColor = .white
        lyftInfoLabel.numberOfLines = 2
        fourthBlockView.addSubview(lyftInfoLabel)
    }
    
    func queryLyft(){
        let eventLocation = CLLocationCoordinate2DMake(post.latitude!, post.longitude!)
        if currentLocation != nil {
            LyftHelper.getRideEstimate(pickup: currentLocation!, dropoff: eventLocation) { costEstimate in
                self.lyftInfoLabel.text = "A Lyft ride will cost $" + String(describing: costEstimate.estimate!.maxEstimate.amount) + " from your location."
            }
        } else {
            print("Cant get current location")
        }
    }
    
    func populateLabelInfo(){
        descriptionLabel.text = post.description
        interestedLabel.text = "Members Interested: " + String(describing: post.getInterestedUserIds().count)
        posterNameLabel.text = "Posted By: " + post.posterName!
    }
    
    func setInterestedButtonState(){
        var userHasSaidInterested = false
        for id in post.getInterestedUserIds() {
            if id as! String == FirebaseAuthHelper.getCurrentUser()?.uid {
                userHasSaidInterested = true
                break
            }
        }
        
        if userHasSaidInterested {
            imInterestedButton.setTitle("I'm Already Interested", for: .normal)
            imInterestedButton.setTitleColor(.darkGray, for: .normal)
            imInterestedButton.backgroundColor = .clear
            imInterestedButton.isUserInteractionEnabled = false
        }
        else{
            imInterestedButton.setTitle("I'm Interested!", for: .normal)
            imInterestedButton.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
            imInterestedButton.backgroundColor = .white
            imInterestedButton.isUserInteractionEnabled = true
        }
    }
    
    @objc func tappedImInterested(){
        FirebaseDatabaseHelper.updateInterested(postId: post.id!, userId: (FirebaseAuthHelper.getCurrentUser()?.uid)!).then { success -> Void in
            print("Updated interested")
            self.imInterestedButton.setTitle("Already Interested", for: .normal)
            self.imInterestedButton.setTitleColor(.darkGray, for: .normal)
            self.imInterestedButton.isUserInteractionEnabled = false
            self.post.addInterestedUser(userID: (FirebaseAuthHelper.getCurrentUser()?.uid)!)
            //post.interestedUserDictionary.append(["": ])
            self.interestedLabel.text = "Members Interested: " + String(describing: self.post.getInterestedUserIds().count)
        }
    }
    
    @objc func tappedViewInterested(){
        self.performSegue(withIdentifier: "showInterestedUsers", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is InterestedUsersViewController {
            let dest = segue.destination as! InterestedUsersViewController
            dest.userIDArray = post.interestedUserIds
        }
    }
}

extension DetailViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Updated location")
        guard let currentLoc: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.currentLocation = currentLoc
    }
}
