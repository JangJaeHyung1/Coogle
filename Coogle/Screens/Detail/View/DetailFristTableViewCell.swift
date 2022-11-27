//
//  DetailFristTableViewCell.swift
//  Coogle
//
//  Created by jh on 2022/11/27.
//


import UIKit
import RxSwift
import RxCocoa

class DetailFristTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    static let cellId = "DetailFristTableViewCell"
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detailTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = BaseFont.detailTitle
        lbl.textColor = BaseColor.main
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "소세지 야채 볶음"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    let subTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = BaseFont.subTitle
        lbl.textColor = BaseColor.sub
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "간단한 밥반찬으로 딱 좋은 소세지 야채볶음!"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    let creatorNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.font = BaseFont.subBold
        lbl.textColor = BaseColor.sub
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "매콤왕 김매콤"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    
    let starImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "rating_on")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        //img.layer.masksToBounds = true
        return img
    }()
    
    let rateNumLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.sub
        lbl.font = BaseFont.metroBold
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "4.8"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    let difficultyBgView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.btnColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let difficultyLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = BaseFont.difficulty
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "쉬움"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        //        cellView.setShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        contentView.addSubview(cellView)
        cellView.addSubview(detailTitleLbl)
        cellView.addSubview(subTitleLbl)
        cellView.addSubview(creatorNameLbl)
        cellView.addSubview(starImageView)
        cellView.addSubview(difficultyBgView)
        difficultyBgView.addSubview(difficultyLbl)
        cellView.addSubview(rateNumLbl)
        setConstraints()
    }
    
    private func setConstraints() {
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -0).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0).isActive = true
        
        detailTitleLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        detailTitleLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        detailTitleLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        subTitleLbl.topAnchor.constraint(equalTo: detailTitleLbl.bottomAnchor, constant: 4).isActive = true
        subTitleLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        creatorNameLbl.topAnchor.constraint(equalTo: subTitleLbl.bottomAnchor, constant: 10).isActive = true
        creatorNameLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        creatorNameLbl.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        rateNumLbl.topAnchor.constraint(equalTo: creatorNameLbl.bottomAnchor,constant: 12)
            .isActive = true
        rateNumLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor,constant: 6 - 34).isActive = true
        
        starImageView.centerYAnchor.constraint(equalTo: rateNumLbl.centerYAnchor).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        starImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        starImageView.trailingAnchor.constraint(equalTo: rateNumLbl.leadingAnchor, constant: -5).isActive = true
        
        
        difficultyBgView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        difficultyBgView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        difficultyBgView.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor).isActive = true
        difficultyBgView.leadingAnchor.constraint(equalTo: rateNumLbl.trailingAnchor, constant: 20).isActive = true
        difficultyBgView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor,constant:  -20).isActive = true
        
        difficultyLbl.centerXAnchor.constraint(equalTo: difficultyBgView.centerXAnchor).isActive = true
        difficultyLbl.centerYAnchor.constraint(equalTo: difficultyBgView.centerYAnchor).isActive = true
        
        
        
    }
    func configure(with presentable: DetailRecipeFirstInfo) {
        detailTitleLbl.text = presentable.name
        subTitleLbl.text = presentable.descript
        creatorNameLbl.text = presentable.creator
        rateNumLbl.text = presentable.rate
        difficultyLbl.text = presentable.difficulty
    }
}

