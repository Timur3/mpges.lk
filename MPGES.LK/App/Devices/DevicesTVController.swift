//
//  DevicesTVController.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class DevicesTVController: UITableViewController {
    let methodApi = MethodApi()
    
    var deviceList = [DeviceModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: #selector(refreshDataDevice), for: UIControl.Event.valueChanged)
        tableView.addSubview(self.refreshControl!)
        
        // todo получение из Realm, если нет то тянем с инета
        refreshDataDevice(sender: self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    @objc func refreshDataDevice(sender: AnyObject){
    print("refresh")
        ApiServiceAdapter.shared.getDevicesByContractId(delegate: self)
        // todo  сохраняем новые данные, предварительно удаляем старые данные
        self.refreshControl?.endRefreshing()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return deviceList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Установленные приборы учета"
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "ИТОГО: " + String(deviceList.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell", for: indexPath) as! DeviceTVCell
        cell.device = deviceList[indexPath.row]

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let deviceSend = deviceList[indexPath.row]
        
        performSegue(withIdentifier: "receivedData", sender: deviceSend)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "receivedData", let receivedData = segue.destination as? ReceivedDataTVController {
            receivedData.device = sender as? DeviceModel
        }
    }
}
extension DevicesTVController: UISearchBarDelegate, DevicesTVControllerDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search")
    }
    
    func setDevices(devices: DevicesModelRoot) {
        // todo доделать получение данных из realm
        deviceList = devices.data
    }
}
