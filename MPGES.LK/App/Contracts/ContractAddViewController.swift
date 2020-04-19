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

class ContractAddViewController: UIViewController {
    public weak var delegate: ContractsTVControllerUserDelegate?

    @IBOutlet weak var numberContract: UITextField!
    @IBOutlet weak var codeBinding: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var errorNumberLabel: UILabel!
   
    @IBAction func numberInput(_ sender: Any) {
        let model = ContractNumberModel(number: numberContract.text!)
        self.checkContractByNumber(model: model)
    }
    
    override func viewDidLoad() {
        self.title = "Добавить договор"
        super.viewDidLoad()
        configuration()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.getContracts()
    }
    
    @objc func submitAction(sender:UIButton!) {
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
        //ApiServiceAdapter.shared.checkByNumberContract(model: model, delegate: self)
    }

    func goToBinding(model: ContractBindingModel) {
        ActivityIndicatorViewService.shared.showView(form: self.view)
        //ApiServiceAdapter.shared.contractBinding(model: model, delegate: self)
    }
    
    func resultToBinding(result: ServerResponseModel) {
        ActivityIndicatorViewService.shared.hideView()
        AlertControllerAdapter.shared.show(
            title: result.isError ? "Ошибка" : "Успешно",
            mesg: result.message,
            form: self) { (UIAlertAction) in
                if !result.isError {
                    self.cancelButton()
                }
        }
    }
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - CONFiGURE
extension ContractAddViewController {
    private func configuration() {
        submitBtn.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        submitBtn.Circle()

        self.numberContract.keyboardType = UIKeyboardType.numberPad
        let cancelBtn = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButton))
        self.navigationItem.rightBarButtonItems = [cancelBtn]
    }
}
