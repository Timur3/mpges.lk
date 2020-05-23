//
//  ReceivedDataTVController.swift
//  mpges.lk
//
//  Created by Timur on 21.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
public protocol ReceivedDataTVControllerDelegate: class {
    func setData(model: ReceivedDataModelRoot)
    func getReceivedDataAddNewTemplatePage()
}

class ReceivedDataTVController: CommonTableViewController {
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
        ActivityIndicatorViewService.shared.showView(form: self.view)
        navigationItem.title = "Реестр показаний"
        super.viewDidLoad()
        configuration()
    }
           
    @objc func refreshReceivedData(){
        ApiServiceAdapter.shared.getReceivedDataByDeviceId(id: device!.id, delegate: self)
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
    
    @objc func showMeterDataDevicePage() {
        self.showReceivedDataAddNewTemplateTVPage()
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
    
    @objc func segmentSwicht(){
        
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
        
        //let segment = UISegmentedControl(items: ["Реестр","График"])
        //segment.addTarget(self, action: #selector(segmentSwicht), for: UIControl.Event.valueChanged)
        //segment.selectedSegmentIndex = 0
        //self.navigationItem.titleView = segment
        
        let sendMeterDataDevice = getPlusUIBarButtonItem(target: self, action: #selector(showMeterDataDevicePage))
        self.navigationItem.rightBarButtonItems = [sendMeterDataDevice]
        
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        let nib = UINib(nibName: "ReceivedDataTVCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "receivedDataCell")
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshReceivedData), for: UIControl.Event.valueChanged)

        refreshReceivedData()
               
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ReceivedDataTVController: ReceivedDataTVControllerDelegate {
    
    func setData(model: ReceivedDataModelRoot) {
        // todo доделать получение данных из realm
        self.receivedDataList =  mapToReceivedDataModelView(receivedData: model.data)
        ActivityIndicatorViewService.shared.hideView()
    }
    
    func getReceivedDataAddNewTemplatePage() {
        self.delegate?.showReceivedDataAddNewTemplatesOneStepPage(device: device!)
    }
}
