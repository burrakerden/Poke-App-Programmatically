//
//  FeedCell.swift
//  Poke-App-Programmatically
//
//  Created by Burak Erden on 19.04.2023.
//

import UIKit
import SnapKit

class FeedCell: UICollectionViewCell {
    
    //MARK: - Properties
    
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
        iv.image = UIImage(systemName: "person")
        iv.backgroundColor = .black
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    private let pokeName: UILabel = {
        var label = UILabel()
        label.alpha = 0.7
        label.text = "pokeName"
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
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
