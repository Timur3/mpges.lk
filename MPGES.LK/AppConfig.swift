//
//  AppConfig.swift
//  mpges.lk
//
//  Created by Timur on 05.05.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import Foundation
import TinkoffASDKCore

final class AppConfig {
    
    static var shared = AppConfig()
    
    // MARK: - API
    
    let apiURLScheme = "https://"
    let apiHost = "api.mp-ges.ru"
    let orgName = "ООО \"ГЭС\""

    // MARK: - Payments
    /// Where to send the receipt notification (should not it nbe the user's email?)
    let paymentReceiptEmail = "asu@mp-ges.ru"

    /// Public key for encrypting card data (card number, validity period and secret code)
    let paymentPublicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAv5yse9ka3ZQE0feuGtemYv3IqOlLck8zHUM7lTr0za6lXTszRSXfUO7jMb+L5C7e2QNFs+7sIX2OQJ6a+HG8kr+jwJ4tS3cVsWtd9NXpsU40PE4MeNr5RqiNXjcDxA+L4OsEm/BlyFOEOh2epGyYUd5/iO3OiQFRNicomT2saQYAeqIwuELPs1XpLk9HLx5qPbm8fRrQhjeUD5TLO8b+4yCnObe8vy/BMUwBfq+ieWADIjwWCMp2KTpMGLz48qnaD9kdrYJ0iyHqzb2mkDhdIzkim24A3lWoYitJCBrrB2xM05sm9+OdCI1f7nPNJbl5URHobSwR94IRGT7CJcUjvwIDAQAB"
    
    /// A unique terminal identifier, issued to the seller by the bank for each store.
    let paymentTerminalKey = "1613652753664"
    let paymentTerminalKeyDEMO = "1613652753664DEMO"
    let terminalPassword = "le3vez05kv2m8o5f"
    
    /// Merchant identifier
    let merchantID = "merchant.com.oooges.lk"
    
    /// Lever to switch to real or fake price.
    /// Fake price uses for testing payment functionality in development environment.
    let shouldUseProductRealPrice = true
    
    /// Использовать AlertView системный или из Acquiring SDK
    let acquiringSDK = false
    
    /// Тип проверки при сохранеия карты
    let addCardChekType: PaymentCardCheckType = .no
}
