//
//  ProfileTVControllerDelegate.swift
//  mpges.lk
//
//  Created by Timur on 15.02.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

import Foundation
protocol ProfileTVControllerDelegate {
    var sections: [String] { get }
    func setProfile(profile:UserModel)
}
