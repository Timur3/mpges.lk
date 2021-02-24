//
//  DevicesViewController.swift
//  mpges.lk
//
//  Created by Timur on 13.02.2021.
//  Copyright © 2021 ChalimovTimur. All rights reserved.
//

import UIKit
import SkeletonView

protocol DevicesViewControllerUserDelegate: class {
    func setDevices(devices:ResultModel<[DeviceModel]>)
}

class DevicesViewController: UIViewController, UITableViewDelegate, SkeletonTableViewDataSource {
    let tableView = UITableView.init(frame: .zero, style: .insetGrouped)
    
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
        navigationItem.title = "Приборы учета"
        super.viewDidLoad()
        configuration()
        setUpLayout()
        getDevices()
    }
    private func configuration() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Номер прибора учета"
        definesPresentationContext = true
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(getDevices), for: UIControl.Event.valueChanged)
        
        let nib = UINib(nibName: "DeviceTVCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "deviceCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // skeletonView
        self.tableView.isSkeletonable = true
        self.tableView.showAnimatedSkeleton(usingColor: .lightGray, transition: .crossDissolve(0.25))
    }
    
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return DeviceTVCell.identifier
    }
    
    @objc func getDevices(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            ApiServiceWrapper.shared.getDevicesByContractId(id: self.contractId, delegate: self)
            // todo  сохраняем новые данные, предварительно удаляем старые данные
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
        navigationItem.searchController = searchController
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return deviceList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Всего записей: " + String(deviceList.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell", for: indexPath) as! DeviceTVCell
        cell.update(for: deviceList[indexPath.row])
        cell.imageView?.image = UIImage(systemName: myImage.gauge.rawValue)
        cell.delegateCell = self
        cell.index = indexPath
        return cell
    }

    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    // Override to support rearranging the table view.
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.navigationReceivedDataPage(model: deviceList[indexPath.row])
    }
}

//MARK: - SEARCH
extension DevicesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
//MARK: - USER DELEGATE
extension DevicesViewController: DevicesViewControllerUserDelegate {
    
    var sections: [String] { ["Установленные приборы учета"] }

    func setDevices(devices: ResultModel<[DeviceModel]>) {
        // todo доделать получение данных из realm
        deviceList = devices.data!
        // stop skeltonView
        self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
    }
}
//MARK: - RECEIVED DATA ADD NEW DELEGATE
extension DevicesViewController: ReceivedDataAddNewDelegate {
    func onClick(index: Int) {
        delegate?.showReceivedDataAddNewTemplatesOneStepPage(device: deviceList[index])
    }
}
