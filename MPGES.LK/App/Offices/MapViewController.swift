//
//  OfficesViewController.swift
//  mpges.lk
//
//  Created by Timur on 12.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol MapViewControllerDelegate: AnyObject {
    func setOffices(for model: ResultModel<[OfficeMarkModel]>)
}

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    let locationDistance: Double = 2000
    let initialLocation = CLLocation(latitude: 61.002499, longitude: 69.034413)
    
    private lazy var locationView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.backgroundColor = .white
        view.alpha = 0.6
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "location.fill")
        return imageView
    }()
    
    private var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.distanceFilter = 10
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMap()
        configure()
        setupGestures()
        getOffices()
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(locationImageTap))
        locationImageView.isUserInteractionEnabled = true
        locationImageView.addGestureRecognizer(tapGesture)
        
        locationView.isUserInteractionEnabled = true
        locationView.addGestureRecognizer(tapGesture)
    }
    
    @objc func locationImageTap() {
        let viewRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: locationDistance, longitudinalMeters: locationDistance)
        self.mapView.setRegion(viewRegion, animated: true)
    }
    
    private func configure() {
        locationView.addSubview(locationImageView)
        mapView.addSubview(locationView)
        
        NSLayoutConstraint.activate([
            //image
            locationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            locationView.widthAnchor.constraint(equalToConstant: 40),
            locationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            locationView.heightAnchor.constraint(equalToConstant: 40),
            //image
            locationImageView.centerYAnchor.constraint(equalTo: locationView.centerYAnchor),
            locationImageView.centerXAnchor.constraint(equalTo: locationView.centerXAnchor),
            locationImageView.widthAnchor.constraint(equalToConstant: 25),
            locationImageView.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    private func setup() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func createMap(regionRadius: CLLocationDistance = 2000) {
        
        let coordinateRegion = MKCoordinateRegion(
            center: initialLocation.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func createOfObject(model: OfficeMarkModel){
        let coordinate = CLLocation(latitude: model.latitude, longitude: model.longitude)
        let point = MKPointAnnotation()
        point.title = model.name
        //point.description = model.description
        point.coordinate = coordinate.coordinate
        
        mapView.addAnnotation(point)
    }
    
    func getOffices(){
        ApiServiceWrapper.shared.getOffices(delegate: self)
    }
}

extension MapViewController: OfficesViewControllerDelegate {
    func setOffices(for model: ResultModel<[OfficeMarkModel]>) {
        for mark in model.data! {
            createOfObject(model: mark)
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
}
