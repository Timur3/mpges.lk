//
//  OfficesViewController.swift
//  mpges.lk
//
//  Created by Timur on 29.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import YandexMapKit

class OfficesViewController: UIViewController {
    @IBOutlet weak var mapView: YMKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mapView.mapWindow.map.move(
        with: YMKCameraPosition.init(target: YMKPoint(latitude: 61.008456, longitude: 69.020479), zoom: 14, azimuth: 0, tilt: 0),
        animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
        cameraCallback: nil)
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
