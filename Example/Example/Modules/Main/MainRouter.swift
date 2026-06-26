//
//  MainRouter.swift
//  Example
//
//  Created by Daniel Hernandez on 26/06/2026.
//

import Foundation
import UIKit
import RswiftResources

class MainRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView: UIViewController?
    
    private func createViewController() -> UIViewController {
        let view = R.storyboard.main.mainView()!
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
}
