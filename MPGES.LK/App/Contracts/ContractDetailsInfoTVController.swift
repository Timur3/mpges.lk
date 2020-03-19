//
//  ContractDetailsInfoTVC.swift
//  mpges.lk
//
//  Created by Timur on 28.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
protocol ContractDetailsInfoTVControllerDelegate: class {
    func navigateToBackPage()
    func navigateToPaymentsPage()
    func navigationDevicesPage()
}

class ContractDetailsInfoTVController: UITableViewController {
    public weak var delegate: ContractDetailsInfoTVControllerDelegate?
    
    var contractNumber: UITableViewCell { getCustomCell(textLabel: "Лицевой счет №: 86000300003", imageCell: myImage.tag, textAlign: .left, accessoryType: .none) }
    var contractDate: UITableViewCell { getCustomCell(textLabel: "Дата договора: 12.02.2020", imageCell: myImage.calendar, textAlign: .left, accessoryType: .none) }
    var contractor: UITableViewCell { getCustomCell(textLabel: "Контрагент: Чалимов Т.Т.", imageCell: myImage.person, textAlign: .left, accessoryType: .none) }
    var contractSaldo: UITableViewCell { getCustomCell(textLabel: "Баланс: 800,00 руб.", imageCell: myImage.rub, textAlign: .left, accessoryType: .none) }
    var makeAPayment: UITableViewCell { getCustomCell(textLabel: "Пополнить счет", textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    var paymentsOfContract: UITableViewCell { getCustomCell(textLabel: "История платежей", imageCell: myImage.rub, textAlign: .left, accessoryType: .disclosureIndicator) }
    var calculationsOfContract: UITableViewCell { getCustomCell(textLabel: "История начислений", imageCell: myImage.calc, textAlign: .left, accessoryType: .disclosureIndicator) }
    var devicesOfContract: UITableViewCell { getCustomCell(textLabel: "Приборы учета", imageCell: myImage.link, textAlign: .left, accessoryType: .disclosureIndicator) }
    var mailOfContract: UITableViewCell { getCustomCell(textLabel: "Доставка квитанций", imageCell: myImage.mail, textAlign: .left, accessoryType: .disclosureIndicator)}
    
    override func viewDidLoad() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        navigationItem.title = "Лицевой счет"
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 && indexPath.row == 0 {
//        return 150
//        }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 4
        case 1:
            return 1
        case 2:
            return 3
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
                return contractNumber
            case 1:
                return contractDate
            case 2:
                return contractor
            case 3:
                return contractSaldo
            case 4:
                return makeAPayment
            default:
                fatalError()
            }
        case 1:
        switch indexPath.row {
        case 0:
            return makeAPayment
        default:
            fatalError()
        }
        case 2:
            switch indexPath.row {
            case 0:
                return calculationsOfContract
            case 1:
                return paymentsOfContract
            case 2:
                return devicesOfContract
            default:
                fatalError()
            }
        case 3:
            switch indexPath.row {
            case 0:
                return mailOfContract
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 1 {

            
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            AlertControllerHelper.shared.show(title: "Внимание!", mesg: "Фукнционал оплаты временно приостановлен.", form: self)
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            let dataSend = 1 //contractList[indexPath.row]
            performSegue(withIdentifier: "goToCalculations", sender: dataSend)
        }
        
        if indexPath.section == 2 && indexPath.row == 1 {
            // go to payments page
            self.delegate?.navigateToPaymentsPage()
        }
        
        if indexPath.section == 2 && indexPath.row == 2 {
            self.delegate?.navigationDevicesPage()
        }
    }

     //MARK: - Navigation

}

extension ContractDetailsInfoTVController: ContractDetailsInfoTVControllerUserDelegate {
    var sections: [String] { ["Основная информация", "Оплата",  "История платежей, начислений и приборы учета", "Доставка квитанций"] }
    
    func setContractById(contract: ContractModel) {
       
    }
}
