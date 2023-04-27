//
//  CredentialProviderViewController.swift
//  mpges.lk
//
//  Created by Timur on 06.12.2022.
//  Copyright © 2022 ChalimovTimur. All rights reserved.
//

import Foundation
import AuthenticationServices

class CredentialProviderViewController: ASCredentialProviderViewController {
    func prepareCredentialList(for serviceIdentifiers: [ASCredentialServiceIdentifier]) {
   
    }
    
    override func provideCredentialWithoutUserInteraction(for credentialIdentity: ASPasswordCredentialIdentity) {
        let databaseIsUnlocked = true
        if (databaseIsUnlocked) {
            let passwordCredential = ASPasswordCredential(user: "j_appleseed", password: "apple1234")
            self.extensionContext.completeRequest(withSelectedCredential: passwordCredential, completionHandler: nil)
        } else {
            self.extensionContext.cancelRequest(withError: NSError(domain: ASExtensionErrorDomain, code:ASExtensionError.userInteractionRequired.rawValue))
        }
    }

    override func prepareInterfaceToProvideCredential(for credentialIdentity: ASPasswordCredentialIdentity) {
    }

    @IBAction func cancel(_ sender: AnyObject?) {
        self.extensionContext.cancelRequest(withError: NSError(domain: ASExtensionErrorDomain, code: ASExtensionError.userCanceled.rawValue))
    }

    @IBAction func passwordSelected(_ sender: AnyObject?) {
        let passwordCredential = ASPasswordCredential(user: "j_appleseed", password: "apple1234")
        self.extensionContext.completeRequest(withSelectedCredential: passwordCredential, completionHandler: nil)
    }
}

class ASCredentialServiceIdentifier: NSObject {

    enum IdentifierType {
        case domain
        case URL
    }
    
    var identifier: String?
    var type: ASCredentialServiceIdentifier.IdentifierType?
}

/*class ASPasswordCredential: NSObject {
    var user: String
    var password: String
    
    init(user: String, password: String) {
        self.user = user
        self.password = password
    }
}*/
