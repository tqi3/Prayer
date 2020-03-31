//
//  JudaismView.swift
//  Prayer
//
//  Created by Apple on 2018/11/22.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import UIKit

protocol JudaismViewDelegate: class {
    func didDissolve(_ JudaismView: JudaismView, index: Int)
}


class JudaismView: UIView {
   
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Image: UIImageView!
    weak var delegate: JudaismViewDelegate?
    
    var index: Int!
    
    var title: String = "" {
        didSet {
            Label.text = title
        }
    }
    var imageMode: UIImage = UIImage() {
        didSet {
            Image.image = imageMode
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
    
    func animateDissolve() {
        UIView.animate(withDuration: 1, delay: 2, options: [.transitionCrossDissolve], animations: {
            self.delegate?.didDissolve(self, index: self.index)
        })
        
    }
    
    @objc func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        animateDissolve()
    }
   
}
