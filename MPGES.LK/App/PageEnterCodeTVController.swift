//
//  ChangePasswordTVController.swift
//  mpges.lk
//
//  Created by Timur on 20.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

protocol PageEnterCodeTVControllerDelegate: AnyObject {
    func responseAfterSendingCode(result: ResultModel<String>)
    func responseOfDeleteUser(result: ResultModel<String>)
}

class PageEnterCodeTVController: CommonTableViewController {
    
    var sections: [String] {["Email", "Код подтверждения", ""]}
    public var email: String?
    public weak var delegateProfile: ProfileCoordinator?
    
    // ФИО
    let currentEmailCell: UITableViewCell = { getCustomCell(textLabel: "",
                                                            imageCell: AppImage.at,
                                                            textAlign: .left, accessoryType: .none) }()
    var emailLabel: UILabel = { getCustomLabel(text: "_" ) }()
    // Код
    var codeCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.lock, textAlign: .left, accessoryType: .none) }()
    var getCodeCell: UITableViewCell = { getCustomCell(textLabel: "Запросить код", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }()
    var codeTextField: UITextField = { getCustomTextField(placeholder: "XXXXXX", isPassword: false) }()
    
    // Кнопка
    var saveCell: UITableViewCell = { getCustomCell(textLabel: "Удалить", imageCell: .none, textAlign: .center, textColor: .systemRed, accessoryType: .none, isUserInteractionEnabled: true, selectionStyle: .blue) }()
    
    private lazy var getCodeButton: UIButton = {
        var b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("   Запросить   ", for: .normal)
        b.titleLabel?.textColor = .black
        b.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        b.backgroundColor = .systemBlue
        b.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        b.layer.cornerRadius = 8.0
        b.layer.borderWidth = 1.0
        b.layer.borderColor = UIColor.systemBlue.cgColor
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        setUpLayout()
        emailLabel.text = email
    }
    
    @objc func tapButton() {
        buttonDisabled()
        let model = EmailModel(email: emailLabel.text ?? "")
        ApiServiceWrapper.shared.getCodeForDeleteUser(model: model, delegate: self)
        print(#function)
    }
    
    func setUpLayout(){
        let inset: CGFloat = 50
        currentEmailCell.contentView.addSubview(emailLabel)
        emailLabel.leftAnchor.constraint(equalTo: currentEmailCell.leftAnchor, constant: inset).isActive = true
        emailLabel.centerYAnchor.constraint(equalTo: currentEmailCell.centerYAnchor).isActive = true
        // Пароль
        codeCell.addSubview(codeTextField)
        codeTextField.leadingAnchor.constraint(equalTo: codeCell.leadingAnchor, constant: inset).isActive = true
        codeTextField.centerYAnchor.constraint(equalTo: codeCell.centerYAnchor).isActive = true
        codeCell.addSubview(getCodeButton)
        getCodeButton.centerYAnchor.constraint(equalTo: codeCell.centerYAnchor).isActive = true
        getCodeButton.trailingAnchor.constraint(equalTo: codeCell.trailingAnchor, constant: -25).isActive = true
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0, 1, 2:
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
                return currentEmailCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return codeCell
            default:
                fatalError()
            }
        case 2:
            switch indexPath.row {
            case 0:
                return saveCell
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return section == 1 ? "Выслать код повторно можно через 30 сек." : ""
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexPath = indexPath
        if indexPath.section == 1 && indexPath.row == 0 {
            codeTextField.becomeFirstResponder()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            print(#function)
            guard let code = codeTextField.text else { return }
            if code.count > 0 {
                ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
                userDelete()
            } else {
                self.showAlert(title: "Ошибка", mesg: "Введите код подтверждения") { _ in
                    self.hiddenAI()
                }
            }
        }
    }
    
    func userDelete() {
        guard let email = email?.lowercased() else { return }
        let model = OtpVerificationModel(email: email, code: codeTextField.text ?? "")
        ApiServiceWrapper.shared.userDelete(model: model, delegate: self)
    }
    
    private func buttonEnabled() {
        getCodeButton.isEnabled = true
        getCodeButton.alpha = 1.0
    }
    
    private func buttonDisabled() {
        getCodeButton.isEnabled = false
        getCodeButton.alpha = 0.5
    }
}


//MARK: - CONFIGURE
extension PageEnterCodeTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        self.hideKeyboardWhenTappedAround()
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
    }
}

extension PageEnterCodeTVController: PageEnterCodeTVControllerDelegate {
    func responseAfterSendingCode(result: ResultModel<String>) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) { [weak self] in
            self?.buttonEnabled()
        }
        
        if !result.isError {
            showToast(message: "Успешно")
        } else {
            self.showAlert(
                title: "Ошибка",
                mesg: result.message!)
        }
    }
    
    func responseOfDeleteUser(result: ResultModel<String>) {
        ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        let isError = result.isError
        
        self.showAlert(
            title: isError ? "Ошибка" : "Успешно",
            mesg: result.message!) { (UIAlertAction) in
                if !isError {
                    self.cancelButton()
                    self.delegateProfile?.navigateToFirstPage()
                }
            }
    }
}
