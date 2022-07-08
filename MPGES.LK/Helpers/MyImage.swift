//
//  MyImage.swift
//  mpges.lk
//
//  Created by Timur on 23.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation

// For delivery type
func getImage(_ id: Int) -> String {
    guard let type = deliveryType(rawValue: id) else { return myImage.mail.rawValue }
    
    switch type {
    case deliveryType.address:
        return "mail"
    case deliveryType.email:
        return "at"
    case deliveryType.lk:
        return "network"
    case deliveryType.office:
        return "figure.walk"
    }
}

enum myImage: String {
    case none = "none"
    case tag = "tag"
    case link = "link"
    case mail = "envelope"
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
    case close = "multiply"
    case plus = "plus"
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
}
