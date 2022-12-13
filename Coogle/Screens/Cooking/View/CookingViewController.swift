//
//  CookingViewController.swift
//  Coogle
//
//  Created by jh on 2022/08/21.
//

import UIKit
import RxSwift
import RxCocoa

class CookingViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var idx: Int
    var limitPageNum: Int
    
    init(idx: Int, limit: Int){
        self.idx = idx
        self.limitPageNum = limit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "cookImage")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 4
        return img
    }()
    
    private let stepTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.main
        lbl.font = .systemFont(ofSize: 21, weight: .heavy)
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "STEP 01"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing(0.01)
        return lbl
    }()
    
    let stepNumLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.tint
        lbl.font = BaseFont.metroRgIt
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "1/8"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing(0.1)
        return lbl
    }()
    
    private let contentLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.main
        lbl.font = BaseFont.content
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .center
        lbl.text = "소세지와 야채는 잘라서\n준비해주세요"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    private let subLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.sub
        lbl.font = BaseFont.sub
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "다음 페이지로 넘어가려면 ‘다음’을 말해주세요\n※ 음성 인식이 되지 않는다면 ‘스와이프’를 해주세요"
        lbl.isUserInteractionEnabled = true
        lbl.textAlignment = .center
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUp()
        
        
        stepNumLbl.text = "\(idx + 1)/\(limitPageNum)"
        if idx < 9 {
            stepTitleLbl.text = "STEP 0\(idx + 1)"
        } else {
            stepTitleLbl.text = "STEP \(idx + 1)"
        }
        
    }
    
}

extension CookingViewController {
    private func setUp() {
        setNavi()
        addViews()
        setConstraints()
        bind()
        fetch()
        addGesture()
    }
    
    private func addGesture() {
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(CookingViewController.respondToSwipeGesture(_:)))
//        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
//        self.view.addGestureRecognizer(swipeLeft)
    }
    
//    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
//        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
//            switch swipeGesture.direction {
//            case UISwipeGestureRecognizer.Direction.left :
//                if idx != limitPageNum {
//                    let nextVC = CookingViewController(idx: self.idx + 1, limit: self.limitPageNum )
//                    nextVC.delegate = self
//                    self.inputNode?.removeTap(onBus: 0)
//                    self.audioEngine.stop()
//                    self.recognitionRequest?.endAudio()
//                    self.navigationController?.pushViewController(
//                        nextVC, animated: true)
//                }
//            default:
//                break
//            }
//        }
//    }
    
    private func fetch() {
        
    }
    
    private func bind() {
    }
    
    private func setNavi() {
    }
    
    private func addViews() {
        
        view.addSubview(imageView)
        view.addSubview(stepTitleLbl)
        view.addSubview(stepNumLbl)
        view.addSubview(subLbl)
        
        view.addSubview(contentView)
        contentView.addSubview(contentLbl)
    }
    
    private func setConstraints() {
        
        
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20 + 42).isActive = true
        
        stepTitleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        stepTitleLbl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        
        stepNumLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        stepNumLbl.centerYAnchor.constraint(equalTo: stepTitleLbl.centerYAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: stepNumLbl.bottomAnchor,constant: 0).isActive = true
        contentView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: subLbl.topAnchor, constant: -8).isActive = true
        
        contentLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        contentLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        contentLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        contentLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        contentLbl.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        contentLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        subLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subLbl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
        
        
    }
}
