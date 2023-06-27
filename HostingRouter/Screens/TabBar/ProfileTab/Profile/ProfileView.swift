//
//  ProfileView.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 23.06.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        content
    }
}

private extension ProfileView {
    
    var content: some View {
        ScrollView {
            VStack(spacing: 16) {
                ZStack {
                    Color.pink
                        .frame(height: 100)
                        .cornerRadius(20)
                    Text("LogOut")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .onTapGesture {
                    viewModel.input.tap.send()
                }
                ZStack {
                    Color.green
                        .frame(height: 100)
                        .cornerRadius(20)
                    Text("HistoryOrders")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .onTapGesture {
                    viewModel.input.tapToScreen.send()
                }
                ZStack {
                    Color.blue
                        .frame(height: 100)
                        .cornerRadius(20)
                    Text("Notifications")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .onTapGesture {
                    viewModel.input.notyTap.send()
                }
                ZStack {
                    Color.teal
                        .frame(height: 100)
                        .cornerRadius(20)
                    Text("ModalView")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .onTapGesture {
                    viewModel.input.presentModal.send()
                }
                ZStack {
                    Color.teal
                        .frame(height: 100)
                        .cornerRadius(20)
                    Text("ModalView2")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .onTapGesture {
                    viewModel.input.presentPopUp.send()
                }
            }
            .padding()
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(viewModel: SecondViewModel())
//    }
//}
