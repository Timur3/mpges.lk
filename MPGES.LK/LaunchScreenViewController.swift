//
//  LaunchScreenViewController.swift
//  mpges.lk
//
//  Created by Timur on 04.04.2021.
//  Copyright © 2021 ChalimovTimur. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let gv = GradientView(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
        gv.startColor = .gray
        gv.endColor = .white
        self.view = gv
        // Do any additional setup after loading the view.
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
