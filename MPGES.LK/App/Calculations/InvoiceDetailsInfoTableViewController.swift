//
//  InvoiceDetailsInfoTableViewController.swift
//  mpges.lk
//
//  Created by Timur on 20.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

protocol InvoiceDetailsInfoTableViewControllerDelegate: class {
    var sections: [String] { get }
    func setPayments(payments: ResultModel<[PaymentModel]>)
    func setCalculations(calculations: ResultModel<[CalculationModel]>)
    func sendInvoice(model: InvoiceModel)
    func resultOfSendInvoice(result: ResultModel<String>)
}

class InvoiceDetailsInfoTableViewController: CommonTableViewController {
    var balanceBeginOfPeriod: UITableViewCell { getCustomCell(textLabel: (invoice?.statusSaldo.name ?? "...") + " \(invoice?.saldo ?? 0) руб.", imageCell: myImage.dollar, textAlign: .left, accessoryType: .none) }
    var balanceEndOfPeriod: UITableViewCell { getCustomCell(textLabel: (invoice?.statusSaldo.name ?? "...") + " \(invoice?.saldo ?? 0) руб.", imageCell: myImage.dollar, textAlign: .left, accessoryType: .none) }
    var notCalculations: UITableViewCell { getCustomCell(textLabel: "не производились", imageCell: myImage.textPlus, textAlign: .left, accessoryType: .none) }
    var notPays: UITableViewCell { getCustomCell(textLabel: "не совершались", imageCell: myImage.textPlus, textAlign: .left, accessoryType: .none) }
    
    public var invoice: InvoiceModel?
    
    override func viewDidLoad() {
        self.navigationItem.title = "Детали";
        refreshData()
        super.viewDidLoad()
        configuration()
    }
    var invoiceDetails: InvoiceDetailsModelView = InvoiceDetailsModelView(calc: [], pay: [])
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            return (self.invoiceDetails.calc.count > 0 ? self.invoiceDetails.calc.count : 1)
        case 2:
            return (self.invoiceDetails.pay.count > 0 ? self.invoiceDetails.pay.count : 1)
        case 3:
            return 1
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return balanceBeginOfPeriod
        case 1:
            if self.invoiceDetails.calc.count > 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "calculationCell", for: indexPath) as! CalculationTVCell
                cell.update(for: self.invoiceDetails.calc[indexPath.row])
                cell.imageView?.image = UIImage(systemName: myImage.textPlus.rawValue)
                return cell
            } else {
                return notCalculations
            }
        case 2:
            if self.invoiceDetails.pay.count > 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! PaymentTVCell
                cell.update(for: self.invoiceDetails.pay[indexPath.row])
                cell.imageView?.image = UIImage(systemName: myImage.rub.rawValue)
                return cell
            } else {
                return notPays
            }
        case 3:
            return balanceEndOfPeriod
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return "Количество записей: " + "\(invoiceDetails.calc.count)" + " на сумму: " + "\(invoiceDetails.calc.map({ $0.summa }).reduce(0, +))"
        case 2:
            return "Количество записей: " + "\(invoiceDetails.pay.count)" + " на сумму: " + "\(invoiceDetails.pay.map({ $0.summa }).reduce(0, +))"
        case 3:
            return ""
        default:
            fatalError()
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @objc func refreshData() {
        ApiServiceWrapper.shared.getPaymentsByInvoiceId(id: invoice!.id, delegate: self)
        self.refreshControl?.endRefreshing()
    }
    @objc func alertSheetSendInvoiceShow(){
        AlertControllerAdapter.shared.actionSheetConfirmShow(title: "Внимание!", mesg: "Вы действительно хотите получить платежный документ на электронную почту?", form: self, handlerYes: { (UIAlertAction) in
            self.sendInvoice(model: self.invoice!)
        })
    }
    
}

extension InvoiceDetailsInfoTableViewController: InvoiceDetailsInfoTableViewControllerDelegate {
    func sendInvoice(model: InvoiceModel) {
        ActivityIndicatorViewService.shared.showView(form: self.navigationController!.view)
        //ApiServiceWrapper.shared.sendInvoiceByEmail(id: model.id, delegate: self)
    }
    
    func resultOfSendInvoice(result: ResultModel<String>) {
        ActivityIndicatorViewService.shared.hideView()
        
        let isError = result.isError
        AlertControllerAdapter.shared.show(
            title: isError ? "Ошибка!" : "Успешно!",
            mesg: result.message!,
            form: self)
    }
    
    func setPayments(payments: ResultModel<[PaymentModel]>) {
        self.invoiceDetails.pay = payments.data!
        ApiServiceWrapper.shared.getCalculationsByInvoiceId(id: invoice!.id, delegate: self)
    }
    
    func setCalculations(calculations:ResultModel<[CalculationModel]>) {
        self.invoiceDetails.calc = calculations.data!
        self.tableView.reloadData()
    }
    
    var sections: [String] {
        ["Сальдо на начало периода", "Начисления", "Платежи", "Сальдо на конец периода"]
    }
}

//MARK: - CONFIGURATION
extension InvoiceDetailsInfoTableViewController {
    
    func configuration() {
        let sendInvoice = UIBarButtonItem(image: UIImage(systemName: myImage.trayUp.rawValue), style: .plain, target: self, action: #selector(alertSheetSendInvoiceShow))
        self.navigationItem.rightBarButtonItems = [sendInvoice]
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        let nibCalc = UINib(nibName: "CalculationTVCell", bundle: nil)
        self.tableView.register(nibCalc, forCellReuseIdentifier: "calculationCell")
        let nibPay = UINib(nibName: "PaymentTVCell", bundle: nil)
        self.tableView.register(nibPay, forCellReuseIdentifier: "paymentCell")
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
    }
    
}
