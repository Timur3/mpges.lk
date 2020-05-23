//
//  FirstTVController.swift
//  mpges.lk
//
//  Created by Timur on 14.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class FirstTVController: CommonTableViewController {
    
    public weak var delegate: MainCoordinatorDelegate?
    
    var sections: [String] {["", "", ""]}
    
    var logoCell: UITableViewCell = { getCustomCell(textLabel: "", imageCell: myImage.none, textAlign: .left, accessoryType: .none) }()
    var inputCell: UITableViewCell { getCustomCell(textLabel: "Войти", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    
    var singUpCell: UITableViewCell { getCustomCell(textLabel: "Регистрация", imageCell: .none, textAlign: .center, textColor: .systemRed, accessoryType: .none) }
    
    var logoImgView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "LogoFirstPage")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override func viewDidLoad() {
        self.navigationItem.title = "Главная"
        super.viewDidLoad()
        configuration()
        setUpLayout()
    }
    
    override func viewWillLayoutSubviews() {
        self.updateTableViewContentInset()
    }
    
    func setUpLayout(){
        logoCell.addSubview(logoImgView)
        logoImgView.leadingAnchor.constraint(equalTo: logoCell.leadingAnchor, constant: 5).isActive = true
        logoImgView.rightAnchor.constraint(equalTo: logoCell.rightAnchor, constant: 5).isActive = true
        logoImgView.topAnchor.constraint(equalTo: logoCell.topAnchor, constant: 5).isActive = true
        logoImgView.centerYAnchor.constraint(equalTo: logoCell.centerYAnchor).isActive = true
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0 && indexPath.row == 0) ? CGFloat(250) : UITableView.automaticDimension
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
                return inputCell
            default:
                fatalError()
            }
        case 2:
            switch indexPath.row {
            case 0:
                return singUpCell
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

        if indexPath.section == 1 && indexPath.row == 0 {
            delegate?.navigateToSingInPage()
        }
        
        if indexPath.section == 2 && indexPath.row == 0 {
            delegate?.navigateToSingUpPage()
        }
    }
}

//MARK: - CONFIGURE
extension FirstTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        self.hideKeyboardWhenTappedAround()
    }
    
    func updateTableViewContentInset() {
        let viewHeight: CGFloat = view.frame.size.height
        let tableViewContentHeight: CGFloat = tableView.contentSize.height
        let marginHeight: CGFloat = (viewHeight - tableViewContentHeight) / 3.0
        self.tableView.contentInset = UIEdgeInsets(top: marginHeight, left: 0, bottom:  0, right: 0)
    }
}
