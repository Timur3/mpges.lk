//
//  ReceivedDataAddNewTemplateTVControllerOneStep.swift
//  mpges.lk
//
//  Created by Timur on 26.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
protocol ReceivedDataAddNewTemplateTVControllerOneStepDelegate: AnyObject {
    func setData(model: ResultModel<[ReceivedDataAddNewTemplateModel]>)
}

class ReceivedDataAddNewTemplateTVControllerOneStep: CenterContentAndCommonTableViewController {
    public weak var delegate: DeviceCoordinatorMain?
    public var device: DeviceModel?
    
    var datePicker: UIDatePicker = {
        let date = UIDatePicker()
        date.layer.masksToBounds = true
        date.translatesAutoresizingMaskIntoConstraints = false
        date.datePickerMode = .date
        date.maximumDate = Date()
        date.locale = Locale.init(identifier: "ru_RU")
        return date
    }()
    
    var sections: [String] {["Дата показаний", ""]}
    
    var ReceivedDataDateCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: AppImage.calendar, textAlign: .left, accessoryType: .none) }()
    var saveCell: UITableViewCell { getCustomCell(textLabel: "Продолжить", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    
    var dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите дату"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        self.navigationItem.title = "Новые показания"
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }

    func setUpLayout(){
        ReceivedDataDateCell.addSubview(datePicker)
        datePicker.leadingAnchor.constraint(equalTo: ReceivedDataDateCell.leadingAnchor, constant: 50).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: ReceivedDataDateCell.centerYAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: ReceivedDataDateCell.trailingAnchor, constant: -10).isActive = true
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
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
                return ReceivedDataDateCell
            default:
                fatalError()
            }
        case 1:
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section]
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexPath = indexPath
        
        if indexPath.section == 0 && indexPath.row == 0 {
            //dateTextField.becomeFirstResponder()
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            //if isValidDate(tf: dateTextField) {
            if true {
                ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: indexPath)!)
                ApiServiceWrapper.shared.getReceivedDataAddNewTemplatesByDeviceId(id: device!.id, delegate: self)
            } else {
                self.showAlert(
                    title: "Ошибка",
                    mesg: "Некорректная дата")
            }
        }
    }
    
    func isValidDate(tf: UITextField) -> Bool {
        let isValid = true
        if tf.text!.isEmpty { return false }
        
        let dateFmt = DateFormatter()
        dateFmt.timeZone = NSTimeZone.default
        dateFmt.dateFormat =  "dd.MM.yyyy"
        guard let date = dateFmt.date(from: tf.text!) else { return false }
        if date < dateFmt.date(from: "01.01.2020")! { return false }
        
        datePicker.date = date
        
        return isValid
    }
}

extension ReceivedDataAddNewTemplateTVControllerOneStep: ReceivedDataAddNewTemplateTVControllerOneStepDelegate {
    func setData(model: ResultModel<[ReceivedDataAddNewTemplateModel]>) {
        ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        let m = ReceivedDataAddNewTemplateModelView(date: "\(datePicker.date)", receivedDataAddNewTemplates: model.data!)
        self.delegate?.showReceivedDataAddNewTemplatesPage(device: device!, template: m, nav: self.navigationController!)
    }
}

//MARK: - CONFIGURE
extension ReceivedDataAddNewTemplateTVControllerOneStep {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
        
        self.hideKeyboardWhenTappedAround()
        //datePicker.addTarget(self, action: #selector(datePackerChanged), for: UIControl.Event.valueChanged)
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelDatePicker));
        let doneButton = UIBarButtonItem(title: "Выбрать", style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        //dateTextField.inputAccessoryView = toolbar
        //dateTextField.inputView = datePicker
        
        //self.dateTextField.becomeFirstResponder()
        
    }
    @objc func datePackerChanged() {
        dateFormatterSet()
    }
    @objc func doneDatePicker(){
        dateFormatterSet()
        dateTextField.endEditing(true)
    }
    @objc func cancelDatePicker(){
        dateTextField.endEditing(true)
    }
    func dateFormatterSet(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateTextField.text = formatter.string(from: datePicker.date)
    }
}
