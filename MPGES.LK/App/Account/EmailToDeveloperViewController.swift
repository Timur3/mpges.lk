//
//  EmailToDeveloperViewController.swift
//  mpges.lk
//
//  Created by Timur on 22.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class EmailToDeveloperViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var emailSentBtn: UIButton!
    
    public weak var delegate: ProfileCoordinator?
    
    override func viewDidLoad() {
        self.title = "Новое письмо"
        super.viewDidLoad()
        configuration()
        // Do any additional setup after loading the view.
    }
}

extension EmailToDeveloperViewController {
    private func configuration() {
        self.hideKeyboardWhenTappedAround()
        
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.cornerRadius = 6
        textView.layer.masksToBounds = true
        emailSentBtn.Circle()

        let cancelBtn = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
    }
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension EmailToDeveloperViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
