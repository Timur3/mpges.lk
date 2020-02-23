//
//  ProfileTVController.swift
//  mpges.lk
//
//  Created by Timur on 02.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

class ProfileTVController: UITableViewController {
    
    var exitCell: UITableViewCell { getCustomCell(textLabel: "Выйти", textAlign: .center, accessoryType: .none) }
    
    
    @IBAction func exitButton(_ sender: Any) {
        debugPrint("exitB press")
        performSegue(withIdentifier: "GoToMain", sender: self)
        
        UserDataService.shared.delData()
        navigationController?.isNavigationBarHidden = false
        
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Еще"
        super.viewDidLoad()
        //ApiServiceAdapter.shared
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sections[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return exitCell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section]
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        //let viewController = (initWithNibName:@"FirstViewController" bundle:nil]
        //self.navigationController.pushViewController(viewController, animated:true)
    }

}

extension ProfileTVController: ProfileTVControllerDelegate {
    func setProfile(profile: UserModel) {
        
    }
    
    var sections: [String] {["Мои данные", "Прочее"]}
    
    func setProfile(contracts: AccountModel) {
        
    }
    
    
}
