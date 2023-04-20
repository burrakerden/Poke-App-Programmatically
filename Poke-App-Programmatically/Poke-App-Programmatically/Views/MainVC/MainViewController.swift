//
//  MainViewController.swift
//  Poke-App-Programmatically
//
//  Created by Burak Erden on 18.04.2023.
//

import UIKit
import SnapKit

let reuseIdentifier = "cell"

class MainViewController: UICollectionViewController {
    
    //MARK: - Properties
    
    var model = ViewModel()
    var pokeUrls = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindPokeName()
    }
    
    func setupUI() {
        // Collection View Setup
        collectionView.isUserInteractionEnabled = true
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        title = "Poke Poke"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .systemRed
        //        navigationController?.navigationBar.backgroundColor = UIColor(red: 197/255, green: 226/255, blue: 228/255, alpha: 1)
    }
    
    //MARK: - Get Data
    
    func bindPokeName() {
        model.getPokeData()
        self.model.pokeNamesData = {[weak self] value in
            guard let self = self else {return}
            if let value = value {
                for i in 0...value.count - 1 {
                    if let url = value[i].url {
                        self.pokeUrls.append(url)
                    }
                }
                self.collectionView.reloadData()
            }
        }
    }
}

//MARK: - UICollectionView DataSource

extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokeUrls.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        cell.cellConfig(url: pokeUrls[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionView Delegate FlowLayout  -- where we define size of cell

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width / 2) - 20
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) // Sağ ve solda 10 piksellik boşluk bırakın
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - MainViewController Extension

extension MainViewController: GestureProtocol {
    func turnTheImage() {
    }
}
