//
//  RunDetail.swift
//  NavigationSpike
//
//  Created by Stephen Cotner on 12/6/22.
//

import SwiftUI

struct RunDetailView: View {
    @ObservedObject var navigator = Navigator.shared
    
//    enum InitialState {
//        case minimumData(MinimumData)
//        case fullData(...)
//    }
    @State var run: Run
    @State var isExitAllowed: Bool = true
    
    var body: some View {
        ZStack {
            VStack {
                Text("Run Detail")
                Text("Distance: \(run.distance)")
                Text("Start: \(run.start)")
                Text("End: \(run.end)")
                
                switch isExitAllowed {
                case true:
                    Text("This screen currently allows the navigator to exit.")
                    Button(action: { isExitAllowed = false }, label: { Text("Disallow Exit") })
                case false:
                    Text("This screen currently does not allow the navigator to exit.")
                    Button(action: { isExitAllowed = true }, label: { Text("Allow Exit") })
                }
            }
        }
        .onAppear() {
            navigate()
//            doDataStuff()
        }
        .onChange(of: navigator.path) { _ in
            navigate()
        }
    }
    
    func navigate() {
        print("navigate to detail")
        navigator.didNavigate(
            to: .runDetail(run: run),
            exitPolicy: exitPolicy,
            nextScreenBlock: { _ in },
            resetScreenBlock: { screen in
                switch screen {
                case .runDetail(let run):
                    print("should change run: \(run)")
                    self.run = run
                default:
                    break
                }
            }
        )
    }
    
    func exitPolicy() -> Bool {
        return isExitAllowed
    }
}

struct RunDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RunDetailView(run: Run(distance: 1, start: .now, end: .now))
    }
}
