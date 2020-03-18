//
//  ContractAddViewController.swift
//  mpges.lk
//
//  Created by Timur on 03.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import UIKit

protocol ContractAddViewControllerUserDelegate: class {
    func checkContractByNumber(model: ContractNumberModel)
    func resultCheckContract(result: ServerResponseModel)
    func goToBinding(model: ContractBindingModel)
    func resultToBinding(result: ServerResponseModel)
}

protocol ContractAddViewControllerDelegate: class {
    func navigateToBackPage()
}


class ContractAddViewController: UIViewController {
    
    public weak var delegate: ContractAddViewControllerDelegate?
    
    @IBOutlet weak var numberContract: UITextField!
    @IBOutlet weak var codeBinding: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var errorNumberLabel: UILabel!
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.delegate?.navigateToBackPage()
    }
    @IBAction func numberInput(_ sender: Any) {
        if (numberContract.text!.count == 11) {
            let model = ContractNumberModel(number: numberContract.text!)
            self.checkContractByNumber(model: model)
        }
    }
    
    //public weak var delegate: ContractsTVControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        submitBtn.Circle()
        // Do any additional setup after loading the view.
    }
    
    @objc func submitAction(sender:UIButton!) {
        errorNumberLabel.text = ""
        let model = ContractBindingModel(number: numberContract.text!, code: codeBinding.text!)
        self.goToBinding(model: model)
     }
}

extension ContractAddViewController: ContractAddViewControllerUserDelegate {
    func resultCheckContract(result: ServerResponseModel) {
        if (result.isError) {
            numberContract.shake(times: 3, delta: 5)
        }
        errorNumberLabel.text = result.message
    }
    
    func checkContractByNumber(model: ContractNumberModel) {
        ApiServiceAdapter.shared.checkByNumberContract(model: model, delegate: self)
    }

    func goToBinding(model: ContractBindingModel) {
        ActivityIndicatorViewService.shared.showView(form: self.view)
        ApiServiceAdapter.shared.contractBinding(model: model, delegate: self)
    }
    
    func resultToBinding(result: ServerResponseModel) {
        ActivityIndicatorViewService.shared.hideView()
        AlertControllerHelper.shared.show(
            title: result.isError ? "Ошибка" : "Успешно",
            mesg: result.message,
            form: self) { (UIAlertAction) in
                if !result.isError { self.delegate?.navigateToBackPage() }
        }
    }
    
    
}
