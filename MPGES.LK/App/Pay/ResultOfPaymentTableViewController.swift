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
    
    var sections: [String] {["", "Сумма платежа", "Статус платежа", ""]}
    
    var logoCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.none, textAlign: .left, accessoryType: .none) }()
    var closeCell: UITableViewCell { getCustomCell(textLabel: "Готово", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    var summaCell: UITableViewCell = { getCustomCell(textLabel: "1000.00 руб.", imageCell: .none, textAlign: .center, accessoryType: .none, style: .value1) }()
    var statusCell: UITableViewCell { getCustomCell(textLabel: "Отклонено", imageCell: .none, textAlign: .center, accessoryType: .none, style: .value1) }
    
    var statusImgView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(systemName: myImage.xmark.rawValue)
        img.tintColor = .systemRed
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override func viewDidLoad() {
        self.navigationItem.title = "Результат оплаты"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    
    var statusPay: StateResponse? {
        didSet {
            DispatchQueue.main.async {
                self.statusCell.textLabel?.text = "Отклонено"
                self.statusCell.detailTextLabel?.text = "09-10-2020 22:52"
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
        return (indexPath.section == 0 && indexPath.row == 0) ? CGFloat(150) : UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.section == 0 && indexPath.row == 0) {
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = false
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
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
                return logoCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return summaCell
            default:
                fatalError()
            }
        case 2:
            switch indexPath.row {
            case 0:
                return statusCell
            default:
                fatalError()
            }
        case 3:
            switch indexPath.row {
            case 0:
                return closeCell
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
