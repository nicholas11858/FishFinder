//
//  AboutFishViewController.swift
//  FishFinder
//
//  Created by NIKOLAY OSIPOV on 24.06.2021.
//

import UIKit

class AboutFishViewController: UIViewController {
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var nameFishLabel: UILabel!
    @IBOutlet weak var fishImage: UIImageView!
    @IBOutlet weak var descriptionFishTextView: UITextView!
    // MARK: - Publuc Properties
    
    var fish: Fish? = nil
    var networkService = Manager()
    
    // MARK: - Life Cycles Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let fish = fish else { return }
        guard let description = fish.physicalDescription else { return }
        guard let image = fish.imageGallery?[0].src else { return }
        
        nameFishLabel.text = fish.speciesName
        let formatDescription = formatText(description: description)
        descriptionFishTextView.attributedText = formatDescription
        
        networkService.getImage(url: image) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.fishImage.image = UIImage(data: data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    // MARK: - Private Methods
    private func formatText(description: String) -> NSAttributedString? {
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        guard let  data =  NSString(string: description).data(using: String.Encoding.unicode.rawValue)
        else { return nil }
        
        do {
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return attributedString
        } catch let error {
            print(error)
            return nil
        }
    }
}
