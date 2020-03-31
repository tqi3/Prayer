//
//  searchBibleHelper.swift
//  Prayer
//
//  Created by Apple on 2018/11/20.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import Foundation

enum SearchHelperResult {
    case Success([SearchResult])
    case Failure(Error)
}

class searchBibleHelper {
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private static func getResult(from data: Data) -> SearchHelperResult {
        do {
            var resultArray = [SearchResult]()
            let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [[[String : Any]]]
            for jdatum in jsonData[1] {
            let result = SearchResult(book_name: jdatum["book_name"] as? String,
                              chapter_id: jdatum["chapter_id"] as? String,
                              verse_id: jdatum["verse_id"] as? String,
                              verse_text: jdatum["verse_text"] as? String)
            resultArray.append(result)
            }
            return .Success(resultArray)
        } catch let error {
            return .Failure(error)
        }
    }
    
    func fetchVerses(searchText: String, completion: @escaping (SearchHelperResult) -> Void) {
        let searchTextModified = searchText.replacingOccurrences(of:" ", with: "+")
        let damID = NSLocalizedString("str_damID", comment: "")
           let urlString = "https://dbt.io/text/search?key=5ff43515c8ea9121f3e023064174d998&dam_id=\(damID)&query=\(searchTextModified)&limit=10&v=2"
            if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request) { (data, response, error) -> Void in
                guard let searchData = data else {
                    completion(.Failure(error!))
                    return
                }
                completion(searchBibleHelper.getResult(from: searchData))
            }
            task.resume()
        }else {
            completion(.Failure(URLError.badURL as! Error))
        }
    }
}



