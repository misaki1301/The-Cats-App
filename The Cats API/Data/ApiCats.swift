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
	let API_KEY = "bda53789-d59e-46cd-9bc4-2936630fde39"
	
	func fetchBreeds() async throws -> [CatBreed] {
		guard let url = URL(string: "\(baseUrl)/breeds") else {
			throw ApiCatsError.invalidURL
		}
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.setValue(API_KEY, forHTTPHeaderField: "x-api-key")
		let (data, _) = try await URLSession.shared.data(for: request)
		
		let result = try JSONDecoder().decode([CatBreed].self, from: data)
		return result
	
	}
	
}
