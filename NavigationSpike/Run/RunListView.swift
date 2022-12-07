//
//  RunView.swift
//  NavigationSpike
//
//  Created by Stephen Cotner on 12/6/22.
//

import SwiftUI

struct RunListView: View {
    @ObservedObject var navigator = Navigator.shared
    @State var runDetail: Run?
    
    struct Configuration {
        let runs: [Run]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Text("Run List")
                
                let binding = Binding(
                    get: { runDetail != nil },
                    set: { newValue in
                        if newValue == false {
                            runDetail = nil
                        }
                    })
                
                NavigationLink(
                    isActive: binding,
                    destination: {
                        if let runDetail {
                            RunDetailView(run: runDetail)
                        }
                    },
                    label: { EmptyView() }
                )
            }
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
            to: .runList,
            nextScreenBlock: { next in
                switch next {
                case .runDetail(let run):
                    runDetail = run
                default:
                    runDetail = nil
                }
            },
            resetScreenBlock: {
                _ in
            }
        )
    }
}

struct RunListView_Previews: PreviewProvider {
    static var previews: some View {
        RunListView()
    }
}
