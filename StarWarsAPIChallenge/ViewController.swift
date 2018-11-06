//
//  ViewController.swift
//  StarWarsAPIChallenge
//
//  Created by Fleischauer, Joseph on 10/25/18.
//  Copyright © 2018 Fleischauer, Joseph. All rights reserved.
//

import UIKit

struct PeopleDescription: Decodable {
    let count: Int
    let results: [People]
}

struct People: Decodable {
    let name: String
    let height: String
    let mass: String
    let gender: String
    let hair_color: String
//    let homeworld: String?
    let eye_color: String
}

extension String
{
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var characterTextField: UITextField!
    @IBOutlet weak var characterLabel: UILabel!

    var name = String()
    var height = String()
    var mass = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onFindButtonTapped(_ sender: UIButton) {
        guard let name = characterTextField.text else { return }
        let trimmedName = name.removingWhitespaces()
        parse(name: trimmedName)
    }
    
    func parse(name: String) {
        let jsonUrlString = "https://swapi.co/api/people/?search=\(name)"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let peopleDescription = try JSONDecoder().decode(PeopleDescription.self, from: data)
                let results = peopleDescription.results
                let result = results[0]
                let character = result.name
                let height = result.height
                let weight = result.mass
                let gender = result.gender
                let hairColor = result.hair_color
                let eyeColor = result.eye_color
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

