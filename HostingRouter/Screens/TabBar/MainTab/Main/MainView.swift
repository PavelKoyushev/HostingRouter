//
//  MainView.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 23.06.2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(1..<4) { _ in
                    Color.teal
                        .frame(height: 100)
                        .cornerRadius(20)
                }
                
                Button(action: {
                    viewModel.input.buttonTap.send()
                }) {
                    Capsule()
                        .fill(.blue)
                        .frame(width: 150, height: 50)
                        .overlay {
                            Text("Tap me!")
                                .foregroundColor(.white)
                        }
                }
                
                Button(action: {
                    viewModel.input.switchTab.send()
                }) {
                    Capsule()
                        .fill(.green)
                        .frame(width: 150, height: 50)
                        .overlay {
                            Text("Tap me!")
                                .foregroundColor(.white)
                        }
                }
            }
            .padding()
        }
        .navigationTitle("Main")
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(viewModel: MainViewModel())
//    }
//}
