//
//  PayWithSberbankOnlineTVController.swift
//  mpges.lk
//
//  Created by Timur on 08.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
protocol PayWithSberbankOnlineTVControllerDelegate: AnyObject {
    func getDeepLink()
    func navigationToSberApp(response: ResultModel<String>)
}

class PayWithSberbankOnlineTVController: CenterContentAndCommonTableViewController {
    public weak var delegate: ContractDetailsInfoCoordinator?
    
    var sections: [String] {["", "Лицевой счет", "Доставка электронного чека", ""]}
    
    var logoCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.none, textAlign: .left, accessoryType: .none) }()
    
    var accountCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.tag, textAlign: .left, accessoryType: .none) }()
    var summaCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.rub, textAlign: .left, accessoryType: .none) }()
    var saveCell: UITableViewCell { getCustomCell(textLabel: "Подтвердить платеж", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    var contactCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.mail, textAlign: .left, accessoryType: .none) }()
    
    var accountTextField: UITextField = { getCustomTextField(placeholder: "") }()
    var contactTextField: UITextField = { getCustomTextField(placeholder: "") }()
    
    var logoImgView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: myImage.sberIcon.rawValue)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var model: BankPayModel? {
        didSet {
            DispatchQueue.main.async {
                self.contactTextField.text = self.model?.emailOrMobile
                self.accountTextField.text = self.model?.contractNumber
            }
        }
    }
    override func viewDidLoad() {
        self.navigationItem.title = "Оплата Сбербанк онлайн"
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0 && indexPath.row == 0) ? CGFloat(100) : UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.section == 0 && indexPath.row == 0) {
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = false
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
                return logoCell
            default:
                fatalError()
            }
        
        case 1:
            switch indexPath.row {
            case 0:
                return accountCell
            default:
                fatalError()
            }
        case 2:
            switch indexPath.row {
            case 0:
                return contactCell
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
        
        if indexPath.section == 1 && indexPath.row == 0 {
            contactTextField.becomeFirstResponder()
        }
        if indexPath.section == 3 && indexPath.row == 0 {
            self.getDeepLink()
        }
    }
}

extension PayWithSberbankOnlineTVController: PayWithSberbankOnlineTVControllerDelegate {
    func getDeepLink() {
        ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        ApiServiceWrapper.shared.getDeepLinkForIos(number: Int(model!.contractNumber)!, delegate: self)
    }
    
    func navigationToSberApp(response: ResultModel<String>) {
        let isError = response.isError
        if isError {
            self.showAlert(
                title: isError ? "Ошибка!" : "Успешно!",
                mesg: response.message!) { (UIAlertAction) in
                    if isError {
                        self.cancelButton()
                    }
            }
        } else {
            debugPrint(response.data!)
            let url = URL(string: response.data!)
            UIApplication.shared.open(url!) { (result) in
                if result {
                    self.cancelButton()
                }
            }
        }
        
        self.hiddenAI()
    }
}

//MARK: - CONFIGURE
extension PayWithSberbankOnlineTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
        self.hideKeyboardWhenTappedAround()
    }
    
    func setUpLayout(){
        
        accountCell.addSubview(accountTextField)
        accountTextField.leadingAnchor.constraint(equalTo: accountCell.leadingAnchor, constant: 50).isActive = true
        accountTextField.centerYAnchor.constraint(equalTo: accountCell.centerYAnchor).isActive = true
        
        contactCell.addSubview(contactTextField)
        contactTextField.leadingAnchor.constraint(equalTo: contactCell.leadingAnchor, constant: 50).isActive = true
        contactTextField.centerYAnchor.constraint(equalTo: contactCell.centerYAnchor).isActive = true
        
        logoCell.addSubview(logoImgView)
        logoImgView.leadingAnchor.constraint(equalTo: logoCell.leadingAnchor, constant: 5).isActive = true
        logoImgView.rightAnchor.constraint(equalTo: logoCell.rightAnchor, constant: 5).isActive = true
        logoImgView.topAnchor.constraint(equalTo: logoCell.topAnchor, constant: 5).isActive = true
        logoImgView.centerYAnchor.constraint(equalTo: logoCell.centerYAnchor).isActive = true
    }
}
