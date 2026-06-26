//
//  MainViewModel.swift
//  Example
//
//  Created by Daniel Hernandez on 26/06/2026.
//

import Foundation

import Foundation

class MainViewModel {
    private weak var view: MainView?
    private var router: MainRouter?
    
    let decorationDates: [Date] = [
        Date(),
        Date().addingTimeInterval(-60*60*24),
        Date().addingTimeInterval(-60*60*24*3)
    ]
    
    func bind(view: MainView, router: MainRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
}
