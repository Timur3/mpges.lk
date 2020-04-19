//
//  ReceivedDataTVController.swift
//  mpges.lk
//
//  Created by Timur on 21.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ReceivedDataTVController: UITableViewController {
    let searchController = UISearchController(searchResultsController: nil)
    public weak var delegate: ReceivedDataTVControllerDelegate?
    
    var device: DeviceModel? {
    didSet {
        refreshReceivedData(sender: self)
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
        navigationItem.title = "История показаний"
        super.viewDidLoad()
        configuration()
        ActivityIndicatorViewService.shared.hideView()
    }
           
    @objc func refreshReceivedData(sender: AnyObject){
        print("refresh")
        //ApiServiceAdapter.shared.getReceivedDataByDeviceId(id: device?.id ?? -1, delegate: self.delegate)
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
        return 60
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
        cell.imageView?.image = UIImage.init(systemName: myImage.receivedData.rawValue)
        cell.update(for: receivedDataList[indexPath.section].receivedData[indexPath.row])
        return cell
    }
    
    @objc func alertSheetMeterDataDeviceShow() {
        let alert = UIAlertController(title: "Вы действительно хотите сообщить показания?", message: nil, preferredStyle: .actionSheet)
        let actionYes = UIAlertAction(title: "Да", style: .default) {
            (UIAlertAction) in self.showReceivedDataAddNewTemplateTVPage()
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(actionYes)
        //alert.addAction(actionNewContract)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    func showReceivedDataAddNewTemplateTVPage()
    {
        //self.delegate.
    }
}
//MARK: - SEARCH
extension ReceivedDataTVController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
extension ReceivedDataTVController {
    private func configuration() {
        self.refreshControl = UIRefreshControl()
        let sendMeterDataDevice = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(alertSheetMeterDataDeviceShow))
        self.navigationItem.rightBarButtonItems = [sendMeterDataDevice]
        
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        let nib = UINib(nibName: "ReceivedDataTVCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "receivedDataCell")
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshReceivedData), for: UIControl.Event.valueChanged)

        refreshReceivedData(sender: self)
               
        tableView.delegate = self
        tableView.dataSource = self
    }
}
