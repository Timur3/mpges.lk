//
//  ReceivedDataAddNewTemplateTVControllerOneStep.swift
//  mpges.lk
//
//  Created by Timur on 26.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ReceivedDataAddNewTemplateTVController: UITableViewController {
    public weak var delegate: DeviceCoordinatorMain?
    public var device: DeviceModel?
    let datePicker = UIDatePicker()
    
    var sections: [String] {["Тарифная зона", "Предыдущие показания", "Текущие показания", "Примерный расчет, с учетом всех тарифных зон", ""]}
    var tariffZoneCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.calendar, textAlign: .left, accessoryType: .none) }()
    var receivedDataDateCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.calendar, textAlign: .left, accessoryType: .none) }()
    var previousReceivedDataCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.docText, textAlign: .left, accessoryType: .none) }()
    var deviceRazryadCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.calendar, textAlign: .left, accessoryType: .none) }()
    var tariffValueCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.docText, textAlign: .left, accessoryType: .none) }()
    
    var receivedDataCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.docText, textAlign: .left, accessoryType: .none) }()
    
    var calcCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.docText, textAlign: .left, accessoryType: .none) }()
    var saveCell: UITableViewCell { getCustomCell(textLabel: "Продолжить", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    
    var receivedDataTF: UITextField = { getCustomTextField(placeholder: "Введите показания") }()
    
    override func viewDidLoad() {
        self.navigationItem.title = "Новые показания"
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Получение списка договоров
        //delegate?.getContracts()
    }
    
    func setUpLayout(){
        receivedDataCell.addSubview(receivedDataTF)
        receivedDataTF.leadingAnchor.constraint(equalTo: receivedDataCell.leadingAnchor, constant: 50).isActive = true
        receivedDataTF.centerYAnchor.constraint(equalTo: receivedDataCell.centerYAnchor).isActive = true
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
            return 2
        case 2:
            return 1
        case 3:
            return 1
        case 4:
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
                return tariffZoneCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return receivedDataDateCell
            case 1:
                return previousReceivedDataCell
            default:
                fatalError()
            }
        case 2:
            switch indexPath.row {
            case 0:
                return receivedDataCell
            default:
                fatalError()
            }
        case 3:
            switch indexPath.row {
            case 0:
                return calcCell
            default:
                fatalError()
            }
        case 4:
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
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 2 && indexPath.row == 0 {
            receivedDataTF.becomeFirstResponder()
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            
        }
    }
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ReceivedDataAddNewTemplateTVController{
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
extension ReceivedDataAddNewTemplateTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        
        let cancelBtn = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
        
        self.hideKeyboardWhenTappedAround()
    }
}
