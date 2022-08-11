//
//  FilmDetayViewController.swift
//  udemy_composition_api
//
//  Created by Cenk Bahadır Çark on 9.08.2022.
//

import UIKit

class FilmDetayViewController: UIViewController {
    
    
    @IBOutlet weak var filmNameLabel: UILabel!
    @IBOutlet weak var filmImageView: UIImageView!
    @IBOutlet weak var filmYearLabel: UILabel!
    @IBOutlet weak var filmCategoryLabel: UILabel!
    @IBOutlet weak var filmDirectorLabel: UILabel!
    
    var film : Filmler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let f = film {
            
            if let url = URL(string: "http://kasimadalan.pe.hu/filmler/resimler/\(f.film_resim!)") {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        self.filmImageView.image = UIImage(data: data!)
                    }
                }
            }
            filmNameLabel.text =  f.film_ad
            filmYearLabel.text = f.film_yil
            filmCategoryLabel.text = f.kategori?.kategori_ad
            filmDirectorLabel.text = f.yonetmen?.yonetmen_ad
        }

        
    }

}
