//
//  StepRecipeTableViewCell.swift
//  Coogle
//
//  Created by jh on 2022/11/18.
//

import UIKit
import RxSwift
import RxCocoa

class StepRecipeTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    static let cellId = "StepRecipeTableViewCell"
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stepLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.font = BaseFont.bold
        lbl.textColor = BaseColor.main
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "Step1"
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    let profileImageBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    
    private let bgImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "add_photo")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        img.tintColor = .systemGray3
        return img
    }()
    
    let profileImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
        img.layer.borderColor = BaseColor.border.cgColor
        img.layer.cornerRadius = 5
        img.layer.borderWidth = 1
        return img
    }()
    
    let placeHolderLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.placeholder
        lbl.font = BaseFont.normal
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "예) 소세지는 칼집을 낸 후 끓는물에 한번 데쳐주세요."
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    let decriptTv: BaseTv = {
        let tv = BaseTv()
        tv.textColor = BaseColor.main
        return tv
    }()
    
    let closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "closeBtn"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.border
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImage.image = nil
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
        cellView.addSubview(stepLbl)
        cellView.addSubview(bgImage)
        cellView.addSubview(profileImage)
        cellView.addSubview(profileImageBtn)
        cellView.addSubview(placeHolderLbl)
        cellView.addSubview(decriptTv)
        cellView.addSubview(closeBtn)
        cellView.addSubview(bottomLine)
        setConstraints()
    }
    
    private func setConstraints() {
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -0).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0).isActive = true
        
        stepLbl.heightAnchor.constraint(equalToConstant: 24).isActive = true
        stepLbl.leadingAnchor.constraint(equalTo: cellView.leadingAnchor,constant: 16).isActive = true
        stepLbl.topAnchor.constraint(equalTo: cellView.topAnchor,constant: 10).isActive = true
        
        profileImageBtn.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16).isActive = true
        profileImageBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageBtn.topAnchor.constraint(equalTo: stepLbl.bottomAnchor, constant: 10).isActive = true
        
        bgImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        bgImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        bgImage.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor, constant: 3).isActive = true
        bgImage.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor, constant: 4).isActive = true
        
        
        profileImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImage.topAnchor.constraint(equalTo: stepLbl.bottomAnchor, constant: 10).isActive = true
        
        decriptTv.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10).isActive = true
        decriptTv.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16).isActive = true
        decriptTv.topAnchor.constraint(equalTo: profileImage.topAnchor).isActive = true
        decriptTv.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor).isActive = true
        
        placeHolderLbl.leadingAnchor.constraint(equalTo: decriptTv.leadingAnchor, constant: 15).isActive = true
        placeHolderLbl.trailingAnchor.constraint(equalTo: decriptTv.trailingAnchor, constant: -10).isActive = true
        placeHolderLbl.topAnchor.constraint(equalTo: decriptTv.topAnchor, constant: 10).isActive = true
        
        profileImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -16).isActive = true
        
        closeBtn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        closeBtn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        closeBtn.centerYAnchor.constraint(equalTo: stepLbl.centerYAnchor).isActive = true
        closeBtn.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16)
            .isActive = true
        
        bottomLine.leadingAnchor.constraint(equalTo: cellView.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 0.6).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
    }
}
