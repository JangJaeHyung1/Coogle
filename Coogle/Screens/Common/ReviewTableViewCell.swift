//
//  ReviewTableViewCell.swift
//  Coogle
//
//  Created by jh on 2022/08/31.
//

import UIKit
import RxSwift
import RxCocoa

class ReviewTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    static let cellId = "ReviewTableViewCell"
    
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nickNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = BaseColor.sub
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "독산동 칼잡이"
        lbl.isUserInteractionEnabled = true
        lbl.font = BaseFont.bold
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    let deleteBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("삭제", for: .normal)
        btn.setTitleColor(BaseColor.tabbarTintColor, for: .normal)
        btn.backgroundColor = BaseColor.difficultyBg
        btn.titleLabel?.font = BaseFont.difficulty
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.layer.cornerRadius = 10
        btn.titleLabel?.addCharacterSpacing()
        btn.isHidden = true
        return btn
    }()
    
    let starImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "starFive")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        //img.layer.masksToBounds = true
        return img
    }()
    
    let dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.sub
        lbl.font = BaseFont.sub
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "2022-08-21"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    let cmtLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.main
        lbl.font = BaseFont.normal
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "만들어 봤는데 괜찮은 레시피인거 같습니다."
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.progressBarBg
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
        disposeBag = DisposeBag()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        contentView.addSubview(cellView)
        cellView.addSubview(nickNameLbl)
        cellView.addSubview(starImage)
        cellView.addSubview(dateLbl)
        cellView.addSubview(cmtLbl)
        cellView.addSubview(deleteBtn)
        cellView.addSubview(bottomLine)
        setConstraints()
    }
    
    private func setConstraints() {
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -0).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0).isActive = true
        
        nickNameLbl.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        nickNameLbl.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20).isActive = true
        nickNameLbl.heightAnchor.constraint(equalToConstant: 22).isActive = true
        nickNameLbl.trailingAnchor.constraint(equalTo: deleteBtn.leadingAnchor, constant: -10).isActive = true
        
        deleteBtn.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20).isActive = true
        deleteBtn.widthAnchor.constraint(equalToConstant: 48).isActive = true
        deleteBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        deleteBtn.centerYAnchor.constraint(equalTo: nickNameLbl.centerYAnchor).isActive = true
        
        starImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        starImage.heightAnchor.constraint(equalToConstant: 14).isActive = true
        starImage.leadingAnchor.constraint(equalTo: nickNameLbl.leadingAnchor).isActive = true
        starImage.topAnchor.constraint(equalTo: nickNameLbl.bottomAnchor, constant: 4).isActive = true
        
        dateLbl.centerYAnchor.constraint(equalTo: starImage.centerYAnchor).isActive = true
        dateLbl.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20).isActive = true
        
        cmtLbl.leadingAnchor.constraint(equalTo: starImage.leadingAnchor).isActive = true
        cmtLbl.topAnchor.constraint(equalTo: starImage.bottomAnchor, constant: 20).isActive = true
        cmtLbl.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -30).isActive = true
        
        bottomLine.leadingAnchor.constraint(equalTo: cellView.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 0.6).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
    }
}
