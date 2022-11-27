//
//  CustomTableFooterView.swift
//  Coogle
//
//  Created by jh on 2022/11/15.
//

import UIKit
import RxSwift
import RxCocoa

class IngredientsLastTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    static let cellId = "IngredientsLastTableViewCell"
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let addBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("+ 재료추가하기", for: .normal)
        btn.setTitleColor(BaseColor.sub, for: .normal)
        btn.titleLabel?.font = BaseFont.normal
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.isEnabled = false
        btn.layer.borderColor = BaseColor.border.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        //    btn.imageView?.contentMode = .scaleAspectFit
        return btn
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
        cellView.addSubview(addBtn)
        setConstraints()
    }
    
    private func setConstraints() {
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -0).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0).isActive = true
        
        addBtn.leadingAnchor.constraint(equalTo: cellView.leadingAnchor,constant: 16).isActive = true
        addBtn.trailingAnchor.constraint(equalTo: cellView.trailingAnchor,constant: -16).isActive = true
        addBtn.topAnchor.constraint(equalTo: cellView.topAnchor,constant: 20).isActive = true
        addBtn.bottomAnchor.constraint(equalTo: cellView.bottomAnchor,constant: -10).isActive = true
        addBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}

