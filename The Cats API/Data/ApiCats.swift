//
//  ApiCats.swift
//  The Cats API
//
//  Created by Paul Frank Pacheco Carpio on 26/02/23.
//

import Foundation

class ApiCats {
	
	enum ApiCatsError: Error {
		case invalidURL
		case missingData
	}
	
	let baseUrl = "https://api.thecatapi.com/v1"
	
	func fetchBreeds() async throws -> [CatBreed] {
		guard let url = URL(string: "\(baseUrl)/breeds") else {
			throw ApiCatsError.invalidURL
		}
		let (data, _) = try await URLSession.shared.data(from: url)
		
		let result = try JSONDecoder().decode([CatBreed].self, from: data)
		print(result)
		return result
	
	}
	
}
