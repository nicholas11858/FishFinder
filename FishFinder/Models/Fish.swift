//
//  Fish.swift
//  FishFinder
//
//  Created by NIKOLAY OSIPOV on 21.06.2021.
//

struct Fish: Decodable {
    let speciesName: String?
    let population: String?
    let physicalDescription: String?
    let imageGallery: [FishImage]?

    private enum CodingKeys : String, CodingKey {
        case speciesName = "Species Name"
        case population = "Population"
        case imageGallery = "Image Gallery"
        case physicalDescription = "Physical Description"
    }
}



