//
//  EmailToDeveloperTVController.swift
//  mpges.lk
//
//  Created by Timur on 02.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

protocol EmailToDeveloperTVControllerDelegate1: AnyObject {
    func sendMail(model: ContractBindingModel)
    func resultSendMail(result: ResultModel<String>)
}

class EmailToDeveloperTVController1: CommonTableViewController {
    var sections: [String] {["Тема письма", "Email для связи", "Содержание", ""]}
    
    public weak var delegate: ProfileCoordinator?
    
    let subjectCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.docText, textAlign: .left, accessoryType: .none) }()
    var emailCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.person, textAlign: .left, accessoryType: .none) }()
    var bodyMailCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.textPlus, textAlign: .left, accessoryType: .none) }()
    var saveCell: UITableViewCell { getCustomCell(textLabel: "Направить", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    
    var subjectMailTextField: UITextField = { getCustomTextField(placeholder: "Заголовок") }()
    var emailTextField: UITextField = { getCustomTextField(placeholder: "example@mail.com") }()
    
    var bodyMailTextView: UITextView = {
    let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.layer.masksToBounds = true
        textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
    }()
    
    override func viewDidLoad() {
        self.navigationItem.title = "Новое письмо"
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    @objc func refreshData()
    {
        
    }
    
    func setUpLayout(){
        subjectCell.addSubview(subjectMailTextField)
        subjectMailTextField.leadingAnchor.constraint(equalTo: subjectCell.leadingAnchor, constant: 50).isActive = true
        subjectMailTextField.centerYAnchor.constraint(equalTo: subjectCell.centerYAnchor).isActive = true
        // account
        emailCell.addSubview(emailTextField)
        emailTextField.leadingAnchor.constraint(equalTo: emailCell.leadingAnchor, constant: 50).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: emailCell.centerYAnchor).isActive = true
        bodyMailCell.addSubview(bodyMailTextView)
        bodyMailTextView.leadingAnchor.constraint(equalTo: bodyMailCell.leadingAnchor, constant: 50).isActive = true
        bodyMailTextView.trailingAnchor.constraint(equalTo: bodyMailCell.trailingAnchor, constant: -1).isActive = true
        bodyMailTextView.topAnchor.constraint(equalTo: bodyMailCell.topAnchor, constant: 1).isActive = true
        bodyMailTextView.bottomAnchor.constraint(equalTo: bodyMailCell.bottomAnchor, constant: -1).isActive = true
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 2 && indexPath.row == 0) ? CGFloat(210) : UITableView.automaticDimension
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
        case 3:
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
                return subjectCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return emailCell
            default:
                fatalError()
            }
        case 2:
            switch indexPath.row {
            case 0:
                return bodyMailCell
            default:
                fatalError()
            }
        case 3:
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
        sections[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexPath = indexPath
        
        if indexPath.section == 0 && indexPath.row == 0 {
            subjectMailTextField.becomeFirstResponder()
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            emailTextField.becomeFirstResponder()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            bodyMailTextView.becomeFirstResponder()
        }
        if indexPath.section == 3 && indexPath.row == 0 {
            alertSheetSendMailShow()
        }
    }
    
    func alertSheetSendMailShow() {
        self.showActionSheetConfirm(title: "Внимание!", message: "Вы действительно хотите направить обращение?", handlerYes: { (UIAlertAction) in
            ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
            print("send mail")
            //sendMail()
        })
    }
}

//MARK: - CONFIGURE
extension EmailToDeveloperTVController1 {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        self.hideKeyboardWhenTappedAround()
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
    }
}

extension EmailToDeveloperTVController1: EmailToDeveloperTVControllerDelegate1 {
    func sendMail(model: ContractBindingModel) {
        
    }
    
    func resultSendMail(result: ResultModel<String>) {
        
    }
    
    
}
