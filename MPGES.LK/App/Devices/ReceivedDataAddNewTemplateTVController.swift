//
//  ReceivedDataAddNewTemplateTVControllerOneStep.swift
//  mpges.lk
//
//  Created by Timur on 26.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
public protocol ReceivedDataAddNewTemplateTVControllerDelegate: AnyObject {
    func resultOfSending(result: ResultModel<String>)
}

class ReceivedDataAddNewTemplateTVController: CommonTableViewController {
    public weak var delegate: DeviceCoordinatorMain?
    
    public var mainModel: ReceivedDataAddNewTemplateModelView? {
        didSet {
            DispatchQueue.main.async {
                self.bindingTemplate()
            }
        }
    }
    let datePicker = UIDatePicker()
    private var isFilledAll: Bool = false
    
    var sections: [String] {["Тарифная зона", "Предыдущие показания", "Текущие показания", "Примерный расчет, с учетом всех тарифных зон", ""]}
    var tariffZoneCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.calendar, textAlign: .left, accessoryType: .none) }()
    var previousDateCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.calendar, textAlign: .left, accessoryType: .none) }()
    var previousReceivedDataCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.docText, textAlign: .left, accessoryType: .none) }()
    var deviceRazryadCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.calendar, textAlign: .left, accessoryType: .none) }()
    var tariffValueCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.docText, textAlign: .left, accessoryType: .none) }()
    
    var receivedDataCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.docText, textAlign: .left, accessoryType: .none) }()
    
    var calcCell: UITableViewCell = { getCustomCell(textLabel: formatRusCurrency(0), imageCell: myImage.docText, textAlign: .left, accessoryType: .none) }()
    var saveCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }()
    
    var receivedDataTF: UITextField = { getCustomTextField(placeholder: "Введите показания", keyboardType: .numberPad) }()
    
    public var model: ReceivedDataAddNewTemplateModel? {
        didSet {
            DispatchQueue.main.async {
                self.tariffZoneCell.textLabel?.text = self.model?.tariffZone
                self.previousDateCell.textLabel?.text = self.model?.previousDate
                self.previousReceivedDataCell.textLabel?.text = "\(self.model?.previousReceivedData ?? 0)"
                self.receivedDataTF.text = ""
                self.saveCell.textLabel?.text = self.isFilledAll ? "Передать" : "Продолжить"
                self.tableView.reloadData()
                print("1")
            }
        }
    }
    
    override func viewDidLoad() {
        self.navigationItem.title = "Новые показания"
        super.viewDidLoad()
        configuration()
        setUpLayout()
        print("2")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func setUpLayout(){
        receivedDataCell.addSubview(receivedDataTF)
        receivedDataTF.leadingAnchor.constraint(equalTo: receivedDataCell.leadingAnchor, constant: 50).isActive = true
        receivedDataTF.centerYAnchor.constraint(equalTo: receivedDataCell.centerYAnchor).isActive = true
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.receivedDataTF.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 1
        case 3:
            return 1
        case 4:
            return 1
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return tariffZoneCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return previousDateCell
            case 1:
                return previousReceivedDataCell
            default:
                fatalError()
            }
        case 2:
            switch indexPath.row {
            case 0:
                return receivedDataCell
            default:
                fatalError()
            }
        case 3:
            switch indexPath.row {
            case 0:
                return calcCell
            default:
                fatalError()
            }
        case 4:
            switch indexPath.row {
            case 0:
                return saveCell
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return section == 0 ? "Стоимость 1 кВт*ч составляет: " + formatRusCurrency((self.model?.tariffValue ?? 0.00)) : ""
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section]
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexPath = indexPath
        
        if indexPath.section == 2 && indexPath.row == 0 {
            receivedDataTF.becomeFirstResponder()
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            
        }
        if indexPath.section == 4 && indexPath.row == 0 {
            let cell = self.tableView.cellForRow(at: indexPath)!
            if isValidReceivedData(tf: receivedDataTF) {
                ActivityIndicatorViewForCellService.shared.showAI(cell: cell)
                completionInput()
                if isFilledAll {
                    print("send server")
                    let modelOfSend = createModelOfSend(model: self.mainModel!)
                    ApiServiceWrapper.shared.sendReceivedData(model: modelOfSend, delegate: self)
                } else {                    
                    bindingTemplate()
                }
            } else {
                self.receivedDataCell.layer.borderColor = UIColor.red.cgColor
                self.receivedDataCell.layer.borderWidth = 1.0
                self.receivedDataTF.becomeFirstResponder()
            }
        }
    }
    
    func createModelOfSend(model: ReceivedDataAddNewTemplateModelView) -> [ReceivedDataOfSendingModel] {
        var temp = [ReceivedDataOfSendingModel]()
        for item in model.receivedDataAddNewTemplates {
            temp.append(ReceivedDataOfSendingModel(date: model.date, tariffZoneId: item.tariffZoneId, receivedDataValue: item.receivedData!))
        }
        return temp
    }
    func isValidReceivedData(tf: UITextField) -> Bool {
        let isValid = true
        if receivedDataTF.text!.isEmpty { return false }
        guard let rd = Int(receivedDataTF.text!) else { return false }
        if rd < self.model!.previousReceivedData { return false }
        return isValid
    }
    
    func completionInput() {
        if let row = self.mainModel?.receivedDataAddNewTemplates.firstIndex(where: {$0.tariffZoneId == self.model?.tariffZoneId }) {
            self.mainModel?.receivedDataAddNewTemplates[row].isFilled = true
            self.mainModel?.receivedDataAddNewTemplates[row].receivedData = Int(receivedDataTF.text!)
        }
    }
    
    func bindingTemplate(){
        let temp = mainModel?.receivedDataAddNewTemplates.filter({ $0.isFilled == false }).first
        model = temp
        let m = mainModel?.receivedDataAddNewTemplates.filter({ $0.isFilled == false })
        if (m?.count == 1) {
            self.isFilledAll = true
        }
        self.hiddenAI()
        //receivedDataTF.becomeFirstResponder()
    }
    
    @objc func inputReceivedDataTFAction(){
        receivedDataCell.layer.borderColor = .none
        receivedDataCell.layer.borderWidth = 0
        guard let v1 = Double((previousReceivedDataCell.textLabel?.text)!) else { return }
        guard let v2 = Double(receivedDataTF.text!) else { return }
        let volume = v2 - v1
        let itog = volume * self.model!.tariffValue
        calcCell.textLabel?.text = formatRusCurrency(itog)
    }
}
//MARK: - DELEGATE
extension ReceivedDataAddNewTemplateTVController: ReceivedDataAddNewTemplateTVControllerDelegate {
    func resultOfSending(result: ResultModel<String>) {
        let isError = result.isError
        self.showAlert(
            title: isError ? "Ошибка!" : "Успешно!",
            mesg: result.message!) { (UIAlertAction) in self.cancelButton() }
    }
}
//MARK: - CONFIGURE
extension ReceivedDataAddNewTemplateTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
        self.hideKeyboardWhenTappedAround()
        self.receivedDataTF.addTarget(self, action: #selector(inputReceivedDataTFAction), for: .editingChanged)
    }
}
