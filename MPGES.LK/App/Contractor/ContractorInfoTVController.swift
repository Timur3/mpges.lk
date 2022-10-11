//
//  ContractorInfoTVController.swift
//  mpges.lk
//
//  Created by Timur on 04.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ContractorInfoTVController: CommonTableViewController {
    
    var sections: [String] {["Основные данные", "Паспортные данные", "Прочее"]}
    
    var nameCell: UITableViewCell = { getCustomCell(textLabel: "Имя:", imageCell: myImage.person, textAlign: .left, accessoryType: .none) }()
    var familyCell: UITableViewCell = { getCustomCell(textLabel: "Фамилия:", imageCell: myImage.person, textAlign: .left, accessoryType: .none) }()
    var middleNameCell: UITableViewCell = { getCustomCell(textLabel: "Отчество:", imageCell: myImage.person, textAlign: .left, accessoryType: .none) }()
    var emailCell: UITableViewCell = { getCustomCell(textLabel: "Email:", imageCell: myImage.paperplane, textAlign: .left, accessoryType: .none) }()
    var dateOfBirthCell: UITableViewCell = { getCustomCell(textLabel: "Дата рождения:", imageCell: myImage.calendar, textAlign: .left, accessoryType: .none) }()
    var passportSeriaAndNumberCell: UITableViewCell = { getCustomCell(textLabel: "Серия/Номер:", imageCell: myImage.docText, textAlign: .left, accessoryType: .none) }()
    var kemVydanCell: UITableViewCell = { getCustomCell(textLabel: "Выдан:", imageCell: myImage.docText, textAlign: .left, accessoryType: .none) }()
    var typeOfContractorCell: UITableViewCell = { getCustomCell(textLabel: "Тип:", imageCell: myImage.person, textAlign: .left, accessoryType: .none) }()
    
    var contractor: ContractorModel? {
        didSet {
            
            self.nameLabel.text = self.contractor!.name
            self.familyLabel.text = self.contractor!.family.prefix(1) + "."
            self.middleNameLabel.text = self.contractor!.middleName!.prefix(1) + "."
            self.dateOfBirthLabel.text = self.contractor!.dateOfBirth
            self.passportLabel.text = self.contractor!.passportSeria + "/******"
            self.kemVydanLabel.text = "****************"
            self.typeOfContractorCell.textLabel!.text = self.contractor?.typeOfContractor.name
            self.tableView.reloadData()
        }
    }
    
    var nameLabel: UILabel = { getCustomLabel(text: "...") }()
    var familyLabel: UILabel = { getCustomLabel(text: "...") }()
    var middleNameLabel: UILabel = { getCustomLabel(text: "...") }()
    var dateOfBirthLabel: UILabel = { getCustomLabel(text: "...") }()
    var passportLabel: UILabel = { getCustomLabel(text: "...") }()
    var kemVydanLabel: UILabel = { getCustomLabel(text: "...") }()
    
    override func viewDidLoad() {
        self.navigationItem.title = "Информация"
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    
    func setUpLayout(){
        nameCell.addSubview(nameLabel)
        nameLabel.rightAnchor.constraint(equalTo: nameCell.rightAnchor, constant: -50).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: nameCell.centerYAnchor).isActive = true
        familyCell.addSubview(familyLabel)
        familyLabel.rightAnchor.constraint(equalTo: familyCell.rightAnchor, constant: -50).isActive = true
        familyLabel.centerYAnchor.constraint(equalTo: familyCell.centerYAnchor).isActive = true
        middleNameCell.addSubview(middleNameLabel)
        middleNameLabel.rightAnchor.constraint(equalTo: middleNameCell.rightAnchor, constant: -50).isActive = true
        middleNameLabel.centerYAnchor.constraint(equalTo: middleNameCell.centerYAnchor).isActive = true
        dateOfBirthCell.addSubview(dateOfBirthLabel)
        dateOfBirthLabel.rightAnchor.constraint(equalTo: dateOfBirthCell.rightAnchor, constant: -50).isActive = true
        dateOfBirthLabel.centerYAnchor.constraint(equalTo: dateOfBirthCell.centerYAnchor).isActive = true
        passportSeriaAndNumberCell.addSubview(passportLabel)
        passportLabel.rightAnchor.constraint(equalTo: passportSeriaAndNumberCell.rightAnchor, constant: -50).isActive = true
        passportLabel.centerYAnchor.constraint(equalTo: passportSeriaAndNumberCell.centerYAnchor).isActive = true
        kemVydanCell.addSubview(kemVydanLabel)
        kemVydanLabel.rightAnchor.constraint(equalTo: kemVydanCell.rightAnchor, constant: -50).isActive = true
        kemVydanLabel.centerYAnchor.constraint(equalTo: kemVydanCell.centerYAnchor).isActive = true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return section == 0 ? "Если указана дата рождения 01.01.1900, это означает что у Вас не заполнены данные, будем очень благодарны за информацию" : ""
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
                return nameCell
            case 1:
                return familyCell
            case 2:
                return middleNameCell
            case 3:
                return dateOfBirthCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return passportSeriaAndNumberCell
            case 1:
                return kemVydanCell
            default:
                fatalError()
            }
        case 2:
            switch indexPath.row {
            case 0:
                return typeOfContractorCell
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
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func refreshData() {
        
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
}
