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
    
    //MARK: - Flip Animation Enums
    
    private enum Side {
        case head
        case tail
    }
    
    //MARK: - Properties
    
    var model = DetailViewModel()
    var pokeDetailUrl = String()
    var pokeDetail: PokeDetail?
    var abilities = [String]()
    private var currentSide: Side = .head
    
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
    
    private let detailPokeFront: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.image = UIImage(named: "front")
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.isHidden = true
        return iv
    }()
    
    private let detailPokeBack: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.image = UIImage(named: "back")
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
        label.text = "hp"
        label.detailLabel(size: 15, color: .systemRed, alpha: 0.7, textAlign: .left)
        return label
    }()
    
    private let detailAttackLabel: UILabel = {
        var label = UILabel()
        label.text = "attack"
        label.detailLabel(size: 15, color: .systemRed, alpha: 0.7, textAlign: .left)
        return label
    }()
    
    private let detailDefLabel: UILabel = {
        var label = UILabel()
        label.text = "defence"
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
        bind(url: pokeDetailUrl)
        tapGesture()
        hiddenUIElements(true)
        
    }
    
    
    //MARK: - Get Data
    
    func bind(url: String) {
            self.model.getPokeDetail(url: url)
            self.model.pokeDetailData = {[weak self] value in
                guard let self = self else {return}
                self.pokeDetail = value
                for ability in value.abilities {
                    self.abilities.append((ability.ability?.name)!)
                }
                self.setupUI()
            }
    }
    
    //MARK: - Config
    
    func configUI() {
//        view.backgroundColor = .systemBackground
        
        view.addSubview(detailPokeFront)
        detailPokeFront.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)

        }
        
        view.addSubview(detailPokeBack)
        detailPokeBack.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        detailPokeFront.addSubview(detailName)
        detailName.snp.makeConstraints { make in
            make.top.equalTo(detailPokeFront).offset(36)
            make.leading.equalTo(detailPokeFront).offset(96)
            make.trailing.equalTo(detailPokeFront).offset(-132)
        }
        
        detailPokeFront.addSubview(detailType)
        detailType.snp.makeConstraints { make in
            make.centerY.equalTo(detailName)
            make.leading.equalTo(detailName.snp.trailing).offset(30)
            make.trailing.equalTo(detailPokeFront).offset(-24)
        }
        
        detailPokeFront.addSubview(detailImage)
        detailImage.snp.makeConstraints { make in
            make.top.equalTo(detailPokeFront).offset(76)
            make.leading.trailing.equalTo(detailPokeFront).inset(36)
            make.bottom.equalTo(detailPokeFront).offset(-368)
        }
        
        detailPokeFront.addSubview(detailAbilities)
        detailAbilities.snp.makeConstraints { make in
            make.top.equalTo(detailImage.snp.bottom).offset(48)
            make.leading.trailing.equalTo(detailPokeFront).inset(32)
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
        
        detailPokeFront.addSubview(demoStack)
        demoStack.snp.makeConstraints { make in
            make.leading.equalTo(detailPokeFront).offset(40)
            make.top.equalTo(detailPokeFront.snp.bottom).offset(-140)
        }
    }
    
    //MARK: - SetupUI
    
    func setupUI() {
        detailName.text = pokeDetail?.name.uppercased()
        detailAbilities.text = "Abilities: \n\(abilities.map { "• \($0)".capitalized }.joined(separator: "\n"))"
        detailType.text = pokeDetail?.types?[0].type?.name?.capitalized
        detailHp.text = String(pokeDetail?.stats?[0].baseStat ?? 0)
        detailAttack.text = String(pokeDetail?.stats?[1].baseStat ?? 0)
        detailDef.text = String(pokeDetail?.stats?[2].baseStat ?? 0)
        
        // Svg Image Download
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        if let url = pokeDetail?.sprite.other?.dreamWorld?.frontDefault {
            detailImage.sd_setImage(with: URL(string: url))
        }
    }
    
    func hiddenUIElements(_ status: Bool) {
        [detailType, detailName, detailImage, detailAbilities, detailHp, detailAttack, detailDef, detailHpLabel, detailAttackLabel, detailDefLabel].forEach { $0.isHidden = status }
    }
    
    // Tap Gesture for Flip Animation
    func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapContainer))
        view.addGestureRecognizer(tapGesture)
    }
    
    // Selector for Tap Gesture
    @objc func tapContainer() {
        switch currentSide {
        case .head:
            UIView.transition(from: detailPokeBack,
                              to: detailPokeFront,
                              duration: 1,
                              options: [.transitionFlipFromRight, .showHideTransitionViews],
                              completion: nil)
            currentSide = .tail
            hiddenUIElements(false)
        case .tail:
            UIView.transition(from: detailPokeFront,
                              to: detailPokeBack,
                              duration: 1,
                              options: [.transitionFlipFromLeft, .showHideTransitionViews],
                              completion: nil)
            currentSide = .head
            hiddenUIElements(true)
        }
    }

}
