//
//  DevicesTVController.swift
//  mpges.lk
//
//  Created by Timur on 16.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

protocol DevicesTVControllerUserDelegate: class {
    func setDevices(devices:DevicesModelRoot)
}

class DevicesTVController: CommonTableViewController {
    private var searchController = UISearchController(searchResultsController: nil)
    public weak var delegate: DeviceCoordinatorMain?
    public var contractId: Int = 0
    
    var deviceList = [DeviceModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        ActivityIndicatorViewService.shared.showView(form: (self.navigationController?.view)!)
        navigationItem.title = "Приборы учета"
        super.viewDidLoad()
        configuration()
    }
    
    @objc func refreshDataDevice(){
        ApiServiceWrapper.shared.getDevicesByContractId(id: contractId, delegate: self)
        // todo  сохраняем новые данные, предварительно удаляем старые данные
        self.refreshControl?.endRefreshing()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return deviceList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Всего записей: " + String(deviceList.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell", for: indexPath) as! DeviceTVCell
        //let cellImg : UIImageView = UIImageView(frame: CGRect(x: 5, y: (cell.bounds.height/2)-50, width: 40, height: 40))
        //cellImg.image = UIImage(named:myImage.gauge.rawValue)
        //cell.addSubview(cellImg)
        //cell.imageView?.image = imageWithImage(UIImage(named: myImage.device.rawValue), scaledToSize: CGSize(width: 20, height: 20))
        cell.update(for: deviceList[indexPath.row])
        cell.imageView?.image = UIImage(systemName: myImage.gauge.rawValue)
        cell.delegateCell = self
        cell.index = indexPath
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.navigationReceivedDataPage(model: deviceList[indexPath.row])
    }
}
//MARK: - SEARCH
extension DevicesTVController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
//MARK: - USER DELEGATE
extension DevicesTVController: DevicesTVControllerUserDelegate {
    
    var sections: [String] { ["Установленные приборы учета"] }

    func setDevices(devices: DevicesModelRoot) {
        // todo доделать получение данных из realm
        deviceList = devices.data
        ActivityIndicatorViewService.shared.hideView()
    }
}
//MARK: - RECEIVED DATA ADD NEW DELEGATE
extension DevicesTVController: ReceivedDataAddNewDelegate {
    func onClick(index: Int) {
        delegate?.showReceivedDataAddNewTemplatesOneStepPage(device: deviceList[index])
    }   
}
//MARK: - CONFIGURATION
extension DevicesTVController {
    private func configuration() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Номер прибора учета"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshDataDevice), for: UIControl.Event.valueChanged)
        
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        let nib = UINib(nibName: "DeviceTVCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "deviceCell")
        // todo получение из Realm, если нет то тянем с инета
        refreshDataDevice()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}
