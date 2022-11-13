//
//  TipTableViewCell.swift
//  Coogle
//
//  Created by jh on 2022/10/24.
//

import UIKit
import RxSwift
import RxCocoa

class TipTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    static let cellId = "TipTableViewCell"
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = BaseFont.normal
        lbl.textColor = BaseColor.main
        lbl.isUserInteractionEnabled = true
        //    lbl.adjustsFontSizeToFitWidth = true
        //    lbl.minimumScaleFactor = 0.5
        return lbl
    }()
    
    private let accessoryImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "accessory_tip")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        img.layer.masksToBounds = true
        return img
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
        cellView.addSubview(textLbl)
        cellView.addSubview(accessoryImg)
        setConstraints()
    }
    
    private func setConstraints() {
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -0).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0).isActive = true
        
        textLbl.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 13).isActive = true
        textLbl.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -13).isActive = true
        textLbl.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20).isActive = true
        
        accessoryImg.widthAnchor.constraint(equalToConstant: 10).isActive = true
        accessoryImg.heightAnchor.constraint(equalToConstant: 22).isActive = true
        accessoryImg.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20).isActive = true
        accessoryImg.centerYAnchor.constraint(equalTo: textLbl.centerYAnchor).isActive = true
    }
    func configure(with presentable: String) {
        textLbl.text = "  " + presentable
        textLbl.textColor = BaseColor.main
        textLbl.font = BaseFont.normal
    }
}
