//
//  AppDelegate.swift
//  Prayer
//
//  Created by Apple on 2018/11/20.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    var jLibrary: JLibrary!
    var dataFileName = "JournalFile"
    var prophet_logic: ProphetLogic!
    var prophetFileName = "ProphetLogicFile"
    var pLibrary: PLibrary!
    var photoFileName = "PhotoFile"
    
    let defaults = UserDefaults.standard
    
    lazy var fileURL: URL = {
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDir.appendingPathComponent(dataFileName, isDirectory: false)
    }()
    
    lazy var fileURL1: URL = {
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDir.appendingPathComponent(prophetFileName, isDirectory: false)
    }()
    lazy var fileURL2: URL = {
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDir.appendingPathComponent(photoFileName, isDirectory: false)
    }()

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initDefaults()
        loadData()
        let tabBarController = window!.rootViewController as! UITabBarController
        let featureViewController = tabBarController.viewControllers![0] as? FeatureViewController
        featureViewController?.prophetLogic = prophet_logic
        let cameraViewController = tabBarController.viewControllers![1] as? CameraViewController
        cameraViewController?.plibrary = pLibrary
        let splitViewController = tabBarController.viewControllers![2] as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        let masterNavController = splitViewController.viewControllers.first as! UINavigationController
        if let masterViewController = masterNavController.topViewController as? MasterViewController {
            masterViewController.objects = jLibrary
        }
        splitViewController.delegate = self
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        let numLaunches = defaults.integer(forKey: dNumLaunches) + 1
        defaults.set(numLaunches, forKey: dNumLaunches)
        let lastaccessday = Date()
        defaults.set(lastaccessday, forKey: dLastAccessDate)
        saveData()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        saveData()
    }

    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
    
    func saveData() {
        NSKeyedArchiver.archiveRootObject(jLibrary, toFile: fileURL.path)
        NSKeyedArchiver.archiveRootObject(prophet_logic, toFile: fileURL1.path)
        NSKeyedArchiver.archiveRootObject(pLibrary, toFile: fileURL2.path)
    }
    
   
    func loadData() {
        if let jns = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path) as? JLibrary {
            jLibrary = jns
        } else {
            jLibrary = JLibrary()
        }
        if let pl = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL1.path) as? ProphetLogic {
            prophet_logic = pl
        } else {
            prophet_logic = ProphetLogic()
            prophet_logic.tilesArray = [ProphetTile]()
            prophet_logic.initGame()
        }
        if let ph = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL2.path) as? PLibrary {
            pLibrary = ph
        } else {
            pLibrary = PLibrary()
        }
    }
    func initDefaults() {
        if let path = Bundle.main.path(forResource: "Defaults", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path) {
            defaults.register(defaults: dictionary as! [String : Any])
            defaults.synchronize()
        }
    }
}

