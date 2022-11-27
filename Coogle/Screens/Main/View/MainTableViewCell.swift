//
//  MainTableViewCell.swift
//  Coogle
//
//  Created by jh on 2022/08/08.
//

import UIKit
import RxSwift
import RxCocoa

class MainTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    static let cellId = "MainTableViewCell"
    
    private let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.backgroundColor = .white
        return view
    }()
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private let postImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "testImage")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.main
        lbl.font = BaseFont.menuTitle
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "소세지 야채 볶음"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    private let starImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "rating_on")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        //img.layer.masksToBounds = true
        return img
    }()
    
    private let rateNumLbl: UILabel = {
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
    
    let bookmarkImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "bookmark")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    
    private let subTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.sub
        lbl.font = BaseFont.subTitle
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "간단한 밥반찬으로 딱 좋은 소세지 야채볶음!"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    private let difficultyBgView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.difficultyBg
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private let difficultyLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.btnColor
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
        shadowView.setShadow(radius: 4, opacity: 0.3, x: 0, y: 0)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        contentView.addSubview(shadowView)
        contentView.addSubview(cellView)
        cellView.addSubview(postImage)
        cellView.addSubview(titleLbl)
        cellView.addSubview(starImageView)
        cellView.addSubview(subTitleLbl)
        cellView.addSubview(rateNumLbl)
        cellView.addSubview(difficultyBgView)
        cellView.addSubview(bookmarkImg)
        difficultyBgView.addSubview(difficultyLbl)
        setConstraints()
    }
    
    private func setConstraints() {
        
        shadowView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor).isActive = true
        shadowView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
        shadowView.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
        
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        cellView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        
        postImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor).isActive = true
        postImage.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        postImage.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
        postImage.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        bookmarkImg.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10).isActive = true
        bookmarkImg.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        bookmarkImg.widthAnchor.constraint(equalToConstant: 24).isActive = true
        bookmarkImg.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        titleLbl.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16).isActive = true
        titleLbl.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 12).isActive = true
        
        subTitleLbl.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor).isActive = true
        subTitleLbl.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -16).isActive = true
        
        starImageView.leadingAnchor.constraint(equalTo: titleLbl.trailingAnchor, constant: 10).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        starImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        starImageView.bottomAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: -4).isActive = true
        
        rateNumLbl.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 5).isActive = true
        rateNumLbl.bottomAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: 2).isActive = true
        
        difficultyBgView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        difficultyBgView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        difficultyBgView.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 12).isActive = true
        difficultyBgView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16).isActive = true
        
        difficultyLbl.centerXAnchor.constraint(equalTo: difficultyBgView.centerXAnchor).isActive = true
        difficultyLbl.centerYAnchor.constraint(equalTo: difficultyBgView.centerYAnchor).isActive = true
        
    }
}
