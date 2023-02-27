//
//  ViewCats.swift
//  The Cats API
//
//  Created by Paul Frank Pacheco Carpio on 26/02/23.
//

import SwiftUI

struct ViewCats: View {
	
	@ObservedObject private var catViewModel: ViewModelCat
	@State private var isLoading: Bool = false
	
	init() {
		self.catViewModel = ViewModelCat()
	}
	
    var body: some View {
		NavigationStack {
			GeometryReader { geo in
				ScrollView(.vertical) {
					VStack {
						if catViewModel.cats.isEmpty {
							//show emptyState
							Text("There's no cats to play with :(")
						} else {
							ForEach(catViewModel.cats, id:\.breedName) { cat in
								CatCard(cat: cat, geo: geo)
									.frame(width: geo.size.width)
							}
						}
					}
				}
			}
			.navigationTitle("Catbreeds")
		}.onAppear {
			Task {
				isLoading.toggle()
				await catViewModel.getCats()
				isLoading.toggle()
			}
		}
    }
}

struct CatCard: View {
	var cat: Cat
	var geo: GeometryProxy
	var body: some View {
		VStack(alignment: .leading) {
			Text("\(cat.breedName)")
				.font(.title2)
				.fontWeight(.bold)
				.fontDesign(.rounded)
				.padding([.horizontal, .top], 8)
				if let imageCat = cat.imageUrl {
					AsyncImage(url: URL(string :"\(imageCat)")) { image in
						image
							.resizable()
							.scaledToFill()
							.frame(width: geo.size.width,height: 250)
							.clipped()
						
					} placeholder: {
						VStack {
							HStack {
								Spacer()
								ProgressView()
								Spacer()
							}
						}.frame(height: 250, alignment: .center)
					}
				} else {
					Image("cat-placeholder")
						.resizable()
						.scaledToFill()
						.frame(width: geo.size.width, height: 250)
						.clipped()
				}
				HStack{
					Text("Pais de origen: \(cat.origin)")
						.font(.title3)
						.fontDesign(.rounded)
					Spacer()
					Text("Inteligencia: \(cat.intelligence)")
						.font(.title3)
						.fontDesign(.rounded)
				}.padding([.horizontal, .bottom], 8)
			}
		.background(Color(uiColor: UIColor.secondarySystemBackground))
			.cornerRadius(12)
			.shadow(radius: 6)
			.padding(.all, 8)
	}
}

struct ViewCats_Previews: PreviewProvider {
    static var previews: some View {
		ViewCats()
		GeometryReader { geo in
			CatCard(cat: Cat(breedName: "PEDRO", origin: "PERU", affectionLevel: 3, intelligence: 3, imageUrl: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg"), geo: geo)
		}
    }
}
