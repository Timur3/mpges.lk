//
//  ReceivedDataTVController.swift
//  mpges.lk
//
//  Created by Timur on 21.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
public protocol ReceivedDataTVControllerDelegate: class {
    func setData(model: ResultModel<[ReceivedDataModel]>)
    func getReceivedDataAddNewTemplatePage()
    func resultOfDelete(result: ResultModel<String>)
}

class ReceivedDataRegisterTVController: CommonTableViewController {
    let searchController = UISearchController(searchResultsController: nil)
    
    public weak var delegate: DeviceCoordinatorMain?
    
    public var device: DeviceModel? {
        didSet {
            refreshReceivedData()
        }
    }
    
    var receivedDataList: [ReceivedDataModelVeiw] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        //ActivityIndicatorViewService.shared.showView(form: self.view)
        super.viewDidLoad()
        configuration()
    }
    
    @objc func refreshReceivedData(){
        ApiServiceWrapper.shared.getReceivedDataByDeviceId(id: device!.id, delegate: self)
        self.refreshControl?.endRefreshing()
    }
    @objc func showMeterDataDevicePage() {
        self.showReceivedDataAddNewTemplateTVPage()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return receivedDataList.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let count = receivedDataList[section].receivedData.count
        let volume = receivedDataList[section].receivedData.map({$0.volume}).reduce(0, +)
        let msg = "Всего записей: \(count)\nобъем потребления: \(volume) кВт/ч"
        return "\(receivedDataList[section].year)" + " год\n\(msg)"
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return receivedDataList[section].receivedData.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.indexPath = indexPath
        if editingStyle == .delete {
            let id = receivedDataList[indexPath.section].receivedData[indexPath.row].id
            ApiServiceWrapper.shared.receivedDataDelete(id: id, delegate: self)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
   /* override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modifyAction = UIContextualAction(style: .normal, title:  "Удалить", handler: { (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in success(true)
              //self.tableView.deleteRows(at: [indexPath], with: .fade)
          })
        modifyAction.image = UIImage(systemName: myImage.delete.rawValue)
        modifyAction.backgroundColor = .purple
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }*/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "receivedDataCell", for: indexPath) as! ReceivedDataTVCell
        cell.imageView?.image = UIImage.init(systemName: myImage.receivedData.rawValue)
        cell.update(for: receivedDataList[indexPath.section].receivedData[indexPath.row])
        return cell
    }
    
    func showReceivedDataAddNewTemplateTVPage() {
        self.delegate?.showReceivedDataAddNewTemplatesOneStepPage(device: device!)
    }
    
    func mapToReceivedDataModelView(receivedData: [ReceivedDataModel]) -> [ReceivedDataModelVeiw] {
        var res = [ReceivedDataModelVeiw]()
        let models = receivedData.groupBy { $0.receivedDataYear() }
        for mod in models{
            let receivedDataVM = ReceivedDataModelVeiw(year: mod.key, receivedData: mod.value as [ReceivedDataModel])
            res.append(receivedDataVM)
        }
        return res.sorted(by: { $0.year > $1.year })
    }
}
//MARK: - SEARCH
extension ReceivedDataRegisterTVController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension ReceivedDataRegisterTVController {
    private func configuration() {
        self.refreshControl = UIRefreshControl()

        let sendMeterDataDevice = getPlusUIBarButtonItem(target: self, action: #selector(showMeterDataDevicePage))
        self.navigationItem.rightBarButtonItems = [sendMeterDataDevice]
        
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        let nib = UINib(nibName: "ReceivedDataTVCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "receivedDataCell")
        self.refreshControl?.addTarget(self, action: #selector(refreshReceivedData), for: UIControl.Event.valueChanged)
        
        refreshReceivedData()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ReceivedDataRegisterTVController: ReceivedDataTVControllerDelegate {
    func resultOfDelete(result: ResultModel<String>) {
        let isError = result.isError
        self.showAlert(
            title: isError ? "Ошибка!" : "Успешно!",
            mesg: result.message!) {
                (UIAlertAction) in
                if !isError {
                    self.receivedDataList[self.indexPath!.section].receivedData.remove(at: self.indexPath!.row)
                    self.tableView.deleteRows(at: [self.indexPath!], with: .automatic)
                    self.tableView.reloadData()
                }
        }
    }
    
    
    func setData(model: ResultModel<[ReceivedDataModel]>) {
        // todo доделать получение данных из realm
        self.receivedDataList =  mapToReceivedDataModelView(receivedData: model.data!)
        ActivityIndicationService.shared.hideView()
    }
    
    func getReceivedDataAddNewTemplatePage() {
        self.delegate?.showReceivedDataAddNewTemplatesOneStepPage(device: device!)
    }
}
