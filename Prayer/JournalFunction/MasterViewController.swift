//
//  MasterViewController.swift
//  Prayer
//
//  Created by Apple on 2018/11/20.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects: JLibrary!{
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    @IBAction func toggleEdit(_ sender: Any) {
        setEditing(!isEditing, animated: true)
    }

    @IBAction func toggleAdd(_ sender: UIBarButtonItem) {
        addJournal(barButtonItem: sender)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func deletionAlert() {
        let alert = UIAlertController(title: NSLocalizedString("str_alertName", comment: ""),
                                      message: NSLocalizedString("str_deleteWarning", comment: ""),
                                      preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""),
                                         style: .cancel, handler:nil)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect =
            CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        present(alert, animated: true, completion: nil)
    }
    
        func addJournal(barButtonItem: UIBarButtonItem) {
        
        let alert = UIAlertController(
            title: NSLocalizedString("str_selectItemToAdd", comment: ""),
            message: nil,
            preferredStyle: .actionSheet)
        
        let addSorrowfulAction = UIAlertAction(title: NSLocalizedString("str_sorrowful", comment: ""), style: .default) { _ in
            let j = JDocument(title: "")
            self.objects?.addJournalBySection(j, .sorrowful)
            self.tableView.reloadData()
        }
        
        let addJoyfulAction = UIAlertAction(title: NSLocalizedString("str_joyful", comment: ""), style: .default) { _ in
            let j = JDocument(title: "")
            self.objects?.addJournalBySection(j, .joyful)
            self.tableView.reloadData()
        }
        
        let addLuminousAction = UIAlertAction(title: NSLocalizedString("str_luminous", comment: ""), style: .default) { _ in
            let j = JDocument(title: "")
            self.objects?.addJournalBySection(j, .luminous)
            self.tableView.reloadData()
        }
        
        let addGloriousAction = UIAlertAction(title: NSLocalizedString("str_glorious", comment: ""), style: .default) { _ in
            let j = JDocument(title: "")
            self.objects?.addJournalBySection(j, .glorious)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""), style: .cancel)
        
        alert.addAction(addSorrowfulAction)
        alert.addAction(addJoyfulAction)
        alert.addAction(addLuminousAction)
        alert.addAction(addGloriousAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.barButtonItem = barButtonItem
        
        
        self.present(alert, animated: true)
    }
    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = objects.sectionJournalsCollection[(JournalSection(rawValue: indexPath.section)?.rawValue)!][indexPath.row]
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return JournalSection.allValues.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableSection = JournalSection(rawValue: section), let oneSection =  objects?.sectionJournalsCollection[tableSection.rawValue] {
            return oneSection.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String? {
        return JournalSection(rawValue: section)?.name()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let tableSection = JournalSection(rawValue: indexPath.section) {
            if let journal = objects?.sectionJournalsCollection[tableSection.rawValue][indexPath.row] {
                cell.textLabel?.text = journal.title
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
                cell.detailTextLabel?.text = formatter.string(from: journal.date)
            }
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
            return (tableView.isEditing) ? .delete : .none
        }
        
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let tableSection = JournalSection(rawValue: indexPath.section) {
            if editingStyle == .delete {
                if objects.removeJournalBySection(at: indexPath.row, tableSection) == true {
                    deletionAlert()
                } else {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
            }
        }
    }
        
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section != proposedDestinationIndexPath.section {
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }
        
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if let tableSection = JournalSection(rawValue: sourceIndexPath.section) {
            objects.moveJournalBySection(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row, tableSection)
        }
    }
}
