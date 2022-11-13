//
//  AppImage.swift
//  mpges.lk
//
//  Created by Timur on 23.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

// For delivery type
func getImage(_ id: Int) -> String {
    guard let type = deliveryType(rawValue: id) else { return AppImage.mail.rawValue }
    
    switch type {
    case deliveryType.address:
        return AppImage.mail.rawValue
    case deliveryType.email:
        return AppImage.at.rawValue
    case deliveryType.lk:
        return AppImage.network.rawValue
    case deliveryType.office:
        return AppImage.figureWalk.rawValue
    }
}

enum AppImage: String {
    case none = "none"
    case tag = "tag"
    case link = "link"
    case mail = "mail"
    case envelope = "envelope"
    case rub = "rublesign.circle"
    case rubSquare = "rublesign.square"
    case calc = "text.justify"
    case person = "person"
    case calendar = "calendar"
    case phone = "phone"
    case paperplane = "paperplane"
    case creditcard = "creditcard"
    case power = "power"
    case save = "checkmark.seal"
    case edit = "pencil.and.ellipsis.rectangle"
    case docText = "doc.text"
    case textPlus = "text.badge.plus"
    case textMinus = "text.badge.minus"
    case device = "device-icon"
    case receivedData = "doc.plaintext"
    case sendDoc = "arrow.up.doc"
    case printer = "printer"
    case dollar = "dollarsign.circle"
    case lock = "lock"
    case lockOpen = "lock.open"
    case trayUp = "tray.and.arrow.up"
    case close = "multiply.circle.fill"
    case plus = "plus.circle.fill"
    case dote = "ellipsis"
    case shared = "square.and.arrow.up"
    case deleted = "trash"
    case docCopy = "doc.on.doc"
    case gauge = "gauge"
    case xmark = "xmark.circle.fill"
    case checkmark = "checkmark.circle.fill"
    case sberLogo = "sberLogo"
    case appleLogo = "applelogo"
    case sberIcon = "sberIcon"
    case markLogo = "placeMark"
    case at = "at"
    case network = "network"
    case figureWalk = "figure.walk"
    case ligthOn = "flashlight.on.fill"
    case ligthOff = "flashlight.off.fill"
}
