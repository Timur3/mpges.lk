//
//  InvoicesViewController.swift
//  mpges.lk
//
//  Created by Timur on 07.02.2021.
//  Copyright © 2021 ChalimovTimur. All rights reserved.
//

import UIKit
import SkeletonView

protocol InvoicesViewControllerDelegate: class {
    func pdfView(for urlToPdfFile: URL, delegate: InvoicesViewControllerUserDelegate)
    func sendDocByEmail(model: SendInvoiceModel, delegate: InvoicesViewControllerUserDelegate)
}

protocol InvoicesViewControllerUserDelegate: class {
    var sections: [String] { get }
    func setInvoices(invoices: ResultModel<[InvoiceModel]>)
    func responseSend(result: ResultModel<String>)
    func hiddenAI()
}


class InvoicesViewController: UIViewController, UITableViewDelegate, SkeletonTableViewDataSource {
    let tableView = UITableView.init(frame: .zero, style: .insetGrouped)
    private var indexPath: IndexPath?
    
    public var contractId: Int = 0
    public weak var delegate: InvoicesViewControllerDelegate?
    
    var invoiceList = [InvoiceModelVeiw]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Начисления"
        super.viewDidLoad()
        configuration()
        setUpLayout()
        refreshInvoicesData(sender: self)
    }
    
    func configuration(){
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(refreshInvoicesData), for: UIControl.Event.valueChanged)
        
        let nib = UINib(nibName: "InvoiceCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "invoiceCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.isSkeletonable = true
        self.tableView.showAnimatedSkeleton(usingColor: .lightGray, transition: .crossDissolve(0.25))
    }   
    
    @objc func refreshInvoicesData(sender: AnyObject) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            do {
                try ApiServiceWrapper.shared.getInvoicesByContractId(id: self.contractId, delegate: self)
            } catch {
                self.showAlert(
                    title: "Ошибка!",
                    mesg: "Неизвестная ошибка, напишите в тех. поддержку") { (UIAlertAction) in
                    self.cancelAction()
                }
            }
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func setUpLayout(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return InvoiceCell.identifier
    }
    
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 2
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let monthNumber = Calendar.current.component(.month, from: Date())
        if section == 0 {
            return monthNumber
        } else {
            return 6
        }
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return invoiceList.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let count = invoiceList[section].invoices.count
        let sum = invoiceList[section].invoices.map({$0.debet}).reduce(0, +)
        let msg = "Всего записей: \(count) на сумму \(formatRusCurrency(sum))"
        return "\(invoiceList[section].year) год\n\(msg)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return invoiceList[section].invoices.count
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexPath = indexPath
        ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        let id = "\(self.invoiceList[indexPath.section].invoices[indexPath.row].id)"
        self.showPdf(for: "http://lk.mp-ges.ru/Bills/BillsPrintPdfForCash?InvoiceId=" + id)
    }
    
    func showPdf(for urlFileInet: String) {
        DispatchQueue.main.async {
            let urlFile = downloadPdf(url: urlFileInet)
            self.delegate?.pdfView(for: urlFile, delegate: self)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "invoiceCell", for: indexPath) as! InvoiceCell
        cell.indexPath = indexPath
        cell.delegateCell = self
        cell.update(for: invoiceList[indexPath.section].invoices[indexPath.row])
        return cell
    }
    
    func alertShowSendByEmail(indexPath: IndexPath)
    {
        let alert = UIAlertController(title: "Отправка квитанции", message: "Укажите действующий email адрес, для получения документа", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = UserDataService.shared.getKey(keyName: "email")
            textField.placeholder = "Ваш Email адрес"
        }
        alert.addAction(UIAlertAction(title: "Отправить", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            if isValidEmail((textField?.text)!) {
                let id = self.invoiceList[indexPath.section].invoices[indexPath.row].id
                let model = SendInvoiceModel(email: (textField?.text)!, invoiceId: id)
                self.delegate?.sendDocByEmail(model: model, delegate: self)
            } else { textField?.shake(times: 3, delta: 5)}
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - INVOICE CELL DELEGATE
extension InvoicesViewController: InvoiceCellDelegate {
    func accessoryViewTapping(indexPath: IndexPath) {
        self.indexPath = indexPath
        
        let alert = UIAlertController(title: "Выберите действие", message: nil, preferredStyle: .actionSheet)
        let actionOpenInvoice = UIAlertAction(title: "Скачать PDF-файл", style: .default) {
            (UIAlertAction) in
            let id = "\(self.invoiceList[indexPath.section].invoices[indexPath.row].id)"
            self.showPdf(for: "http://lk.mp-ges.ru/Bills/BillsPrintPdfForCash?InvoiceId=" + id)
        }
        let actionSendInvoice = UIAlertAction(title: "Отправить на email", style: .default) {
            (UIAlertAction) in self.alertShowSendByEmail(indexPath: indexPath)
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(actionOpenInvoice)
        alert.addAction(actionSendInvoice)
        alert.addAction(actionCancel)
        
        if UIDevice.isPad {
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.tableView
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = [];
            }
        }
        self.present(alert, animated: true, completion: { print("completion block") })
    }
}

extension InvoicesViewController: InvoicesViewControllerUserDelegate {
    func hiddenAI() {
        
    }
    
    func responseSend(result: ResultModel<String>) {
        ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        let isError = result.isError
        self.showAlert(
            title: isError ? "Ошибка!" : "Успешно!",
            mesg: result.message!) { (UIAlertAction) in
            if !isError {
                self.cancelAction()
            }
        }
    }
    
    func mapToInvoicesModelView(invoices: [InvoiceModel]) -> [InvoiceModelVeiw] {
        var res = [InvoiceModelVeiw]()
        let models = invoices.groupBy { $0.year}
        for mod in models{
            let invVM = InvoiceModelVeiw(year: mod.key, invoices: mod.value as [InvoiceModel])
            res.append(invVM)
        }
        return res.sorted(by: { $0.year > $1.year })
    }
    
    var sections: [String] { ["Реестр квитанций"] }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search")
    }
    
    func setInvoices(invoices: ResultModel<[InvoiceModel]>) {
        // todo получение данных из realm
        invoiceList = mapToInvoicesModelView(invoices: invoices.data!)
        print("end load invoices")
        self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
    }
}
