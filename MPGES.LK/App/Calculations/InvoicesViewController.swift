//
//  InvoicesViewController.swift
//  mpges.lk
//
//  Created by Timur on 07.02.2021.
//  Copyright © 2021 ChalimovTimur. All rights reserved.
//

import UIKit

protocol InvoicesViewControllerDelegate: AnyObject {
    func pdfView(for urlToPdfFile: URL, delegate: InvoicesViewControllerUserDelegate)
    func sendDocByEmail(model: SendInvoiceModel, delegate: InvoicesViewControllerUserDelegate)
}

protocol InvoicesViewControllerUserDelegate: AnyObject {
    var sections: [String] { get }
    func setInvoices(invoices: ResultModel<[InvoiceModel]>)
    func responseSend(result: ResultModel<String>)
    func hiddenAI()
}


class InvoicesViewController: CommonViewController {
    private var indexPath: IndexPath?
    
    public lazy var invoiceTableView: UITableView = {
        var table = UITableView.init(frame: .zero, style: .insetGrouped)
        table.register(InvoiceCell.self, forCellReuseIdentifier: InvoiceCell.identifier)
        table.isUserInteractionEnabled = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    public var contractId: Int = 0
    public weak var delegate: InvoicesViewControllerDelegate?
    
    var invoiceList = [InvoiceModelVeiw]() {
        didSet {
            DispatchQueue.main.async {
                self.invoiceTableView.reloadData()
                self.hideLoadingIndicator()
            }
        }
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Начисления"
        super.viewDidLoad()
        configuration()
        setUpLayout()
        getInvoicesData()
    }
    
    func configuration(){
        self.invoiceTableView.refreshControl = UIRefreshControl()
        self.invoiceTableView.refreshControl?.addTarget(self, action: #selector(getInvoicesData), for: UIControl.Event.valueChanged)
    }
    
    @objc func getInvoicesData() {
        self.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            do {
                try ApiServiceWrapper.shared.getInvoicesByContractId(id: self.contractId, delegate: self)
            } catch {
                self.hideLoadingIndicator()
                self.showAlert(
                    title: "Ошибка!",
                    mesg: "Неизвестная ошибка, напишите в тех. поддержку") { (UIAlertAction) in
                        self.cancelAction()
                    }
            }
            self.invoiceTableView.refreshControl?.endRefreshing()
        }
    }
    
    func setUpLayout(){
        view.addSubview(invoiceTableView)
        NSLayoutConstraint.activate([
            invoiceTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            invoiceTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            invoiceTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 0),
            invoiceTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
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
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel){_ in
            self.hiddenAI()
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func showPdf(for id: String) {
        let url = MethodApi.baseUrl + MethodApi.getInvoicePdf + id
        DispatchQueue.main.async {
            let urlFile = downloadPdf(url: url)
            self.delegate?.pdfView(for: urlFile, delegate: self)
        }
    }
}

//MARK: - UITableViewDelegate
extension InvoicesViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return invoiceList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return invoiceList[section].invoices.count
    }
}

//MARK: - UITableViewDataSource
extension InvoicesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let count = invoiceList[section].invoices.count
        let sum = invoiceList[section].invoices.map({$0.debet}).reduce(0, +)
        let msg = "Всего записей: \(count) на сумму \(formatRusCurrency(sum))"
        return "\(invoiceList[section].year) год\n\(msg)"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexPath = indexPath
        ActivityIndicatorViewForCellService.shared.showAI(cell: self.invoiceTableView.cellForRow(at: self.indexPath!)!)
        let id = "\(self.invoiceList[indexPath.section].invoices[indexPath.row].id)"
        self.showPdf(for: id)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InvoiceCell.identifier, for: indexPath) as! InvoiceCell
        cell.indexPath = indexPath
        cell.delegateCell = self
        cell.update(for: invoiceList[indexPath.section].invoices[indexPath.row])
        return cell
    }
}

// MARK: - INVOICE CELL DELEGATE
extension InvoicesViewController: InvoiceCellDelegate {
    func accessoryViewTapping(indexPath: IndexPath) {
        self.indexPath = indexPath
        ActivityIndicatorViewForCellService.shared.showAI(cell: self.invoiceTableView.cellForRow(at: self.indexPath!)!)
        
        let alert = UIAlertController(title: "Выберите действие", message: nil, preferredStyle: .actionSheet)
        let actionOpenInvoice = UIAlertAction(title: "Скачать PDF-файл", style: .default) {
            (UIAlertAction) in
            let id = "\(self.invoiceList[indexPath.section].invoices[indexPath.row].id)"
            self.showPdf(for: "http://lk.mp-ges.ru/Bills/BillsPrintPdfForCash?InvoiceId=" + id)
        }
        let actionSendInvoice = UIAlertAction(title: "Отправить на email", style: .default) {
            (UIAlertAction) in self.alertShowSendByEmail(indexPath: indexPath)
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel) {_ in
            self.hiddenAI()
        }
        alert.addAction(actionOpenInvoice)
        alert.addAction(actionSendInvoice)
        alert.addAction(actionCancel)
        
        if UIDevice.isPad {
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.invoiceTableView
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = [];
            }
        }
        self.present(alert, animated: true, completion: { print("completion block") })
    }
}

extension InvoicesViewController: InvoicesViewControllerUserDelegate {
    
    func hiddenAI() {
        ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.invoiceTableView.cellForRow(at: self.indexPath!)!)
    }
    
    func responseSend(result: ResultModel<String>) {
        ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.invoiceTableView.cellForRow(at: self.indexPath!)!)
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
    }
}
