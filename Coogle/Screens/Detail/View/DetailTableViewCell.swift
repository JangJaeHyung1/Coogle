//
//  DetailTableViewCell.swift
//  Coogle
//
//  Created by jh on 2022/08/18.
//


import UIKit
import RxSwift
import RxCocoa

class DetailTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    static let cellId = "DetailTableViewCell"
    
    let menuNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = BaseFont.normal
        lbl.textColor = BaseColor.main
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "menu"
        lbl.addCharacterSpacing()
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    let detailLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = BaseFont.normal
        lbl.textColor = BaseColor.main
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "detail"
        lbl.addCharacterSpacing()
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
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
        cellView.addSubview(menuNameLbl)
        cellView.addSubview(detailLbl)
        cellView.addSubview(lineView)
        setConstraints()
    }
    
    private func setConstraints() {
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0).isActive = true
        cellView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        menuNameLbl.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        menuNameLbl.leadingAnchor.constraint(equalTo: cellView.leadingAnchor).isActive = true
        
        detailLbl.centerYAnchor.constraint(equalTo: menuNameLbl.centerYAnchor).isActive = true
        detailLbl.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
        
        lineView.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        lineView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor,constant:  -3).isActive = true
        lineView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: 3).isActive = true
        lineView.topAnchor.constraint(equalTo: menuNameLbl.bottomAnchor, constant: 4).isActive = true
    }
}
