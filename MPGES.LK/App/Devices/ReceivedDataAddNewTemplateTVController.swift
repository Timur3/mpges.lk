//
//  ReceivedDataAddNewTemplateTVController.swift
//  mpges.lk
//
//  Created by Timur on 19.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol ReceivedDataAddNewTemplateTVControllerDelegate: class {
    func setData(model: ReceivedDataAddNewTemplateModelRoot)
}

class ReceivedDataAddNewTemplateTVController: UITableViewController {
    public weak var delegate: DeviceCoordinatorMain?
    public var device: DeviceModel?
    public var templateAdd: [ReceivedDataAddNewTemplateModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        navigationItem.title = "Новые показания"
        super.viewDidLoad()
        configuration()
    }
    // Предыдущие показания
    let previousReceivedDataCellDorO: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.person, textAlign: .left, accessoryType: .none) }()
    let previousReceivedDataCellN: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.person, textAlign: .left, accessoryType: .none) }()
    // Дата показания
    var ReceivedDataDateCellDorO: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.mail, textAlign: .left, accessoryType: .none) }()
    var ReceivedDataDateCellN: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.mail, textAlign: .left, accessoryType: .none) }()
    // Ввод показаний
    var ReceivedDataCellDorO: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.phone, textAlign: .left, accessoryType: .none) }()
    var ReceivedDataCellN: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.lock, textAlign: .left, accessoryType: .none) }()
    // Примерноный расчет
    var calcCellDorO: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.lock, textAlign: .left, accessoryType: .none) }()
    var calcCellN: UITableViewCell { getCustomCell(textLabel: "Зарегистрировать", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    
    var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите ваше имя"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "example@email.com"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    var mobileTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "+7(909)-012-34-56"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Придумайте пароль"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Повторите пароль"
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
    
    func setUpLayout(){
        previousReceivedDataCellDorO.addSubview(nameTextField)
        nameTextField.leadingAnchor.constraint(equalTo: previousReceivedDataCellDorO.leadingAnchor, constant: 50).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: previousReceivedDataCellDorO.centerYAnchor).isActive = true
        // контакты
        ReceivedDataDateCellDorO.addSubview(emailTextField)
        emailTextField.leadingAnchor.constraint(equalTo: ReceivedDataDateCellDorO.leadingAnchor, constant: 50).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: ReceivedDataDateCellDorO.centerYAnchor).isActive = true
        ReceivedDataCellDorO.addSubview(mobileTextField)
        mobileTextField.leadingAnchor.constraint(equalTo: ReceivedDataCellDorO.leadingAnchor, constant: 50).isActive = true
        mobileTextField.centerYAnchor.constraint(equalTo: ReceivedDataCellDorO.centerYAnchor).isActive = true
        // Пароль
        ReceivedDataCellN.addSubview(passwordTextField)
        passwordTextField.leadingAnchor.constraint(equalTo: ReceivedDataCellN.leadingAnchor, constant: 50).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: ReceivedDataCellN.centerYAnchor).isActive = true
        calcCellDorO.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.leadingAnchor.constraint(equalTo: calcCellDorO.leadingAnchor, constant: 50).isActive = true
        confirmPasswordTextField.centerYAnchor.constraint(equalTo: calcCellDorO.centerYAnchor).isActive = true
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return templateAdd.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 4
        case 1:
            return 2
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
                return previousReceivedDataCellDorO
            case 1:
                return ReceivedDataDateCellDorO
            case 2:
                return previousReceivedDataCellDorO
            case 3:
                return previousReceivedDataCellDorO
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return ReceivedDataDateCellDorO
            case 1:
                return ReceivedDataCellDorO
            default:
                fatalError()
            }
        case 2:
            switch indexPath.row {
            case 0:
                return calcCellN
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return templateAdd[section].tariffZone
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func refreshReceivedData(){
        //ApiServiceAdapter.shared.getReceivedDataAddNewTemplatesByDeviceId(id: device!.id, delegate: self)
        self.refreshControl?.endRefreshing()
    }
    
}
extension ReceivedDataAddNewTemplateTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        self.hideKeyboardWhenTappedAround()
        
        // кнопка сохранить
        let saveBtn = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [saveBtn]
        // кнопка отмена
        let cancelBtn = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButton))
        self.navigationItem.leftBarButtonItems = [cancelBtn]
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshReceivedData), for: UIControl.Event.valueChanged)
        
        refreshReceivedData()
        
    }
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ReceivedDataAddNewTemplateTVController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ReceivedDataAddNewTemplateTVController: ReceivedDataAddNewTemplateTVControllerDelegate {
    func setData(model: ReceivedDataAddNewTemplateModelRoot) {
        templateAdd = model.data
    }   
}
