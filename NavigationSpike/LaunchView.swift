//
//  LaunchView.swift
//  NavigationSpike
//
//  Created by Stephen Cotner on 12/6/22.
//

import SwiftUI

struct LaunchView: View {
    @ObservedObject var navigator = Navigator.shared
    
    var body: some View {
        VStack {
            Spacer()
            Text("Launch")
            Spacer()
        }
        .onAppear() {
            navigate()
        }
        .onChange(of: navigator.path) { _ in
            navigate()
        }
    }
    
    func navigate() {
        navigator.didNavigate(
            to: .launch,
            nextScreenBlock: { _ in },
            resetScreenBlock: { _ in }
        )
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
