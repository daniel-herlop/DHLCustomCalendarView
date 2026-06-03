//
//  DHLCustomDecorationView.swift
//  DHLCustomDecorationView
//
//  Created by Daniel Hernandez on 3/5/26.
//

import Foundation
import UIKit

class DHLCustomDecorationView: UIView {
    
    init(width: CGFloat) {
        // 16 de alto es aproximadamente el maximo de espacio que permite el UICalendarView() para las decorations. Si se pone mas, se corta la vista por abajo.
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: 16))
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
    }
    
    func addCustomSubview(
        color: UIColor,
        height: CGFloat = 2,
        bottomSpacing: CGFloat = 0
    ) {
        let subview = UIView()
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.backgroundColor = color
        
        addSubview(subview)
        
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomSpacing),
            subview.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func addCustomSubviewAboveLastOne(
        color: UIColor,
        height: CGFloat = 2,
        bottomSpacing: CGFloat = 4
    ) {
        
        let lastSubview = self.subviews.last
        
        let subview = UIView()
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.backgroundColor = color
        
        addSubview(subview)
        
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor),
            subview.bottomAnchor.constraint(equalTo: lastSubview?.topAnchor ?? bottomAnchor, constant: -bottomSpacing), // Si no hay ninguna vista anterior, el spacing es respecto al bottom de la vista padre
            subview.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
