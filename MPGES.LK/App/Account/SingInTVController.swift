//
//  SingInTVController.swift
//  mpges.lk
//
//  Created by Timur on 23.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class SingInTVController: UITableViewController {
    var sections: [String] {["Мои данные", "О программе", "Прочее"]}
    
    public weak var delegate: MainCoordinator?
    
    var exitCell: UITableViewCell { getCustomCell(textLabel: "Выйти", imageCell: myImage.power, textAlign: .left, textColor: .systemRed, accessoryType: .none) }
    var passChange: UITableViewCell { getCustomCell(textLabel: "Изменить пароль", imageCell: myImage.edit, textAlign: .left, textColor: .systemBlue, accessoryType: .none) }
    let nameCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.person, textAlign: .left, accessoryType: .none) }()
    var emailCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.paperplane, textAlign: .left, accessoryType: .none) }()
    var mobileCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.phone, textAlign: .left, accessoryType: .none) }()
    var saveCell: UITableViewCell { getCustomCell(textLabel: "Сохранить изменения", imageCell: myImage.save, textAlign: .left, textColor: .systemBlue, accessoryType: .none) }
    var aboutCell: UITableViewCell { getCustomCell(textLabel: "Разработчик", imageCell: myImage.person, textAlign: .left, textColor: .systemBlue, accessoryType: .none) }
    var emailToDeveloperCell: UITableViewCell { getCustomCell(textLabel: "Обратная связь", imageCell: myImage.mail, textAlign: .left, textColor: .systemBlue, accessoryType: .none) }
    
    var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите ваше имя"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Электронная почта"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = false
        return textField
    }()
    var mobileTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ваш сотовый"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var user: UserModel? {
        didSet {
            DispatchQueue.main.async {
                self.emailTextField.text = self.user?.Email
                self.nameTextField.text = self.user?.Name
                self.mobileTextField.text = self.user?.Mobile
            }
        }
    }
    override func viewDidLoad() {
        self.navigationItem.title = "Войти"
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    
    func setUpLayout(){
        nameCell.addSubview(nameTextField)
        nameTextField.leadingAnchor.constraint(equalTo: nameCell.leadingAnchor, constant: 50).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: nameCell.centerYAnchor).isActive = true
        emailCell.addSubview(emailTextField)
        emailTextField.leadingAnchor.constraint(equalTo: emailCell.leadingAnchor, constant: 50).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: emailCell.centerYAnchor).isActive = true
        mobileCell.addSubview(mobileTextField)
        mobileTextField.leadingAnchor.constraint(equalTo: mobileCell.leadingAnchor, constant: 50).isActive = true
        mobileTextField.centerYAnchor.constraint(equalTo: mobileCell.centerYAnchor).isActive = true
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
            return 4
        case 1:
            return 2
        case 2:
            return 2
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return nameCell
            case 1:
                return emailCell
            case 2:
                return mobileCell
            case 3:
                return saveCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return aboutCell
            case 1:
                return emailToDeveloperCell
            default:
                fatalError()
            }
        case 2:
            switch indexPath.row {
            case 0:
                return passChange
            case 1:
                return exitCell
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
        if indexPath.section == 0 && indexPath.row == 3 {
            //saveAlertSheetShow()
        }
        if indexPath.section == 1 && indexPath.row == 1 {
            // self.delegate?.navigationEmailToDeveloperPage()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            // alertSheetChangePasswordShow()
        }
        if indexPath.section == 2 && indexPath.row == 1 {
            // alertSheetExitShow()
        }
    }
    @objc func geToDemo() {
        let model = AuthModel(email: "demo@mp-ges.ru", password: "Qwerty123!")
        self.delegate?.authApi(model: model)
    }
}

extension SingInTVController {
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
extension SingInTVController {
    private func configuration() {
        let demoBtn = UIBarButtonItem(title: "Demo", style: .plain, target: self, action: #selector(geToDemo))
        self.navigationItem.rightBarButtonItems = [demoBtn]
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        self.hideKeyboardWhenTappedAround()
    }
}
