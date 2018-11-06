//
//  ViewController.swift
//  StarWarsAPIChallenge
//
//  Created by Fleischauer, Joseph on 10/25/18.
//  Copyright © 2018 Fleischauer, Joseph. All rights reserved.
//

import UIKit

//struct PeopleDescription: Decodable {
//    let count: Int
//    let results: [People]
//}

struct People: Decodable {
    let name: String
    let height: String
    let mass: String
    let gender: String
    let hair_color: String
//    let homeworld: String?
    let eye_color: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var characterLabel: UILabel!

    var name = String()
    var height = String()
    var mass = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onFindButtonTapped(_ sender: UIButton) {
        let randomNumber = Int(arc4random_uniform(88))
        parse(number: randomNumber)
    }
    
    func parse(number: Int) {
        let jsonUrlString = "https://swapi.co/api/people/\(number)/"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let people = try JSONDecoder().decode(People.self, from: data)
                let character = people.name
                let height = people.height
                let weight = people.mass
                let gender = people.gender
                let hairColor = people.hair_color
                let eyeColor = people.eye_color
                self.displayInfo(characterName: character, characterHeight: height, characterWeight: weight, characterGender: gender, characterHair: hairColor, characterEyeColor: eyeColor)
                print("name: \(character)\nheight: \(height)\nweight: \(weight)")
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }

    func displayInfo(characterName: String, characterHeight: String, characterWeight: String, characterGender: String, characterHair: String, characterEyeColor: String) {
        DispatchQueue.main.async {
            self.characterLabel.text = "Name: \(characterName)\nHeight: \(characterHeight)\nWeight: \(characterWeight)\nGender: \(characterGender)\nHair Color: \(characterHair)\nEye Color: \(characterEyeColor)"
        }
    }
    
}

