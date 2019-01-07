//
//  ViewController.swift
//  StarWarsAPIChallenge
//
//  Created by Fleischauer, Joseph on 10/25/18.
//  Copyright © 2018 Fleischauer, Joseph. All rights reserved.
//

import UIKit
import CommonCrypto

struct People: Codable {
    let results: [Results]
}

struct Results: Codable {
    let name: String
}

enum CodingKeys: String, CodingKey {
    case name
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var nameArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parse()
    }
    
    func parse() {
        let jsonUrlString = "https://swapi.co/api/people/" // /number is the endpoint for specific characters.
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let people = try? JSONDecoder().decode(People.self, from: data)
                let names = people!.results
                for name in names {
                    self.nameArray.append(name.name)
                }
                //                    print(self.nameArray) // prints all of the names
                DispatchQueue.main.async {
//type code to reload tableView data on next line //**********************************************************************************
                    
                }
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//type code to set NUMBER OF ROWS on next line//**********************************************************************************
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//type code to display what is in each row of the tableView on next 3 lines  //****************************************************************
        
        
        
    }
    
    
}



