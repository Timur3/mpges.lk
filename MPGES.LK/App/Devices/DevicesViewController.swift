//
//  DevicesViewController.swift
//  mpges.lk
//
//  Created by Timur on 13.02.2021.
//  Copyright © 2021 ChalimovTimur. All rights reserved.
//

import UIKit

protocol DevicesViewControllerUserDelegate: AnyObject {
    func setDevices(devices:ResultModel<[DeviceModel]>)
}

class DevicesViewController: CommonViewController {
    
    private lazy var devicesTableView: UITableView = {
        var table = UITableView.init(frame: .zero, style: .insetGrouped)
        let nib = UINib(nibName: DeviceTVCell.identifier, bundle: nil)
        table.register(nib, forCellReuseIdentifier: DeviceTVCell.identifier)
        table.isUserInteractionEnabled = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private var searchController = UISearchController(searchResultsController: nil)
    public weak var delegate: DeviceCoordinatorMain?
    public var contractId: Int = 0
    
    var deviceList = [DeviceModel]() {
        didSet {
            DispatchQueue.main.async {
                self.devicesTableView.reloadData()
                self.hideLoadingIndicator()
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
        devicesTableView.refreshControl = UIRefreshControl()
        devicesTableView.refreshControl?.addTarget(self, action: #selector(getDevices), for: UIControl.Event.valueChanged)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Номер прибора учета"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    @objc func getDevices(){
        self.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            ApiServiceWrapper.shared.getDevicesByContractId(id: self.contractId, delegate: self)
            // todo  сохраняем новые данные, предварительно удаляем старые данные
            self.devicesTableView.refreshControl?.endRefreshing()
        }
    }
    
    func setUpLayout(){
        view.addSubview(devicesTableView)
        NSLayoutConstraint.activate([
            devicesTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            devicesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            devicesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            devicesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
}

//MARK: - UITableViewDataSource
extension DevicesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return deviceList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
//MARK: - UITableViewDelegate
extension DevicesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Дата выпуска: " + (deviceList[section].dateOut ?? "01.01.1900")
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeviceTVCell.identifier, for: indexPath) as! DeviceTVCell
        cell.update(for: deviceList[indexPath.section])
        cell.imageView?.image = UIImage(systemName: myImage.gauge.rawValue)
        cell.delegateCell = self
        cell.index = indexPath
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.navigationReceivedDataPage(model: deviceList[indexPath.section])
    }
}

//MARK: - SEARCH
extension DevicesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
//MARK: - USER DELEGATE
extension DevicesViewController: DevicesViewControllerUserDelegate {

    func setDevices(devices: ResultModel<[DeviceModel]>) {
        // todo доделать получение данных из realm
        deviceList = devices.data!
    }
}
//MARK: - RECEIVED DATA ADD NEW DELEGATE
extension DevicesViewController: ReceivedDataAddNewDelegate {
    func onClick(index: Int) {
        delegate?.showReceivedDataAddNewTemplatesOneStepPage(device: deviceList[index])
    }
}
