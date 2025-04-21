//
//  CustomHostingController.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 13.04.2025.
//

import SwiftUI

final class CustomHostingController<Content: View>: UIHostingController<Content> {
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if isMovingFromParent {
            print("Screen removed from UINavigationController")
        }
    }
}
