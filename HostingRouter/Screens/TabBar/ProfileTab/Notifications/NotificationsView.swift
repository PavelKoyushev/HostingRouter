//
//  NotificationsView.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 24.06.2023.
//

import SwiftUI

struct NotificationsView: View {
    
    @StateObject var viewModel: NotificationsViewModel
    
    var body: some View {
        content
    }
}

private extension NotificationsView {
    
    var content: some View {
        VStack {
            Text("Hello, NotificationsView!")
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView(viewModel: NotificationsViewModel())
    }
}
