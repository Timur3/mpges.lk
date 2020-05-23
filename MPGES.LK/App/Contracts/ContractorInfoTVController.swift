//
//  ContractorInfoTVController.swift
//  mpges.lk
//
//  Created by Timur on 04.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ContractorInfoTVController: CommonTableViewController {
    var sections: [String] {["ФИО", "Паспортные данные", ""]}
    
    public weak var delegate: ProfileTVControllerDelegate?
    
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
                self.emailTextField.text = self.user?.email
                self.nameTextField.text = self.user?.name
                self.mobileTextField.text = self.user?.mobile
            }
        }
    }
    override func viewDidLoad() {
        self.navigationItem.title = "Информация"
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    @objc func refreshData()
    {
        //self.getProfile()
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
        self.indexPath = indexPath
        
        if indexPath.section == 0 && indexPath.row == 0 {
            nameTextField.becomeFirstResponder()
        }
        if indexPath.section == 0 && indexPath.row == 2 {
            mobileTextField.becomeFirstResponder()
        }
        if indexPath.section == 0 && indexPath.row == 3 {
            ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
            saveAlertSheetShow()
        }
        if indexPath.section == 1 && indexPath.row == 1 {
            self.delegate?.navigationEmailToDeveloperPage()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            self.delegate?.navigationChangePasswordPage()
        }
        if indexPath.section == 2 && indexPath.row == 1 {
            alertSheetExitShow()
        }
    }
}

extension ContractorInfoTVController: ProfileTVControllerUserDelegate {
    func getProfile() {
        ApiServiceAdapter.shared.getProfileById(delegate: self)
        self.refreshControl?.endRefreshing()
    }
    
    func saveProfile(profile: UserModel) {
        ApiServiceAdapter.shared.updateUser(model: profile, delegate: self)
    }
    func resultOfSaveProfile(result: ServerResponseModel) {
        AlertControllerAdapter.shared.show(title: result.isError ? "Ошибка!" : "Успешно!", mesg: result.message, form: self)
        ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
    }
    
    func setProfile(profile: UserModel) {
        user = profile
    }
}

//MARK: - CONFIGURE
extension ContractorInfoTVController {
    private func configuration() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]

        self.hideKeyboardWhenTappedAround()
    }
    func saveAlertSheetShow() {
        AlertControllerAdapter.shared.actionSheetConfirmShow(title: "Внимание!", mesg: "Вы подтверждаете операцию?", form: self, handlerYes: { (UIAlertAction) in
            self.user?.name = self.nameTextField.text!
            self.user?.email = self.emailTextField.text!
            self.user?.mobile = self.mobileTextField.text!
            // save
            self.saveProfile(profile: self.user!)
        })
    }
    
    func alertSheetExitShow(){
        AlertControllerAdapter.shared.actionSheetConfirmShow(title: "Внимание!", mesg: "Вы действительно хотите выйти из программы?", form: self, handlerYes: { (UIAlertAction) in
            self.delegate?.navigateToFirstPage()
        })
    }
}
