//
//  ContentView.swift
//  NavigationSpike
//
//  Created by Stephen Cotner on 12/6/22.
//

import SwiftUI

struct ContentView: View {
    @State var root: RootScreen? = .launch
    
    enum RootScreen {
        case launch
        case landing
    }
    
    @ObservedObject var navigator = Navigator.shared
    
    var body: some View {
        ZStack {
            switch root {
            case .launch:
                LaunchView()
                
            case .landing:
                LandingView()
                
            case .none:
                EmptyView()
            }
        }
        
        // TODO: top level modal for navigator
//        .sheet(
//            isPresented: $navigator.isShowingModal,
//            onDismiss: {},
//            content: <#T##() -> Content#>)
        
        .safeAreaInset(edge: .top, content: {
            VStack {
                Button {
                    navigator.show(.launch)
                } label: {
                    Text("Show Launch")
                }
                
                Button {
                    navigator.show(.home)
                } label: {
                    Text("Show Home")
                }
                
                Button {
                    navigator.show(.runList)
                } label: {
                    Text("Show Run List")
                }
                
                Button {
                    navigator.show(.runDetail(run: Run(distance: 1.0, start: .now.advanced(by: -10000), end: .now.advanced(by: -7000))))
                } label: {
                    Text("Show Run 1")
                }
                
                Button {
                    navigator.show(.runDetail(run: Run(distance: 5.0, start: .now.advanced(by: -3000), end: .now.advanced(by: -2000))))
                } label: {
                    Text("Show Run 2")
                }
            }
        })
        .onAppear {
            navigate()
        }
        .onChange(of: navigator.path) { path in
            navigate()
        }
    }
    
    func navigate() {
        navigator.didNavigate(
            to: .root,
            nextScreenBlock: { next in
                switch next {
                case .launch:
                    root = .launch
                case .landing:
                    root = .landing
                default:
                    break
                }
            },
            resetScreenBlock: { _ in }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
