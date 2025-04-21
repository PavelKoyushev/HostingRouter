//
//  ProfileRouter.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 15.04.2025.
//

import Foundation

protocol ProfileRouter: AnyObject {
    
    func toAuth()
    func toHistory()
    func pushNotifications()
    func modalView()
    func presentPopUp()
    func presentModalCoordinator()
    
    func dismissModal()
}
