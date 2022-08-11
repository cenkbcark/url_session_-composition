//
//  Models.swift
//  udemy_composition_api
//
//  Created by Cenk Bahadır Çark on 9.08.2022.
//

import Foundation

struct Filmler : Codable {
    
    var film_id : String?
    var film_ad : String?
    var film_yil : String?
    var film_resim : String?
    var kategori : Kategoriler?
    var yonetmen : Yonetmenler?
    
    
        
}
    
