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
}

protocol InvoicesTableViewControllerUserDelegate: class {
    var sections: [String] { get }
    func setInvoices(invoices:InvoiceModelRoot)
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
        navigationItem.title = "История начислений"
        super.viewDidLoad()
        configuration()
    }
    
    @objc func refreshInvoicesData(sender: AnyObject){
        print("refresh")
        ApiServiceAdapter.shared.getInvoicesByContractId(id: contractId, delegate: self)
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
        return "\(invoiceList[section].year)" + " год"
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Всего записей: " + String(invoiceList[section].invoices.count)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return invoiceList[section].invoices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "invoiceCell", for: indexPath) as! InvoiceTVCell
        let cell = UITableViewCell()
        let invoice = invoiceList[indexPath.section].invoices[indexPath.row]
        
        cell.textLabel?.text = (invoice.month?.name)! //+ " \(invoice.year)"
        let imgView = UIImageView(image: UIImage(systemName: myImage.dote.rawValue))
        imgView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(alertShowInvoiceAction(tapGestureRecognizer:)))
        //tapGestureRecognizer.setValue(indexPath, forKey: "indexPath")
        imgView.addGestureRecognizer(tapGestureRecognizer)
        
        cell.accessoryView = imgView
        cell.imageView?.image = UIImage(systemName: myImage.textPlus.rawValue)
        //cell.update(for: invoiceList[indexPath.section].invoices[indexPath.row])
        return cell
    }
    
    @objc func alertShowInvoiceAction(tapGestureRecognizer: UITapGestureRecognizer) {
        //self.indexPath = (tapGestureRecognizer.value(forKey: "indexPath") as! IndexPath)
        let alert = UIAlertController(title: "Выберите действие", message: nil, preferredStyle: .actionSheet)
        let actionOpenInvoice = UIAlertAction(title: "Скачать PDF-файл", style: .default) {
            (UIAlertAction) in
             self.showPdf(for: "http://school3-hm.ru/images/Polojeni/03.05.2018/3Polozhenie_ob_obshchem_sobranii_rabotneykov.pdf")
        }
        let actionSendInvoice = UIAlertAction(title: "Отправить по электронной почте", style: .default) {
            (UIAlertAction) in //self.showNewContractPage()
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(actionOpenInvoice)
        alert.addAction(actionSendInvoice)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexPath = indexPath
        //let invoice = invoiceList[indexPath.section].invoices[indexPath.row]
        self.showPdf(for: "http://school3-hm.ru/images/Polojeni/03.05.2018/3Polozhenie_ob_obshchem_sobranii_rabotneykov.pdf")
    }
    
    func showPdf(for urlFileInet: String) {
        ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        let urlFile = downloadPdf(url: urlFileInet)
        self.delegate?.pdfView(for: urlFile, delegate: self)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}

extension InvoicesTableViewController: InvoicesTableViewControllerUserDelegate {
    
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
    
    func setInvoices(invoices: InvoiceModelRoot) {
        // todo получение данных из realm
        invoiceList = mapToInvoicesModelView(invoices: invoices.data)
        ActivityIndicatorViewService.shared.hideView()
    }
}

extension InvoicesTableViewController {
    func configuration() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshInvoicesData), for: UIControl.Event.valueChanged)
        
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        //let nib = UINib(nibName: "InvoiceTVCell", bundle: nil)
        //self.tableView.register(nib, forCellReuseIdentifier: "invoiceCell")
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
