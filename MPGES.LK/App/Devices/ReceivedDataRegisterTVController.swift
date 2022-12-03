//
//  ReceivedDataTVController.swift
//  mpges.lk
//
//  Created by Timur on 21.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

public protocol ReceivedDataTVControllerDelegate: AnyObject {
    func setData(model: ResultModel<[ReceivedDataModel]>)
    func getReceivedDataAddNewTemplatePage()
    func resultOfDelete(result: ResultModel<String>)
}

class ReceivedDataRegisterTVController: CommonViewController {
    let searchController = UISearchController(searchResultsController: nil)
    private var indexPath: IndexPath?
    public weak var delegate: DeviceCoordinatorMain?
    
    public var device: DeviceModel? {
        didSet {
            getReceivedData()
        }
    }
    
    private lazy var receivedDataTableView: UITableView = {
        var table = UITableView.init(frame: .zero, style: .insetGrouped)
        let nib = UINib(nibName: ReceivedDataTVCell.identifier, bundle: nil)
        table.register(nib, forCellReuseIdentifier: ReceivedDataTVCell.identifier)
        table.isUserInteractionEnabled = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.refreshControl = UIRefreshControl()
        table.refreshControl?.addTarget(self, action: #selector(getReceivedData), for: UIControl.Event.valueChanged)
        return table
    }()
    var receivedDataList: [ReceivedDataModelVeiw] = [] {
        didSet {
            DispatchQueue.main.async {
                self.receivedDataTableView.reloadData()
                self.hideLoadingIndicator()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        getReceivedData()
        setUpLayout()
    }
    
    private func configuration() {
        let sendMeterDataDevice = getPlusUIBarButtonItem(target: self, action: #selector(showMeterDataDevicePage))
        self.navigationItem.rightBarButtonItems = [sendMeterDataDevice]

        receivedDataTableView.delegate = self
        receivedDataTableView.dataSource = self
    }
    
    private func setUpLayout(){
        view.addSubview(receivedDataTableView)
        NSLayoutConstraint.activate([
            receivedDataTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            receivedDataTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            receivedDataTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            receivedDataTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
    
    @objc func getReceivedData() {
        self.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            ApiServiceWrapper.shared.getReceivedDataByDeviceId(id: self.device!.id, delegate: self)
            self.receivedDataTableView.refreshControl?.endRefreshing()
        }
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
}

//MARK: - UITableViewDelegate
extension ReceivedDataRegisterTVController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        print("did End Displaying Header View")
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        print("did End Displaying Footer View")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: - UITableViewDataSource
extension ReceivedDataRegisterTVController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return receivedDataList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let count = receivedDataList[section].receivedData.count
        let volume = receivedDataList[section].receivedData.map({$0.volume}).reduce(0, +)
        let msg = "Всего записей: \(count)\nобъем потребления: \(volume) кВт/ч"
        return "\(receivedDataList[section].year)" + " год\n\(msg)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return receivedDataList[section].receivedData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.indexPath = indexPath
        if editingStyle == .delete {
            let id = receivedDataList[indexPath.section].receivedData[indexPath.row].id
            ApiServiceWrapper.shared.receivedDataDelete(id: id, delegate: self)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReceivedDataTVCell.identifier, for: indexPath) as! ReceivedDataTVCell
        cell.imageView?.image = UIImage.init(systemName: AppImage.receivedData.rawValue)
        cell.update(for: receivedDataList[indexPath.section].receivedData[indexPath.row])
        return cell
    }
}

//MARK: - SEARCH
extension ReceivedDataRegisterTVController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension ReceivedDataRegisterTVController: ReceivedDataTVControllerDelegate {
    func resultOfDelete(result: ResultModel<String>) {
        let isError = result.isError
        self.showAlert(
            title: isError ? "Ошибка" : "Успешно",
            mesg: result.message!) {
                (UIAlertAction) in
                if !isError {
                    self.receivedDataList[self.indexPath!.section].receivedData.remove(at: self.indexPath!.row)
                    self.receivedDataTableView.deleteRows(at: [self.indexPath!], with: .automatic)
                    self.receivedDataTableView.reloadData()
                }
        }
    }
    
    
    func setData(model: ResultModel<[ReceivedDataModel]>) {
        // todo доделать получение данных из realm
        self.receivedDataList =  mapToReceivedDataModelView(receivedData: model.data!)
    }
    
    func getReceivedDataAddNewTemplatePage() {
        self.delegate?.showReceivedDataAddNewTemplatesOneStepPage(device: device!)
    }
}
