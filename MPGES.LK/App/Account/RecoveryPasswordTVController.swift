//
//  RecoveryPasswordTVController.swift
//  mpges.lk
//
//  Created by Timur on 19.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol RecoveryPasswordTVControllerUserDelegate: class {
    func goToRecoveryPassword()
    func resultOfCheckEmail(result: ServerResponseModel)
    func resultOfPassordRecovery(result: ServerResponseModel)
}

class RecoveryPasswordTVController: UITableViewController {
    
    public weak var delegate: ContractsTVControllerUserDelegate?
    
    var sections: [String] {["Email указанный при регистрации", ""]}
    
    var emailCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.paperplane, textAlign: .left, accessoryType: .none) }()
    var submitCell: UITableViewCell { getCustomCell(textLabel: "Напомнить", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "example@email.com"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override func viewDidLoad() {
        self.navigationItem.title = "Забыли пароль"
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Получение списка договоров
        delegate?.getContracts()
    }
    
    func setUpLayout(){
        emailCell.addSubview(emailTextField)
        emailTextField.leadingAnchor.constraint(equalTo: emailCell.leadingAnchor, constant: 50).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: emailCell.centerYAnchor).isActive = true
    }
    
    @objc func submitAction() {
        ActivityIndicatorViewService.shared.showView(form: self.view)
        let model = UserEmailModel(email: emailTextField.text!)
        ApiServiceAdapter.shared.passwordRecovery(model: model, delegate: self)
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return emailCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return submitCell
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 && indexPath.row == 0 {
            submitAction()
        }
    }
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RecoveryPasswordTVController: RecoveryPasswordTVControllerUserDelegate {
    func resultOfCheckEmail(result: ServerResponseModel) {
        ActivityIndicatorViewService.shared.hideView()
       // sendPassword.isEnabled = !result.isError
      //  if result.isError {
       //     errorTextLabel.text = result.message
      //      emailTF.shake(times: 3, delta: 5)
      //  } else {errorTextLabel.text = ""}
    }
    
    @objc func goToRecoveryPassword() {
        ActivityIndicatorViewService.shared.showView(form: self.view)
      //  model = UserEmailModel(email: emailTF.text!)
        //ApiServiceAdapter.shared.passwordRecovery(model: model!, delegate: self)
    }
    
    func resultOfPassordRecovery(result: ServerResponseModel) {
        ActivityIndicatorViewService.shared.hideView()
        if result.isError {
            //errorTextLabel.text = result.message
          //  emailTF.shake(times: 3, delta: 5)
        } else {
            AlertControllerAdapter.shared.show(
                title: "Успех!",
                mesg: result.message,
                form: self) { (UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
extension RecoveryPasswordTVController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - CONFIGURE
extension RecoveryPasswordTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        
        let cancelBtn = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
        
        self.hideKeyboardWhenTappedAround()
    }
}
