//
//  ViewController.swift
//  StarWarsAPIChallenge
//
//  Created by Fleischauer, Joseph on 10/25/18.
//  Copyright © 2018 Fleischauer, Joseph. All rights reserved.
//

import UIKit
import CommonCrypto

//struct PeopleDescription: Decodable {
//    let count: Int
//    let results: [People]
//

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
        //print(nameArray) //does not work here yet.
        
    }
    
    @IBAction func onFindButtonTapped(_ sender: UIButton) {
        //        let randomNumber = Int(arc4random_uniform(88))
        
    }
    
    func parse() {
        let jsonUrlString = "https://swapi.co/api/people/" // /number is the endpoint for specific characters.
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let people = try? JSONDecoder().decode(People.self, from: data)
                //                print(people.results)
                    let names = people!.results
                    //                print(names)
                    for name in names {
                        self.nameArray.append(name.name)
                    }
//                    print(self.nameArray) // prints all of the names
                DispatchQueue.main.async {
                     self.tableView.reloadData()
                }

            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            }.resume()
    }
    
    func nameInfo()  ->  [String] {
        DispatchQueue.main.async {
            self.nameArray.append(contentsOf: self.nameArray)
        }
        return nameArray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = nameArray[indexPath.row]
//        print(nameArray)
        return cell!
    }
    
    
}



