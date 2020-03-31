//
//  ChristianityView.swift
//  Prayer
//
//  Created by Apple on 2018/11/22.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import UIKit

protocol ChristianityViewDelegate: class {
    func didShowHide(_ ChristianityView: ChristianityView, index: Int)
}
class ChristianityView: UIView {
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Image: UIImageView!
    weak var delegate: ChristianityViewDelegate?
    
    var index: Int!
   
    var imageMode: UIImage = UIImage() {
        didSet {
            Image.image = imageMode
        }
    }
    
    var title: String = "" {
        didSet {
            Label.text = title
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
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture))
        self.addGestureRecognizer(pinchGesture)
    }
    
    func animateShowHide() {
        UIView.animate(withDuration: 1, delay: 2, options: [.showHideTransitionViews], animations: {
            self.delegate?.didShowHide(self, index: self.index)
        })
    }
    
    @objc func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        animateShowHide()
    }
    
}
