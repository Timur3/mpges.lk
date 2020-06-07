//
//  AboutTableViewController.swift
//  mpges.lk
//
//  Created by Timur on 22.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class AboutTableViewController: CommonTableViewController {
    public weak var delegate: ProfileCoordinator?
    var sections = ["Организация", "Разработчик"]
    
    var orgCell: UITableViewCell = { getCustomCell(textLabel: "МП ГЭС (ИНН: 8601005865)", imageCell: myImage.docText, textAlign: .left, accessoryType: .none) }()
    var developerCell: UITableViewCell = { getCustomCell(textLabel: "Чалимов Тимур Тимергалиевич", imageCell: myImage.docText, textAlign: .left, accessoryType: .none) }()
    
    override func viewDidLoad() {
        self.navigationItem.title = "О программе"
        super.viewDidLoad()
        configuration()
        //developerCell.te = "Ведущий инженер-программист"
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
                return orgCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return developerCell
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
}

extension AboutTableViewController {
    private func configuration() {
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
        self.tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        self.hideKeyboardWhenTappedAround()
    }
    
    func updateTableViewContentInset() {
        let viewHeight: CGFloat = view.frame.size.height
        let tableViewContentHeight: CGFloat = tableView.contentSize.height
        let marginHeight: CGFloat = (viewHeight - tableViewContentHeight) / 3.0
        self.tableView.contentInset = UIEdgeInsets(top: marginHeight, left: 0, bottom:  0, right: 0)
    }
}
