//
//  LandingView.swift
//  NavigationSpike
//
//  Created by Stephen Cotner on 12/6/22.
//

import SwiftUI

struct LandingView: View { // , Navigable {
    @ObservedObject var navigator = Navigator.shared
    @State var tab: Tab = .home
    
    enum Tab {
        case home
        case runList
    }
    
    var body: some View {
        TabView(selection: $tab) {
            HomeView()
                .tag(Tab.home)
                .tabItem { Label("Home", systemImage: "house") }
            
            RunListView()
                .tag(Tab.runList)
                .tabItem { Label("Runs", systemImage: "figure.run") }
                
        }
//        .navigator(viewModel.navigate)
        .onAppear() {
            navigate()
        }
        .onChange(of: navigator.path) { _ in
            navigate()
        }
    }
    
    func navigate() {
        navigator.didNavigate(
            to: .landing,
            nextScreenBlock: { next in
                switch next {
                case .home:
                    tab = .home
                case .runList:
                    tab = .runList
                default:
                    break
                }
            },
            resetScreenBlock: { _ in }
        )
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
