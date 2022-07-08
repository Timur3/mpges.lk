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

protocol OfficesViewControllerDelegate: AnyObject {
    func setOffices(for model: ResultModel<[OfficeMarkModel]>)
}

class OfficesViewController: UIViewController, MKMapViewDelegate {
    
    func onObjectAdded(with view: MKUserLocationView) {}
    
    func onObjectRemoved(with view: MKUserLocationView) {}
    
    //func onObjectUpdated(with view: MKUserLocationView, event: MKObjectEvent) {}
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        //self.title = "Офисы"
        // Do any additional setup after loading the view.
        createMap()
        //getOffices()
        
    }
    
    private func setup() {
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
            
        ])
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        print("show")
    }

    func createMap(regionRadius: CLLocationDistance = 1000) {
        let initialLocation = CLLocation(latitude: 61.008456, longitude: 69.020479)
        let coordinateRegion = MKCoordinateRegion(
            center: initialLocation.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
//
//    func startPosition() {
//        mapView.mapWindow.map.move(
//        with: MKCameraPosition.init(target: startPoint, zoom: 13, azimuth: 0, tilt: 0),
//            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
//        cameraCallback: nil)
//    }
//
//
//    func createOfObject(model: OfficeMarkModel){
//        let markPoint = CLLocation(latitude: model.latitude, longitude: model.longitude)
//        let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
//        iconView.image = UIImage(named: myImage.markLogo.rawValue)
//        let viewProvider = YRTViewProvider(uiView: iconView);
//
//        let mapObjects = mapView.mapWindow.map.mapObjects
//
//        let placeMark = mapObjects.addPlacemark(with: markPoint, view: viewProvider!)
//        placeMark.opacity = 1
//        placeMark.userData = model
//        placeMark.isDraggable = false
//        placeMark.addTapListener(with: self)
//        let iconStyle = YMKIconStyle()
//        iconStyle.anchor = CGPoint(x: 0.5, y: 1.0) as NSValue
//        placeMark.setIconStyleWith(iconStyle)
//    }
//
//
//
//    func getOffices(){
//        ApiServiceWrapper.shared.getOffices(delegate: self)
//    }
}

//extension OfficesViewController: OfficesViewControllerDelegate {
//    func setOffices(for model: ResultModel<[OfficeMarkModel]>) {
//        for mark in model.data! {
//            createOfObject(model: mark)
//        }
//    }
//}
//
//extension OfficesViewController: YMKMapObjectTapListener {
//    func onMapObjectTap(with mapObject: YMKMapObject, point: MKMapPoint) -> Bool {
//        guard mapObject is YMKMapObject else { return false }
//
//        let model = mapObject.userData as! OfficeMarkModel
//        print(model.name)
//        return true
//    }
//}
