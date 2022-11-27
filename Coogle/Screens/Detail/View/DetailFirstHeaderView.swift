//
//  FirstHeaderView.swift
//  Coogle
//
//  Created by jh on 2022/11/27.
//

import UIKit

class DetailFirstHeaderView : UIView {
    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewBottom = NSLayoutConstraint()
    private var containerView = UIView()
    private var containerViewHeight = NSLayoutConstraint()
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    private let imageBoardView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "imageBoardView")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFill
        //img.layer.masksToBounds = true
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(imageBoardView)
        
        setConstraints()
    }
    
    private func setConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        
        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewBottom.isActive = true
        
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHeight.isActive = true

        
        
//        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        imageBoardView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        imageBoardView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        imageBoardView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        imageBoardView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
    
    
}

