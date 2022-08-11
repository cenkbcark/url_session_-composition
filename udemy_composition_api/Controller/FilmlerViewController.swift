//
//  FilmlerViewController.swift
//  udemy_composition_api
//
//  Created by Cenk Bahadır Çark on 9.08.2022.
//

import UIKit

class FilmlerViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var filmListesi = [Filmler]()
    var kategori : Kategoriler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        if let k = kategori {
            
            if let kid = Int(k.kategori_id!){
                navigationItem.title = k.kategori_ad
                moviesByCategoryID(kategori_id:kid)
            }
            
        }
        
        
        

        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        let gidilecekVC = segue.destination as! FilmDetayViewController
        gidilecekVC.film = filmListesi[indeks!]
        
    }
    
    func moviesByCategoryID(kategori_id:Int){
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/filmler/filmler_by_kategori_id.php")!)
        
        request.httpMethod = "POST"
        
        let postString = "kategori_id=\(kategori_id)"
        
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request){ data,response,error in
            
            if error != nil || data == nil{
                print("Error")
                return
            }
            
            do{
                
                let cevap = try JSONDecoder().decode(MovieResponse.self, from: data!)
                
                if let gelenFilmListesi = cevap.filmler {
                    self.filmListesi = gelenFilmListesi
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }catch{
                print(error.localizedDescription)
                
            }
        }.resume()
    }
}

extension FilmlerViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let film = filmListesi[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FilmlerCollectionViewCell
        
        if let url = URL(string: "http://kasimadalan.pe.hu/filmler/resimler/\(film.film_resim!)") {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.filmImageView.image = UIImage(data: data!)
                }
            }
        }
        
        
        cell.filmImageView.image = UIImage(named: film.film_resim!)
        cell.filmNameLabel.text = film.film_ad
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
}
