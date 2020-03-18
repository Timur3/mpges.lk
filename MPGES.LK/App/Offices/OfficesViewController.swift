//
//  OfficesViewController.swift
//  mpges.lk
//
//  Created by Timur on 12.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import YandexMapKit

class OfficesViewController: UIViewController {
    @IBOutlet weak var mapView: YMKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "Офисы"
        // Do any additional setup after loading the view.
        mapView.mapWindow.map.move(
        with: YMKCameraPosition.init(target: YMKPoint(latitude: 61.008456, longitude: 69.020479), zoom: 14, azimuth: 0, tilt: 0),
        animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
        cameraCallback: nil)
    }

}
