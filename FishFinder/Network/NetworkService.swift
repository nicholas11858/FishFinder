//
//  NetworkService.swift
//  FishFinder
//
//  Created by NIKOLAY OSIPOV on 21.06.2021.
//

import Foundation

class Manager {
    func getFish (jsonUrl: String, completion: @escaping (Result<[Fish], Error> ) -> Void) {
        
        guard let url = URL(string: jsonUrl) else { return }
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                }
                
                guard let data = data else { return }
                do {
                    let information = try JSONDecoder().decode([Fish].self, from: data)
                    completion(.success(information))
                } catch let jsonError{
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
    func getImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard  let url = URL(string: url) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            completion(.success(data))
        }.resume()
    }
}
