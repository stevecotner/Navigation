//
//  HomeView.swift
//  NavigationSpike
//
//  Created by Stephen Cotner on 12/6/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var navigator = Navigator.shared
    
    var body: some View {
        ZStack {
            Text("Home")
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
            to: .home,
            nextScreenBlock: { _ in },
            resetScreenBlock: { _ in }
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
