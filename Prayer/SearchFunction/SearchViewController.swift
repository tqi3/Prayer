//
//  ViewController.swift
//  Prayer
//
//  Created by Apple on 2018/11/30.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var TView: UITableView!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBAction func searchButton(_ sender: UIButton) {
        if searchField.text != "" {
            loadRequest()
        }
    }
    
    
    var sHelper = searchBibleHelper()
    var currentResult: [SearchResult]? {
        didSet {
        OperationQueue.main.addOperation() {
           self.TView.reloadData()
        }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for state: UIControlState in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
            searchButton.setTitle(NSLocalizedString("str_go", comment: ""), for: state)
        }
        TView.delegate = self
        TView.dataSource = self
        searchField.delegate = self
        searchField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadRequest() {
        if let searchString = searchField.text {
            sHelper.fetchVerses(searchText: searchString) { result in
                switch result {
                case let .Success(resultArray):
                    self.currentResult = resultArray
                case let .Failure(error):
                     self.currentResult = []
                    print("Error: \(error)")
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let oneSection =  currentResult {
            return oneSection.count
        }
        return 0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RC", for: indexPath) as! ResultCell
        if let oneResult = currentResult?[indexPath.row] {
            cell.Book?.text = oneResult.book_name
            cell.Chapter?.text = oneResult.chapter_id
            cell.VerseNum?.text = oneResult.verse_id
            cell.VerseText?.text = oneResult.verse_text
        }
        return cell
    }
    
}
