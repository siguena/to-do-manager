//
//  TaskColourPalette.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 2.03.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import UIKit

protocol ColourPaletteDelegate: class {
    func didSelectColour(_ color: UIColor)
}

class TaskColourPalette: UIStackView {
    
    private var colours: [String] = []
    private var viewHeight: CGFloat = 0
    
    weak var delegate: ColourPaletteDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        getColours()
        setupUI()
    }
    
    private func getColours(){
        let categoryData: [String] = PersistentStorageManager.shared.loadCategories().map({ $0.colour ?? Constants.colourFallBackColour })
        
        self.colours = categoryData
    }
    
    private func setupUI() {
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.spacing = 10
        viewHeight = self.frame.height
        
        for colour in colours {
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: viewHeight, height: viewHeight))
            btn.backgroundColor = UIColor(hexColor: colour)
            btn.addTarget(self, action: #selector(colourSelected), for: .touchUpInside)
            self.addArrangedSubview(btn)
        }
    }
    
    @objc func colourSelected(_ sender: UIButton) {
        delegate?.didSelectColour(sender.backgroundColor!)
    }
    
}
