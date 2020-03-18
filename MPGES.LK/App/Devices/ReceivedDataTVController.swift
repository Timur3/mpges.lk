//
//  ReceivedDataTVController.swift
//  mpges.lk
//
//  Created by Timur on 21.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
public protocol ReceivedDataTVControllerDelegate: class {
    
}

class ReceivedDataTVController: UITableViewController {
    let methodApi = MethodApi()
    let searchController = UISearchController(searchResultsController: nil)
    public weak var delegate: ReceivedDataTVControllerDelegate?
    
    var device: DeviceModel? {
    didSet {
        debugPrint("device Info")
        refreshDataContract(sender: self)
        }
    }
    
    var receivedDataList: [ReceivedDataModelVeiw] = [] {
        didSet {
            debugPrint("received data device")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
     override func viewDidLoad() {
        navigationItem.title = "Показания"
        super.viewDidLoad()
        self.tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        let nib = UINib(nibName: "ReceivedDataTVCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "receivedDataCell")
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshDataContract), for: UIControl.Event.valueChanged)

        refreshDataContract(sender: self)
               
        tableView.delegate = self
        tableView.dataSource = self
    }
           
    @objc func refreshDataContract(sender: AnyObject){
    print("refresh")
    ApiService.shared.requestById(id: device?.id ?? -1, method: methodApi.getReceivedData, completion: setReceivedData(dataRoot:))
    self.refreshControl?.endRefreshing()
}
           
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return receivedDataList.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(receivedDataList[section].year)" + " год"
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Количество записей: " + "\(receivedDataList[section].receivedData.count)"
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return receivedDataList[section].receivedData.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            receivedDataList[indexPath.section].receivedData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            //ApiServiceAdapter.shared.removeContractBinding(model: model, delegate: self)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "receivedDataCell", for: indexPath) as! ReceivedDataTVCell
        cell.receivedData = receivedDataList[indexPath.section].receivedData[indexPath.row]

        return cell
    }
}
//MARK: - SEARCH
extension ReceivedDataTVController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension ReceivedDataTVController: ReceivedDataTVControllerDelegate {

    func mapToReceivedDataModelView(receivedData: [ReceivedDataModel]) -> [ReceivedDataModelVeiw] {
        var res = [ReceivedDataModelVeiw]()
        let models = receivedData.groupBy { $0.receivedDataYear() }
        for mod in models{
            let receivedDataVM = ReceivedDataModelVeiw(year: mod.key, receivedData: mod.value as [ReceivedDataModel])
            res.append(receivedDataVM)
        }
        return res.sorted(by: { $0.year > $1.year })
    }
    
    func setReceivedData(dataRoot: ReceivedDataModelRoot) {
            // todo доделать получение данных из realm
        receivedDataList = mapToReceivedDataModelView(receivedData: dataRoot.data)
    }
    
}
