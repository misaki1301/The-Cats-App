//
//  ViewModelCat.swift
//  The Cats API
//
//  Created by Paul Frank Pacheco Carpio on 26/02/23.
//

import Foundation
import Combine

@MainActor
class ViewModelCat: ObservableObject {
	
	@Published var cats: [Cat] = []
	
	func getCats() async {
		do {
			let apiData = try await ApiCats().fetchBreeds()
			
			for cat in apiData {
				cats.append(Cat(breedName: cat.name, origin: cat.origin, affectionLevel: cat.affectionLevel, intelligence: cat.intelligence, imageUrl: Cat.getImageFromCode(codeImage: cat.referenceImageID)))
			}
		} catch {
			print("Cant map Data \(error)")
		}
	}
}
