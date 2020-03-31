//
//  ChangePasswordViewController.swift
//  mpges.lk
//
//  Created by Timur on 20.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
protocol ChangePasswordViewControllerDelegate: class {
    func navigateToBackPage()
}

class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordConfirmTF: UITextField!
    
    public weak var delegate: ChangePasswordViewControllerDelegate?
    
    override func viewDidLoad() {
        self.title = "Новый пароль"
        super.viewDidLoad()
        configuration()
        // Do any additional setup after loading the view.
    }

    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func submitAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
//MARK: CONFiGURE
extension ChangePasswordViewController {
        private func configuration() {
            submitBtn.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
            submitBtn.Circle()
            let cancelBtn = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButton))
            self.navigationItem.rightBarButtonItems = [cancelBtn]
        }
    }
