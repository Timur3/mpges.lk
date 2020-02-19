//
//  ContractAddViewController.swift
//  mpges.lk
//
//  Created by Timur on 03.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ContractAddViewController: UIViewController {
    @IBOutlet weak var numberContract: UITextField!
    @IBOutlet weak var codeBinding: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBAction func cancelBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        submitBtn.Circle()
        // Do any additional setup after loading the view.
    }
    
    @objc func submitAction(sender:UIButton!) {
        print("Button Clicked")
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
