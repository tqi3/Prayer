//
//  FeatureViewController.swift
//  Prayer
//
//  Created by Apple on 2018/11/22.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import UIKit

class FeatureViewController: UIViewController, JudaismViewDelegate, ChristianityViewDelegate {
    
    func didShowHide(_ ChristianityView: ChristianityView, index: Int) {
       prophetLogic.tilesArray[index].touched = true
       update()
    }
    
    func didDissolve(_ JudaismView: JudaismView, index: Int) {
        prophetLogic.tilesArray[index].touched = true
        update()
    }
    
    var prophetLogic: ProphetLogic!
    
    @IBOutlet var jViews: [JudaismView]!
    @IBOutlet var cViews: [ChristianityView]!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for i in 0..<jViews.count {
            jViews[i].index = prophetLogic?.tilesArray[i].index
            jViews[i].delegate = self
        }
        for i in 0..<jViews.count {
            cViews[i].index = prophetLogic?.tilesArray[i + 4].index
            cViews[i].delegate = self
        }
        update()
    }
    
    func update() {
        for i in 0..<jViews.count {
            jViews[i].title = prophetLogic.labelName(for: i)!
            jViews[i].imageMode = prophetLogic.imageLike(for: i)!
        }
        for i in 0..<cViews.count {
            cViews[i].title = prophetLogic.labelName(for: i + 4)!
            cViews[i].imageMode = prophetLogic.imageLike(for: i + 4)!
        }
    }
    
    
    @IBAction func ResetFeature(_ sender: UIButton) {
        if prophetLogic.allTouched() {
            resetAlert(title: NSLocalizedString("str_rTitle", comment: ""), completion: { _ in
                self.prophetLogic.allTilesResetBack()
                self.update()
            })
        }else {
            notCoolAlert(title: NSLocalizedString("str_nTitle", comment: ""))
        }
    }
    
    func resetAlert(title: String, completion: @escaping (UIAlertAction) -> Void) {
        let alertMsg = NSLocalizedString("str_resetWarning_message", comment: "")
        let alert = UIAlertController(title: NSLocalizedString("str_resetWarning", comment: ""),
                                      message: alertMsg,
                                      preferredStyle: .actionSheet)
        
        let resetAction = UIAlertAction(title: NSLocalizedString("str_reset", comment: ""),
                                        style: .destructive, handler: completion)
        let cancelAction = UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""),
                                         style: .cancel, handler:nil)
        
        alert.addAction(cancelAction)
        alert.addAction(resetAction)
        
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        
        present(alert, animated: true, completion: nil)
    }
    
    func notCoolAlert(title: String) {
        
        let alertMsg = NSLocalizedString("str_notCoolWarning_message", comment: "")
        let alert = UIAlertController(title: NSLocalizedString("str_notCoolWarning", comment: ""),
                                      message: alertMsg,
                                      preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""),
                                         style: .cancel, handler:nil)
        
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
