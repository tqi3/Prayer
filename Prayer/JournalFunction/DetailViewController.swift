//
//  DetailViewController.swift
//  Prayer
//
//  Created by Apple on 2018/11/20.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var JournalText: UITextView!
    @IBAction func dismissKeypad(_ sender: Any) {
        JournalText.resignFirstResponder()
    }
    
    var detailItem: JDocument? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem, let jtx = JournalText {
            jtx.text = detail.txtF
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        JournalText.delegate = self
        JournalText.becomeFirstResponder()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureView()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        detailItem?.txtF = textView.text
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(_ textView: UITextView, shouldChangeCharactersIn range: NSRange, replacementString string: String)
        -> Bool {
            if (textView.text) != nil {
            return true
        }
        return false
    }

    
}

