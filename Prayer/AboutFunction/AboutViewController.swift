//
//  AboutViewController.swift
//  Prayer
//
//  Created by Apple on 2018/12/1.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import UIKit
let dNumLaunches                = "num_launches"
let dLastAccessDate             = "last_day_accessed"
class AboutViewController: UIViewController {
    
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appVersionLabel: UILabel!
    @IBOutlet weak var appBuildLabel: UILabel!
    @IBOutlet weak var appNumberLaunchesLabel: UILabel!
    @IBOutlet weak var appLastAccessDateLabel: UILabel!
    @IBOutlet weak var appCopyRightLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appNameLabel.text = NSLocalizedString("str_appName", comment: "") + Bundle.main.displayName!
        appVersionLabel.text = NSLocalizedString("str_appVersion", comment: "") + Bundle.main.version!
        appBuildLabel.text = NSLocalizedString("str_appBundle", comment: "") + Bundle.main.build!
        appCopyRightLabel.text = Bundle.main.copyright
        appNumberLaunchesLabel.text = NSLocalizedString("str_numberLaunches", comment: "") + defaults.integer(forKey: dNumLaunches).description
        var currentLocale = "en_US"
        if let deviceLocale = Locale.current.languageCode {
            if deviceLocale == "fr" {
                currentLocale = "fr_FR"
            }
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.locale = Locale(identifier: currentLocale)
        appLastAccessDateLabel.text = NSLocalizedString("str_lastAccessTime", comment: "") + formatter.string(from: (defaults.object(forKey: dLastAccessDate) as! Date))
        self.view.backgroundColor = UIColor.orange
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
