//
//  OtpVerificationModel .swift
//  mpges.lk
//
//  Created by Timur on 21.11.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import Foundation

struct OtpVerificationModel: Encodable {
    let email: String
    let code: String
}

