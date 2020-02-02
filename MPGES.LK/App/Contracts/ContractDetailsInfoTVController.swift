//
//  ContractDetailsInfoTVC.swift
//  mpges.lk
//
//  Created by Timur on 28.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ContractDetailsInfoTVController: UITableViewController {
    //var model: ContractModel
    var contractInfo: UITableViewCell { getCustomCell(textLabel: "Лицевой счет №", textAlign: .center, accessoryType: .none) }
    var makeAPayment: UITableViewCell { getCustomCell(textLabel: "Пополнить счет", textAlign: .center, accessoryType: .none) }
    var paymentsOfContract: UITableViewCell { getCustomCell(textLabel: "История платежей", textAlign: .left, accessoryType: .disclosureIndicator) }
    var calculationsOfContract: UITableViewCell { getCustomCell(textLabel: "История начислений", textAlign: .left, accessoryType: .disclosureIndicator) }
    var devicesOfContract: UITableViewCell { getCustomCell(textLabel: "Приборы учета", textAlign: .left, accessoryType: .disclosureIndicator) }
    var mailOfContract: UITableViewCell { getCustomCell(textLabel: "Доставка квитанций", textAlign: .left, accessoryType: .disclosureIndicator)}
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 150
        }
        return 44
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 2
        case 1:
            return 3
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
                return contractInfo
            case 1:
                return makeAPayment
            default:
                fatalError()
            }
        case 1:
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
        case 2:
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
        switch section {
        case 0:
            return "Основная информация"
        case 1:
            return "История платежей, начислений и приборы учета"
        case 2:
            return "Доставка квитанций"
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 && indexPath.row == 0 {
            let dataSend = 1 //contractList[indexPath.row]
            performSegue(withIdentifier: "goToCalculations", sender: dataSend)
        }
        
        if indexPath.section == 1 && indexPath.row == 1 {
            let dataSend = 1 //contractList[indexPath.row]
            performSegue(withIdentifier: "goToPayments", sender: dataSend)
        }
        
        if indexPath.section == 1 && indexPath.row == 2 {
            let dataSend = 1 //contractList[indexPath.row]
            performSegue(withIdentifier: "goToDevices", sender: dataSend)
        }
    }

     //MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPayments", let paymentData = segue.destination as? PaymentsTVController {
            //paymentData. = sender as? DeviceModel
        }
    }

}

extension ContractDetailsInfoTVController: ContractDetailsInfoTVControllerDelagate {
    func setContractById(contract: ContractModel) {
       
    }
    
    
    func getCustomCell(textLabel: String, textAlign: NSTextAlignment, accessoryType: UITableViewCell.AccessoryType) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = textLabel
        cell.textLabel?.textAlignment = textAlign
        cell.accessoryType = accessoryType
        return cell
    }
    
    
}
