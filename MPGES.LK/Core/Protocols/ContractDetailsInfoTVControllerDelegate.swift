//
//  ContractDetailsInfoTVControllerDelegate.swift
//  mpges.lk
//
//  Created by Timur on 01.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
import UIKit

protocol ContractDetailsInfoTVControllerUserDelegate: AnyObject {
    var sections: [String?] { get }
    func setContractById(for contract: ResultModel<ContractModel>)
    func getContractById(id: Int)
    func getStatePayment(for model: RequestOfPayModel)
    func setContractStatus(for model: ResultModel<ContractStatusModel>)
}
