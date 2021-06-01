//
//  OfficesViewController.swift
//  mpges.lk
//
//  Created by Timur on 12.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import YandexMapKit

protocol OfficesViewControllerDelegate: class {
    func setOffices(for model: ResultModel<[OfficeMarkModel]>)
}

class OfficesViewController: UIViewController, YMKUserLocationObjectListener {
    
    func onObjectAdded(with view: YMKUserLocationView) {}
    
    func onObjectRemoved(with view: YMKUserLocationView) {}
    
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {}
    
    @IBOutlet weak var mapView: YMKMapView!
    let startPoint = YMKPoint(latitude: 61.008456, longitude: 69.020479)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "Офисы"
        // Do any additional setup after loading the view.
        createMap()
        getOffices()
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        print("show")
    }
    
    func createMap() {
        let mapKit = YMKMapKit.sharedInstance()
        
        let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)
        
        mapView.mapWindow.map.isRotateGesturesEnabled = false
        
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
        
        userLocationLayer.setObjectListenerWith(self)
        
        startPosition()
    }
    
    func startPosition() {
        mapView.mapWindow.map.move(
        with: YMKCameraPosition.init(target: startPoint, zoom: 13, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
        cameraCallback: nil)
    }
    
    
    func createOfObject(model: OfficeMarkModel){
        let markPoint = YMKPoint(latitude: model.latitude, longitude: model.longitude)
        let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        iconView.image = UIImage(named: myImage.markLogo.rawValue)
        let viewProvider = YRTViewProvider(uiView: iconView);
        
        let mapObjects = mapView.mapWindow.map.mapObjects
        
        let placeMark = mapObjects.addPlacemark(with: markPoint, view: viewProvider!)
        placeMark.opacity = 1
        placeMark.userData = model
        placeMark.isDraggable = false
        placeMark.addTapListener(with: self)
        let iconStyle = YMKIconStyle()
        iconStyle.anchor = CGPoint(x: 0.5, y: 1.0) as NSValue
        placeMark.setIconStyleWith(iconStyle)
    }

    
    
    func getOffices(){
        ApiServiceWrapper.shared.getOffices(delegate: self)
    }
}

extension OfficesViewController: OfficesViewControllerDelegate {
    func setOffices(for model: ResultModel<[OfficeMarkModel]>) {
        for mark in model.data! {
            createOfObject(model: mark)
        }
    }
}

extension OfficesViewController: YMKMapObjectTapListener {
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        guard let placemark = mapObject as? YMKMapObject else { return false }
        
        let model = mapObject.userData as! OfficeMarkModel
        print(model.name)
        return true
    }
}
