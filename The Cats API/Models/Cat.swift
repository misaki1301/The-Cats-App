//
//  Cat.swift
//  The Cats API
//
//  Created by Paul Frank Pacheco Carpio on 26/02/23.
//

import Foundation

struct Cat {
	var breedName: String
	var origin: String
	var affectionLevel: Int
	var intelligence: Int
	var imageUrl: String?
	
	static func getImageFromCode(codeImage: String?) -> String? {
		if let codeImage = codeImage {
			return "https://cdn2.thecatapi.com/images/\(codeImage).jpg"
		} else {
			return nil
		}
		
	}
}
