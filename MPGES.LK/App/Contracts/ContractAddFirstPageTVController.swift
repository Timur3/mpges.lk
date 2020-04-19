//
//  ContractAddFirstPageTVController.swift
//  mpges.lk
//
//  Created by Timur on 14.04.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
public protocol ContractAddFirstPageTVControllerDelegate: class {
   func setData(for numbers: ListOfContractNumbersRoot)
}

class ContractAddFirstPageTVController: UITableViewController {
    
    public weak var delegate: ContractsTVControllerUserDelegate?
    private var searchController = UISearchController(searchResultsController: nil)
    private var tempListOfContractNumbers = [String]()
    private var searchBarIsEmpty: Bool {
        guard let str = searchController.searchBar.text else { return false }
        return str.isEmpty
    }
    
    override func viewDidLoad() {
        self.title = "Добавить договор"
        super.viewDidLoad()
        configuration()
    }

    private var listOfContractNumbers = [String]() {
        didSet {
            DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listOfContractNumbers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getCustomCell(textLabel: ("Лиц. счет: " + listOfContractNumbers[indexPath.row]), imageCell: myImage.link, textAlign: .left, accessoryType: .disclosureIndicator)
        
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - delegate
extension ContractAddFirstPageTVController: ContractAddFirstPageTVControllerDelegate {
    func setData(for numbers: ListOfContractNumbersRoot) {
        listOfContractNumbers = numbers.data
        tempListOfContractNumbers = numbers.data
    }
}

// MARK: - SEARCH
extension ContractAddFirstPageTVController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if (!searchBarIsEmpty) {
            filterContent(searchController.searchBar.text!)
        } else {
            listOfContractNumbers = tempListOfContractNumbers
            
        }
    }
    private func filterContent(_ searchText: String)
    {
        listOfContractNumbers = tempListOfContractNumbers.filter{$0.lowercased().contains(searchText.lowercased())}
    }
    
}


extension ContractAddFirstPageTVController {
    func configuration(){
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите ЛС 86..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
  
        let cancelBtn = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
        ApiServiceAdapter.shared.getListOfContractNumbers(delegate: self)
    }
}
