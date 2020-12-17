//
//  EmailToDeveloperTVController.swift
//  mpges.lk
//
//  Created by Timur on 02.05.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices


class EmailToDeveloperTVController: CenterContentAndCommonTableViewController {
    var sections: [String] {["Письмо разработчику", "Письмо обращение" ]}
    
    public weak var delegate: ProfileCoordinator?
    
    var emailToDevelopCell: UITableViewCell { getCustomCell(textLabel: "Написать письмо разработчику", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    var emailToAppCell: UITableViewCell { getCustomCell(textLabel: "Направить обращение", imageCell: .none, textAlign: .center, textColor: .systemBlue, accessoryType: .none) }
    
    override func viewDidLoad() {
        self.navigationItem.title = "Новое письмо"
        super.viewDidLoad()
        configuration()
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
                return emailToDevelopCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return emailToAppCell
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
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if (section == 0) {
            return "Если у Вас пожелания, замечания или обнаружели ошибки по программе..."
        } else
        if (section == 1){
            return "Если возникли вопросы по показаниям, либо обнаружили ошибки в расчетах..."
        }
        return ""
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexPath = indexPath
        
        if indexPath.section == 0 && indexPath.row == 0 {
            sendEmailToDeveloper()
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            sendApplication()
        }
    }
    
    func sendApplication(){
        if let url = URL(string: "https://afc.mp-ges.ru/") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
    }
}

extension EmailToDeveloperTVController: MFMailComposeViewControllerDelegate {
    func sendEmailToDeveloper() {
        if MFMailComposeViewController.canSendMail() {
            
            let mail = MFMailComposeViewController()
            
            mail.mailComposeDelegate = self
            mail.setToRecipients(["developer_mp-ges@mail.ru"])
            mail.setSubject("#mp-ges - обратная связь")
            mail.setMessageBody("<p>Напишите ваши пожелания или расскажите о проблеме - это нам очень важно. Спасибо.</p>", isHTML: true)
            present(mail, animated: true, completion: nil)
           
            } else {
                let msg = "Убедитесь что у Вас настроено приложение Почта и есть активная учетная запись"
                AlertControllerAdapter.shared.show(title: "Ошибка", mesg: msg, form: self){
                    (UIAlertAction) in
                    self.cancelButton()
                }
            }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if (result == .failed) {
            let msg = "Ошибка отправки письма, убедитесь что у Вас настроено приложение Почта и есть активная учетная запись"
            AlertControllerAdapter.shared.show(title: "Ошибка", mesg: msg, form: self){
                (UIAlertAction) in
                self.cancelButton()
            }
        }
        controller.dismiss(animated: true) {
            self.cancelButton()
        }
    
    }
}

//MARK: - CONFIGURE
extension EmailToDeveloperTVController {
    private func configuration() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        self.hideKeyboardWhenTappedAround()
        
        let cancelBtn = getCloseUIBarButtonItem(target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
    }
}
