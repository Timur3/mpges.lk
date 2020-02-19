//
//  ReceivedDataTVController.swift
//  mpges.lk
//
//  Created by Timur on 21.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ReceivedDataTVController: UITableViewController {
    let methodApi = MethodApi()

    var device: DeviceModel? {
    didSet {
        debugPrint("device Info")
        refreshDataContract(sender: self)
        }
    }
    
    var receivedDataList: [ReceivedDataModel] = [] {
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
               
        self.refreshControl?.addTarget(self, action: #selector(refreshDataContract), for: UIControl.Event.valueChanged)

        refreshDataContract(sender: self)
               
        tableView.delegate = self
        tableView.dataSource = self
    }
           
    @objc func refreshDataContract(sender: AnyObject){
    print("refresh")
    ApiService.shared.requestById(id: device?.id ?? -1, method: methodApi.getReceivedData, completion: setReceivedData(data:))
    self.refreshControl?.endRefreshing()
}
           
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return receivedDataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "receivedDataCell", for: indexPath) as! ReceivedDataTVCell
        cell.receivedData = receivedDataList[indexPath.row]

        return cell
    }
}

extension ReceivedDataTVController: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            print("search")
        }
    
        func setReceivedData(data: ReceivedDataModelRoot) {
            // todo доделать получение данных из realm
            receivedDataList = data.data
        }
}
