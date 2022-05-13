//
//  PaymentConfigurationFactory.swift
//  mpges.lk
//
//  Created by Timur on 06.05.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import Foundation
import TinkoffASDKCore
import TinkoffASDKUI

enum PaymentConfigurationFactory {
    
    static func makeViewConfiguration(viewTitle: String? = nil,
                                      infoFieldTitle: NSAttributedString? = nil,
                                      infoFieldAmount: NSAttributedString? = nil,
                                      detailsFieldTitle: NSAttributedString? = nil,
                                      localizableInfo: String = "ru") -> AcquiringViewConfiguration {
        
        let configration = AcquiringViewConfiguration()
         
        if let infoFieldTitle = infoFieldTitle,
           let infoFieldAmount = infoFieldAmount,
           let detailsFieldTitle = detailsFieldTitle {
            
            let infoFields = AcquiringViewConfiguration.InfoFields.self
            let infoFieldsAmount = infoFields.amount(title: infoFieldTitle, amount: infoFieldAmount)
            let infoFieldsDetail = infoFields.detail(title: detailsFieldTitle)
            
            configration.fields = [infoFieldsAmount, infoFieldsDetail]
        }

        configration.viewTitle = viewTitle
        configration.localizableInfo = AcquiringViewConfiguration.LocalizableInfo(lang: localizableInfo)

        return configration
    }
    
    static func makeApplePayViewConfiguration() -> AcquiringViewConfiguration {
        AcquiringViewConfiguration()
    }
    
    static func makeApplePayConfiguration() -> AcquiringUISDK.ApplePayConfiguration {
        
        var configuration = AcquiringUISDK.ApplePayConfiguration()
        configuration.merchantIdentifier = AppConfig.shared.merchantID
        
        return configuration
    }
}
