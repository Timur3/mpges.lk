//
//  ReceivedDataAddNewTemplateTVControllerDynamic.swift
//  mpges.lk
//
//  Created by Timur on 24.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
public protocol ReceivedDataAddNewTemplateTVControllerTwoStepDelegate: class {
    func setData(model: ReceivedDataAddNewTemplateModelRoot)
}

class ReceivedDataAddNewTemplateTVControllerTwoStep: UITableViewController {
    public weak var delegate: DeviceCoordinatorMain?
    public var device: DeviceModel?
    public var templateAdd: [ReceivedDataAddNewTemplateModelView] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        navigationItem.title = "Новые показания"
        super.viewDidLoad()
        configuration()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return templateAdd.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return templateAdd[section].receivedDataAddNewTemplates.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return templateAdd[section].tariffZone
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "receivedDataTemplateCell", for: indexPath) as! ReceivedDataAddNewTemplateTVCell
        //cell.imageView?.image = UIImage.init(systemName: myImage.textPlus.rawValue)
        //cell.update(for: templateAdd[indexPath.section].receivedDataAddNewTemplates[indexPath.row])
        //return cell
   // }
    
    @objc func refreshReceivedData(){
        //ApiServiceAdapter.shared.getReceivedDataAddNewTemplatesByDeviceId(id: device!.id, delegate: self)
        self.refreshControl?.endRefreshing()
    }
}
extension ReceivedDataAddNewTemplateTVControllerTwoStep {
    private func configuration() {
        self.hideKeyboardWhenTappedAround()
        
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        let nib = UINib(nibName: "ReceivedDataAddNewTemplateTVCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "receivedDataTemplateCell")
        
        // кнопка сохранить
        let saveBtn = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [saveBtn]
        // кнопка отмена
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        //self.navigationItem.leftBarButtonItems = [cancelBtn]
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshReceivedData), for: UIControl.Event.valueChanged)
        
        refreshReceivedData()
        
    }
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ReceivedDataAddNewTemplateTVControllerTwoStep {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ReceivedDataAddNewTemplateTVControllerTwoStep: ReceivedDataAddNewTemplateTVControllerTwoStepDelegate {
    func setData(model: ReceivedDataAddNewTemplateModelRoot) {
        templateAdd = mapToModelView(templates: model.data)
    }
    
    func mapToModelView(templates: [ReceivedDataAddNewTemplateModel]) -> [ReceivedDataAddNewTemplateModelView] {
        var res = [ReceivedDataAddNewTemplateModelView]()
        let models = templates.groupBy { $0.tariffZone }
        for mod in models {
            let receivedDataVM = ReceivedDataAddNewTemplateModelView(date: "", tariffZone: mod.key, receivedDataAddNewTemplates: mod.value as [ReceivedDataAddNewTemplateModel])
            res.append(receivedDataVM)
        }
        return res
    }
}
