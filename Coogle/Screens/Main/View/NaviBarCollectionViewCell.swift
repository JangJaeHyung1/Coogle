//
//  NaviBarCollectionViewCell.swift
//  Coogle
//
//  Created by jh on 2022/08/08.
//

import UIKit
import RxSwift
import RxCocoa

class NaviBarCollectionViewCell: UICollectionViewCell {
    var disposeBag = DisposeBag()
    
    override var isSelected: Bool {
      didSet {
        if isSelected {
            selectedUnderLineView.isHidden = false
            titleLbl.font = BaseFont.bold
            titleLbl.textColor = BaseColor.main
        } else {
            selectedUnderLineView.isHidden = true
            titleLbl.font = BaseFont.normal
            titleLbl.textColor = BaseColor.unSelected
        }
      }
    }
    
    static let cellId = "NaviBarCollectionViewCell"
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = BaseColor.unSelected
        lbl.font = BaseFont.normal
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = ""
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let selectedUnderLineView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.main
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        cellView.addSubview(titleLbl)
        cellView.addSubview(selectedUnderLineView)
        setConstraints()
    }
    
    private func setConstraints() {
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -0).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0).isActive = true
        
        titleLbl.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        titleLbl.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        
        selectedUnderLineView.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor).isActive = true
        selectedUnderLineView.trailingAnchor.constraint(equalTo: titleLbl.trailingAnchor).isActive = true
        selectedUnderLineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        selectedUnderLineView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
    }
}
