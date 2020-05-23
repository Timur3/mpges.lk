//
//  ReceivedDataAddNewTemplateTVControllerOneStep.swift
//  mpges.lk
//
//  Created by Timur on 26.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
protocol ReceivedDataAddNewTemplateTVControllerOneStepDelegate: class {
    func setData(model: ReceivedDataAddNewTemplateModelRoot)
}

class ReceivedDataAddNewTemplateTVControllerOneStep: CommonTableViewController {
    public weak var delegate: DeviceCoordinatorMain?
    public var device: DeviceModel?
    let datePicker = UIDatePicker()
    var sections: [String] {["Дата показаний", ""]}
    
    var ReceivedDataDateCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.calendar, textAlign: .left, accessoryType: .none) }()
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
    
    override func viewWillLayoutSubviews() {
        self.updateTableViewContentInset()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Получение списка договоров
        //delegate?.getContracts()
    }
    
    func setUpLayout(){
        ReceivedDataDateCell.addSubview(dateTextField)
        dateTextField.leadingAnchor.constraint(equalTo: ReceivedDataDateCell.leadingAnchor, constant: 50).isActive = true
        dateTextField.centerYAnchor.constraint(equalTo: ReceivedDataDateCell.centerYAnchor).isActive = true
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
            dateTextField.becomeFirstResponder()
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            ActivityIndicatorViewForCellService.shared.showAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
            if isValidDate(dateStr: dateTextField.text!) {
                ApiServiceAdapter.shared.getReceivedDataAddNewTemplatesByDeviceId(id: device!.id, delegate: self)
            } else {
                AlertControllerAdapter.shared.show(
                    title: "Ошибка",
                    mesg: "Некорректная дата",
                    form: self)
            }
            ActivityIndicatorViewForCellService.shared.hiddenAI(cell: self.tableView.cellForRow(at: self.indexPath!)!)
        }
    }
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ReceivedDataAddNewTemplateTVControllerOneStep: ReceivedDataAddNewTemplateTVControllerOneStepDelegate {
    func setData(model: ReceivedDataAddNewTemplateModelRoot) {
        //self.delegate?.showReceivedDataAddNewTemplatesTwoStepPage(device: device!,x nav: self.navigationController!)
        self.delegate?.showReceivedDataAddNewTemplatesPage(device: device!, template: model.data[0], nav: self.navigationController!)
    }
    
    
}

//MARK: - CONFIGURE
extension ReceivedDataAddNewTemplateTVControllerOneStep {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
        
        self.hideKeyboardWhenTappedAround()
        //self.dateTextField.becomeFirstResponder()
        
        datePicker.addTarget(self, action: #selector(datePackerChanged), for: UIControl.Event.valueChanged)
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelDatePicker));
        let doneButton = UIBarButtonItem(title: "Выбрать", style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
        
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
    func updateTableViewContentInset() {
        let viewHeight: CGFloat = view.frame.size.height
        let tableViewContentHeight: CGFloat = tableView.contentSize.height
        let marginHeight: CGFloat = (viewHeight - tableViewContentHeight) / 3.0
        self.tableView.contentInset = UIEdgeInsets(top: marginHeight, left: 0, bottom:  0, right: 0)
    }
}
