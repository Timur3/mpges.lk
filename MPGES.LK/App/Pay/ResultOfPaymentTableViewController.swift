//
//  ResultOfPaymentTableViewController.swift
//  mpges.lk
//
//  Created by Timur on 09.10.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ResultOfPaymentTableViewController: CenterContentAndCommonTableViewController {
    //public weak var delegate: MainCoordinatorDelegate?
    
    var sections: [String] {["", "Сумма платежа", "Статус платежа", "Детали ошибки", ""]}
    
    var logoCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.none, textAlign: .left, accessoryType: .none) }()
    var closeCell: UITableViewCell = { getCustomCell(textLabel: "Готово", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }()
    var summaCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: .none, textAlign: .center, accessoryType: .none) }()
    var statusCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: .none, textAlign: .center, accessoryType: .none, style: .value1) }()
    var detailsCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: .none, textAlign: .left, accessoryType: .none) }()
    
    var statusImgView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(systemName: myImage.xmark.rawValue)
        img.tintColor = .systemRed
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var hideDetails: Bool = true
    
    override func viewDidLoad() {
        self.navigationItem.title = "Результат оплаты"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    
    var statusPay: StatePaymentResponse? {
        didSet {
            DispatchQueue.main.async {
                self.summaCell.textLabel?.text = formatRusCurrency(self.statusPay!.summa)
                self.statusCell.detailTextLabel?.text = formatRusDate(for: Date())
                if !(self.statusPay!.isError) {
                    self.statusCell.textLabel?.text = "Успешно"
                    self.statusImgView.image = UIImage(systemName: myImage.checkmark.rawValue)
                    self.statusImgView.tintColor = .systemGreen
                } else {
                    self.statusCell.textLabel?.text = "Отклонено"
                    self.detailsCell.textLabel?.text = self.statusPay?.message
                    self.hideDetails = false
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func setUpLayout(){
        logoCell.addSubview(statusImgView)
        statusImgView.leadingAnchor.constraint(equalTo: logoCell.leadingAnchor, constant: 5).isActive = true
        statusImgView.rightAnchor.constraint(equalTo: logoCell.rightAnchor, constant: 5).isActive = true
        statusImgView.topAnchor.constraint(equalTo: logoCell.topAnchor, constant: 5).isActive = true
        statusImgView.centerYAnchor.constraint(equalTo: logoCell.centerYAnchor).isActive = true
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0 && indexPath.row == 0) ? CGFloat(100) : UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.section == 0 && indexPath.row == 0) {
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = false
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (hideDetails && section == 3) { return 0 }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return logoCell
        case 1:
            return summaCell
        case 2:
            return statusCell
        case 3:
            return detailsCell
        case 4:
            return closeCell
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (hideDetails && section == 3) { return nil }
        return sections[section]
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 3 && indexPath.row == 0 {
            self.cancelButton()
        }
    }
}

//MARK: - CONFIGURE
extension ResultOfPaymentTableViewController {
    private func configuration() {
      
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        self.hideKeyboardWhenTappedAround()
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
    }
}
