//
//  DetailViewController.swift
//  Poke-App-Programmatically
//
//  Created by Burak Erden on 20.04.2023.
//

import UIKit
import SnapKit
import SDWebImage
import SDWebImageSVGCoder

class DetailViewController: UIViewController {
    
    //MARK: - Properties
    
    private let detailType: UILabel = {
        var label = UILabel()
        label.detailLabel(size: 20, color: .systemRed, alpha: 0.7, textAlign: .center)
        return label
    }()
    
    private let detailName: UILabel = {
        var label = UILabel()
        label.detailLabel(size: 20, color: .label, textAlign: .center)
        return label
    }()
    
    private let detailBackground: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.image = UIImage(named: "front")
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let detailImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.image = UIImage(named: "back")
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let detailAbilities: UILabel = {
        var label = UILabel()
        label.detailLabel(size: 20, color: .label, alpha: 0.7, textAlign: .left, numberoFLines: 0)
        return label
    }()
    
    private let detailHpLabel: UILabel = {
        var label = UILabel()
        label.detailLabel(size: 15, color: .systemRed, alpha: 0.7, textAlign: .left)
        return label
    }()
    
    private let detailAttackLabel: UILabel = {
        var label = UILabel()
        label.detailLabel(size: 15, color: .systemRed, alpha: 0.7, textAlign: .left)
        return label
    }()
    
    private let detailDefLabel: UILabel = {
        var label = UILabel()
        label.detailLabel(size: 15, color: .systemRed, alpha: 0.7, textAlign: .left)
        return label
    }()
    
    private let detailHp: UILabel = {
        var label = UILabel()
        label.detailLabel(size: 15, color: .systemGray, alpha: 0.7, textAlign: .left)
        return label
    }()
    
    private let detailAttack: UILabel = {
        var label = UILabel()
        label.detailLabel(size: 15, color: .systemGray, alpha: 0.7, textAlign: .left)
        return label
    }()
    
    private let detailDef: UILabel = {
        var label = UILabel()
        label.detailLabel(size: 15, color: .systemGray, alpha: 0.7, textAlign: .left)
        return label
    }()

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        view.backgroundColor = .white
    }
    
    //MARK: - Config
    
    func configUI() {
        view.addSubview(detailBackground)
        detailBackground.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        detailBackground.addSubview(detailName)
        detailName.snp.makeConstraints { make in
            make.top.equalTo(detailBackground).offset(36)
            make.leading.equalTo(detailBackground).offset(96)
            make.trailing.equalTo(detailBackground).offset(-132)
        }
        
        detailBackground.addSubview(detailType)
        detailType.snp.makeConstraints { make in
            make.centerY.equalTo(detailName)
            make.leading.equalTo(detailName.snp.trailing).offset(30)
            make.trailing.equalTo(detailBackground).offset(-24)
        }
        
        detailBackground.addSubview(detailImage)
        detailImage.snp.makeConstraints { make in
            make.top.equalTo(detailBackground).offset(76)
            make.leading.trailing.equalTo(detailBackground).inset(36)
            make.bottom.equalTo(detailBackground).offset(-368)
        }
        
        detailBackground.addSubview(detailAbilities)
        detailAbilities.snp.makeConstraints { make in
            make.top.equalTo(detailImage.snp.bottom).offset(48)
            make.leading.trailing.equalTo(detailBackground).inset(32)
        }
        
        let labelsStackView = UIStackView(arrangedSubviews: [detailHpLabel, detailAttackLabel, detailDefLabel])
        labelsStackView.distribution = .fillEqually
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 20
        
        let statsStackView = UIStackView(arrangedSubviews: [detailHp, detailAttack, detailDef])
        statsStackView.distribution = .fillEqually
        statsStackView.axis = .vertical
        statsStackView.spacing = 20
        
        let demoStack = UIStackView(arrangedSubviews: [labelsStackView, statsStackView])
        demoStack.distribution = .fillEqually
        demoStack.spacing = 32
        
        detailBackground.addSubview(demoStack)
        demoStack.snp.makeConstraints { make in
            make.leading.equalTo(detailBackground).offset(40)
            make.top.equalTo(detailBackground.snp.bottom).offset(-140)
        }
    }

}
