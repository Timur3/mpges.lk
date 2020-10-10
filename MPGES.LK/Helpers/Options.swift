//
//  Options.swift
//  mpges.lk
//
//  Created by Timur on 14.01.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
class Options {
    
    let baseUrl: String
    let versionApi: String
    let baseUrlInitPro: String
       
    init() {
        baseUrl = "https://webapi.mp-ges.ru/api/"
        versionApi = "1"
        baseUrlInitPro = "http://kassa.initpro.ru/lk/check-bill/"
        
    }
}
