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
        content
    }
}

private extension MainView {
    
    var content: some View {
        ScrollView {
            VStack {
                list
                buttonOne
                buttonTwo
            }
            .padding()
        }
    }
    
    var list: some View {
        ForEach(1..<4) { _ in
            Color.teal
                .frame(height: 100)
                .cornerRadius(20)
        }
    }
    
    var buttonOne: some View {
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
    }
    
    var buttonTwo: some View {
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
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(viewModel: MainViewModel())
//    }
//}
