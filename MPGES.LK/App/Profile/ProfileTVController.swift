//
//  ProfileTVController.swift
//  mpges.lk
//
//  Created by Timur on 02.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

protocol ProfileTVControllerDelegate: AnyObject {
    func navigateToFirstPage()
    func navigationChangePasswordPage()
    func navigationEmailToDeveloperPage()
    func navigationAboutPage()
    func navigationToMailSend()
    func navigationToPageEnterCode()
}

protocol ProfileTVControllerUserDelegate: AnyObject {
    func getProfile()
    func setProfile(profile: ResultModel<UserModel>)
    func saveProfile(profile: UserModel)
    func resultOfSaveProfile(result: ResultModel<String>)
}

class ProfileTVController: CommonViewController, UITableViewDelegate, UITableViewDataSource {
    var sections: [String] {["Мои данные", "О программе", "Прочее", ""]}
    
    public weak var delegate: ProfileTVControllerDelegate?
    private var indexPath: IndexPath?
    
    private lazy var profileTable: UITableView = {
        let table = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        table.isUserInteractionEnabled = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    var deleteAccountCell: UITableViewCell { getCustomCell(textLabel: "Удалить аккаунт", imageCell: myImage.deleted, textAlign: .left, textColor: .systemRed, accessoryType: .none) }
    var exitCell: UITableViewCell { getCustomCell(textLabel: "Выйти", imageCell: myImage.power, textAlign: .left, textColor: .systemRed, accessoryType: .none) }
    var passChange: UITableViewCell { getCustomCell(textLabel: "Изменить пароль", imageCell: myImage.edit, textAlign: .left, textColor: .systemBlue, accessoryType: .none) }
    let nameCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.person, textAlign: .left, accessoryType: .none) }()
    var emailCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.at, textAlign: .left, accessoryType: .none) }()
    var mobileCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.phone, textAlign: .left, accessoryType: .none) }()
    var saveCell: UITableViewCell { getCustomCell(textLabel: "Сохранить изменения", imageCell: myImage.save, textAlign: .left, textColor: .systemBlue, accessoryType: .none) }
    var aboutCell: UITableViewCell { getCustomCell(textLabel: "Разработчик", imageCell: myImage.person, textAlign: .left, textColor: .systemBlue, accessoryType: .none) }
    var emailToDeveloperCell: UITableViewCell { getCustomCell(textLabel: "Обратная связь", imageCell: myImage.envelope, textAlign: .left, textColor: .systemBlue, accessoryType: .none) }
    
    var nameTextField: UITextField = { getCustomTextField(placeholder: "Введите ваше имя", text: "Фамилия имя отчество") }()
    var emailTextField: UITextField = { getCustomTextField(placeholder: "Электронная почта", text: "Электронная почта", isUserInteractionEnabled: false) }()
    var mobileTextField: UITextField = { getCustomTextField(placeholder: "Ваш сотовый", text: "Ваш сотовый", keyboardType: .numberPad) }()
    
    var user: UserModel? {
        didSet {
            DispatchQueue.main.async {
                self.emailTextField.text = self.user?.email
                self.nameTextField.text = self.user?.name
                self.mobileTextField.text = self.user?.mobile
                self.profileTable.reloadData()
                self.hideLoadingIndicator()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        setUpLayout()
        getData()
    }
    
    @objc func getData()
    {
        self.getProfile()
    }
    
    func setUpLayout(){
        view.addSubview(profileTable)
        NSLayoutConstraint.activate([
            profileTable.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            profileTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            profileTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            profileTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
        nameCell.contentView.addSubview(nameTextField)
        nameTextField.leadingAnchor.constraint(equalTo: nameCell.leadingAnchor, constant: 50).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: nameCell.centerYAnchor).isActive = true
        emailCell.contentView.addSubview(emailTextField)
        emailTextField.leadingAnchor.constraint(equalTo: emailCell.leadingAnchor, constant: 50).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: emailCell.centerYAnchor).isActive = true
        mobileCell.contentView.addSubview(mobileTextField)
        mobileTextField.leadingAnchor.constraint(equalTo: mobileCell.leadingAnchor, constant: 50).isActive = true
        mobileTextField.centerYAnchor.constraint(equalTo: mobileCell.centerYAnchor).isActive = true
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 4
        case 1, 2:
            return 2
        case 3:
            return 1
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        case 3:
            switch indexPath.row {
            case 0:
                return deleteAccountCell
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexPath = indexPath
        
        if indexPath.section == 0 && indexPath.row == 0 {
            nameTextField.becomeFirstResponder()
        }
        if indexPath.section == 0 && indexPath.row == 2 {
            mobileTextField.becomeFirstResponder()
        }
        if indexPath.section == 0 && indexPath.row == 3 {
            ActivityIndicatorViewForCellService.shared.showAI(cell: self.profileTable.cellForRow(at: self.indexPath!)!)
            saveAlertSheetShow()
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            self.delegate?.navigationAboutPage()
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
        if indexPath.section == 3 && indexPath.row == 0 {
            alertSheetDeletedAccountShow()
        }
    }
}

extension ProfileTVController: ProfileTVControllerUserDelegate {
    func getProfile() {
        self.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            ApiServiceWrapper.shared.getProfileById(delegate: self)
            self.profileTable.refreshControl?.endRefreshing()
        }
    }
    
    func saveProfile(profile: UserModel) {
        ApiServiceWrapper.shared.updateUser(model: profile, delegate: self)
    }
    func resultOfSaveProfile(result: ResultModel<String>) {
        self.showAlert(title: result.isError ? "Ошибка!" : "Успешно!", mesg: result.message!)
        self.hiddenAI()
    }
    
    func setProfile(profile: ResultModel<UserModel>) {
        user = profile.data
    }
    
    func hiddenAI(){
        guard let index = self.indexPath else { return }
        ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.profileTable.cellForRow(at: index)!)
        ActivityIndicationService.shared.hideView()
    }
}

//MARK: - CONFIGURE
extension ProfileTVController {
    private func configuration() {
        self.profileTable.refreshControl = UIRefreshControl()
        self.profileTable.refreshControl?.addTarget(self, action: #selector(getData), for: UIControl.Event.valueChanged)
        self.hideKeyboardWhenTappedAround()
    }
    func saveAlertSheetShow() {
        self.showActionSheetConfirm(title: "Внимание!", mesg: "Вы подтверждаете операцию?", handlerYes: { (UIAlertAction) in
            self.user?.name = self.nameTextField.text!
            self.user?.email = self.emailTextField.text!
            self.user?.mobile = self.mobileTextField.text!
            // save
            self.saveProfile(profile: self.user!)
        }){ (UIAlertAction) in
            self.hiddenAI()
        }
    }
    
    func alertSheetExitShow(){
        self.showActionSheetConfirm(title: "Внимание!", mesg: "Вы действительно хотите выйти из программы?", handlerYes: { (UIAlertAction) in
            UserDataService.shared.delToken()
            self.delegate?.navigateToFirstPage()
        })
    }
    
    func alertSheetDeletedAccountShow(){
        self.delegate?.navigationToPageEnterCode()
        //self.delegate?.navigateToFirstPage()
    }
}
