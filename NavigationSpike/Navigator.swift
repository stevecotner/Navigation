//
//  Navigator.swift
//  NavigationSpike
//
//  Created by Stephen Cotner on 12/6/22.
//

import Foundation

class Navigator: ObservableObject {
    static var shared = Navigator()
    var path: [Screen]? = [.launch] {
        didSet {
            if path != nil {
                self.objectWillChange.send()
            }
        }
    }
    @Published var modal: Screen?
    var isShowingModal: Bool { modal != nil }
    var currentExitPolicy: (() -> Bool)?
    
    enum Screen: Equatable {
        case root
        case launch
        case landing
        case home
        case runList
        case runDetail(run: Run)
        
        func isSameScreenWithDifferentData(_ otherScreen: Screen) -> Bool {
            switch (self, otherScreen) {
            case (.root, .root):
                return true
                
            case (.launch, .launch):
                return true
                
            case (.landing, .landing):
                return true
                
            case (.home, .home):
                return true
                
            case (.runList, .runList):
                return true
                
            case (.runDetail, .runDetail):
                return true
                
            default:
                return false
            }
        }
    }
    
//    var hasDestination: Bool {
//        return path != nil
//    }
    
//    func destinationFromRoot() -> Screen? {
//        return path?.first
//    }
    
    func destination(from screen: Screen) -> Screen? {
        guard let path else { return nil }
        
        if screen == .root {
            return path.first
        } else if let index = path.firstIndex(of: screen) {
            if index + 1 < path.count {
                return path[index + 1]
            }
        }
        return nil
    }
    
    func lastDestination() -> Screen? {
        return path?.last
    }
    
    func show(_ screen: Screen) {
        // TODO: check if new path is same as old path plus a screen. If so, disregard exit policy.
        if currentExitPolicy?() == true || currentExitPolicy == nil {
            path = path(for: screen)
        }
    }
    
    func showModal(_ screen: Screen) {
        // show on top-level view as a sheet
    }
    
    private func path(for screen: Screen) -> [Screen] {
        switch screen {
        case .launch:
            return [.launch]
            
        case .home:
            return [.landing, .home]
            
        case .runList:
            return [.landing, .runList]
            
        case .runDetail(let run):
            return [.landing, .runList, .runDetail(run: run)]
            
//        case .extraRunDetails(let run):
//            return path(for: .runDetail(run: run) + [.extraRunDetails(details: ...)]
            
        default:
            return []
        }
    }
    
    func didNavigate(
        to screen: Screen,
        exitPolicy: (() -> Bool)? = nil,
        nextScreenBlock: @escaping (Screen?) -> Void,
        resetScreenBlock: @escaping (Screen) -> Void
    ) {
        print("didNavigate: \(screen)")
        if path?.last == screen {
            // We've arrived at our destination screen
            print("last: \(screen)")
            currentExitPolicy = exitPolicy
            nextScreenBlock(nil)
            path = nil
        } else if let last = path?.last, last.isSameScreenWithDifferentData(screen) == true {
            // We've arrived at our destination screen but we have different data now.
            // We need to reset it with our new data
            print("same screen different data")
            self.currentExitPolicy = exitPolicy
            resetScreenBlock(last)
            self.path = nil
        } else if let next = destination(from: screen) {
            print("not last: \(screen)")
            nextScreenBlock(next)
        } else {
            // Nothing to do from here.
            print("Nothing to do from here: \(screen)")
        }
    }
}
