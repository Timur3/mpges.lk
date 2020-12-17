//
//  CalculationsTVController.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import PDFKit

protocol InvoicesTableViewControllerDelegate: class {
    func navigantionInvoiceDetailsInfoPage(model: InvoiceModel)
    func pdfView(for urlToPdfFile: URL, delegate: InvoicesTableViewControllerUserDelegate)
    func sendDocByEmail(model: SendInvoiceModel, delegate: InvoicesTableViewControllerUserDelegate)
}

protocol InvoicesTableViewControllerUserDelegate: class {
    var sections: [String] { get }
    func setInvoices(invoices: ResultModel<[InvoiceModel]>)
    func responseSend(result: ResultModel<String>)
    func hiddenAI()
}

class InvoicesTableViewController: CommonTableViewController {
    
    public var contractId: Int = 0
    public weak var delegate: InvoicesTableViewControllerDelegate?
    
    var invoiceList = [InvoiceModelVeiw]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        ActivityIndicatorViewService.shared.showView(form: (self.navigationController?.view)!)
        navigationItem.title = "Начисления"
        super.viewDidLoad()
        configuration()
    }
    
    @objc func refreshInvoicesData(sender: AnyObject) {
        print("refresh")
        do {
            try ApiServiceWrapper.shared.getInvoicesByContractId(id: contractId, delegate: self)
        } catch {
            AlertControllerAdapter.shared.show(
                title: "Ошибка!",
                mesg: "Неизвестная ошибка, напишите в тех. поддержку",
                form: self) { (UIAlertAction) in
                    self.cancelButton()
            }
        }
        self.refreshControl?.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return invoiceList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let count = invoiceList[section].invoices.count
        let sum = invoiceList[section].invoices.map({$0.debet}).reduce(0, +)
        let msg = "Всего записей: \(count) на сумму \(formatRusCurrency(sum))"
        return "\(invoiceList[section].year) год\n\(msg)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return invoiceList[section].invoices.count
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexPath = indexPath
        ActivityIndicatorViewService.shared.showView(form: (self.navigationController?.view)!)
        //ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: indexPath)!)
        let id = "\(self.invoiceList[indexPath.section].invoices[indexPath.row].id)"
        self.showPdf(for: "http://lk.mp-ges.ru/Bills/BillsPrintPdfForCash?InvoiceId=" + id)
    }
    
    func showPdf(for urlFileInet: String) {
        DispatchQueue.main.async {
            let urlFile = downloadPdf(url: urlFileInet)
            self.delegate?.pdfView(for: urlFile, delegate: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
extension InvoicesTableViewController: InvoiceCellDelegate {
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
extension InvoicesTableViewController: InvoicesTableViewControllerUserDelegate {
    func responseSend(result: ResultModel<String>) {
        ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        let isError = result.isError
        AlertControllerAdapter.shared.show(
            title: isError ? "Ошибка!" : "Успешно!",
            mesg: result.message!,
            form: self) { (UIAlertAction) in
                if !isError {
                    self.cancelButton()
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
        ActivityIndicatorViewService.shared.hideView()
    }
}

extension InvoicesTableViewController {
    func configuration() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshInvoicesData), for: UIControl.Event.valueChanged)
        
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        let nib = UINib(nibName: "InvoiceCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "invoiceCell")
        refreshInvoicesData(sender: self)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension InvoicesTableViewController:  URLSessionDownloadDelegate {
    func downloadPDF1(urlFile: String, completion: @escaping() -> Void){
        guard let url = URL(string: urlFile) else { return }
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
        completion()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
        // create destination URL with the original pdf name
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        // copy from temp to Document
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            //self.urlToPdf = destinationURL
            print("location:", destinationURL)
            //print("location:", self.urlToPdf!)
        } catch let error {
            print("Copy Error: \(error.localizedDescription)")
        }
    }
}
