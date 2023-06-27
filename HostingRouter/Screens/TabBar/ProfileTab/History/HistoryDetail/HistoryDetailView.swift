//
//  HistoryDetailView.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 25.06.2023.
//

import SwiftUI

struct HistoryDetailView: View {
    
    @StateObject var viewModel: HistoryDetailViewModel
    
    var body: some View {
        Text("Hello, HistoryDetailView!")
            .onTapGesture {
                viewModel.input.tap.send()
            }
    }
}

//struct HistoryDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryDetailView(viewModel: HistoryDetailViewModel())
//    }
//}
