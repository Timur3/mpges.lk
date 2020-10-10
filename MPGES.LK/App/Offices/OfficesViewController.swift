//
//  OfficesViewController.swift
//  mpges.lk
//
//  Created by Timur on 12.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import YandexMapKit

class OfficesViewController: UIViewController, YMKUserLocationObjectListener {
    func onObjectAdded(with view: YMKUserLocationView) {
        
    }
    
    func onObjectRemoved(with view: YMKUserLocationView) {}
    
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {}
    
    @IBOutlet weak var mapView: YMKMapView!
    let MAIN_OFFICE = YMKPoint(latitude: 61.008456, longitude: 69.020479)
    let OFFICE_CHEHOVA = YMKPoint(latitude: 61.003223, longitude: 69.050226)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "Офисы"
        // Do any additional setup after loading the view.
        createOfObjects()
        //let scale = UIScreen.main.scale
        let mapKit = YMKMapKit.sharedInstance()
        
        let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)
        
        mapView.mapWindow.map.isRotateGesturesEnabled = false
        
        //mapView.mapWindow.map.move(with:
          //         YMKCameraPosition(target: YMKPoint(latitude: 0, longitude: 0), zoom: 14, azimuth: 0, tilt: 0))
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
        //userLocationLayer.setAnchorWithAnchorNormal(
          //  CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.5 * mapView.frame.size.height * scale),
          //  anchorCourse: CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.83 * mapView.frame.size.height * scale))
        
        userLocationLayer.setObjectListenerWith(self)
        
        mapView.mapWindow.map.move(
        with: YMKCameraPosition.init(target: YMKPoint(latitude: 61.008456, longitude: 69.020479), zoom: 13, azimuth: 0, tilt: 0),
        animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
        cameraCallback: nil)
    }
    
    func createOfObjects(){
        let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 30))
        iconView.image = UIImage(named:"MarkGES")
        let viewProvider = YRTViewProvider(uiView: iconView);
        
        let mapObjects = mapView.mapWindow.map.mapObjects
        
        let placeMarkMainOffice = mapObjects.addPlacemark(with: MAIN_OFFICE, view: viewProvider!)
        //placeMarkMainOffice
        placeMarkMainOffice.opacity = 0.5
        placeMarkMainOffice.isDraggable = false
        
        let placeMarkMainOfficeChehova = mapObjects.addPlacemark(with: OFFICE_CHEHOVA, view: viewProvider!)
        placeMarkMainOfficeChehova.opacity = 0.5
        placeMarkMainOfficeChehova.isDraggable = false
    }

}
