//
//  FeedCell.swift
//  Poke-App-Programmatically
//
//  Created by Burak Erden on 19.04.2023.
//

import UIKit
import SnapKit
import SDWebImage
import SDWebImageSVGCoder

//MARK: - Protocols

protocol GestureProtocol {
    func turnTheImage()
}

class FeedCell: UICollectionViewCell {
        
    //MARK: - Properties
    
    let model = DetailViewModel()
    var pokeData: PokeDetail?
    var delegate: GestureProtocol?
    
    private let mainView: UIView = {
        var v = UIView()
        v.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 219/255, alpha: 1)
        return v
    }()
    
    private let pokeImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    private let pokeName: UILabel = {
        var label = UILabel()
        label.alpha = 0.7
        label.font = UIFont(name: "Rockwell-Bold", size: 17)
        label.backgroundColor = UIColor(red: 255/255, green: 24/255, blue: 24/255, alpha: 0.7)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    

    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        layer.masksToBounds = true
        
        addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        addSubview(pokeImage)
        pokeImage.snp.makeConstraints { make in
            make.top.equalTo(mainView)
            make.leading.trailing.equalTo(mainView).inset(16)
            make.bottom.equalTo(mainView).offset(-24)
        }
        
        mainView.addSubview(pokeName)
        pokeName.snp.makeConstraints { make in
            make.leading.trailing.equalTo(mainView)
            make.top.equalTo(pokeImage.snp_bottomMargin)
            make.bottom.equalTo(mainView)
        }
    doubleTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Config
    
    func cellConfig(url: String) {
        self.model.getPokeDetail(url: url)
        self.model.pokeDetailData = {[weak self] value in
            guard let self = self else {return}
            self.pokeData = value
                self.setupUI()
        }
    }
    
    func setupUI() {
        pokeName.text = pokeData?.name.capitalized
        DispatchQueue.main.async {
            if self.isSelected {
                if let url = self.pokeData?.sprite.frontDefault {
                    // Svg Image Download
                    SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
                    self.pokeImage.sd_setImage(with: URL(string: url))
                }
            } else {
                if let url = self.pokeData?.sprite.backDefault {
                    self.pokeImage.sd_setImage(with: URL(string: url))
                }
            }
        }
        isSelected = !isSelected
    }
    
    //MARK: - Double Tap Gesture
    
    func doubleTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(_:)))
        tapGesture.numberOfTapsRequired = 2
        pokeImage.addGestureRecognizer(tapGesture)
        pokeImage.isUserInteractionEnabled = true
        tapGesture.delaysTouchesBegan = true
    }
    
    @objc func didDoubleTap(_ gesture: UITapGestureRecognizer) {
        delegate?.turnTheImage()
        setupUI()
    }
    
}
