//
//  EndCookingViewController.swift
//  Coogle
//
//  Created by jh on 2022/10/19.
//

import UIKit
import RxSwift
import RxCocoa

class EndCookingViewController: UIViewController {

    private let placeholder = "(선택) 자신이 직접 만들어 본 소세지 야채볶음, 해당 레시피가 마음에 들었나요?"
    private let disposeBag = DisposeBag()
    private var tableView: UITableView!
    var idx: Int = 0
    var rating = 2 {
        didSet {
//            print(rating)
        }
    }

    private let naviView: NaviBackUIView = {
        let view = NaviBackUIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.main
        lbl.font = BaseFont.title
        lbl.textAlignment = .center
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "소세지 야채 볶음"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    let reviewTextView: UITextView = {
        let tv = UITextView()
        tv.contentInset = .init(top: 5, left: 10, bottom: 10, right: 10)
        tv.layer.cornerRadius = 4
        tv.layer.borderWidth = 1
        tv.layer.borderColor = BaseColor.border.cgColor
        tv.font = BaseFont.normal
        tv.textColor = BaseColor.placeholder
        tv.addCharacterSpacing()
        tv.text = "(선택) 자신이 직접 만들어 본 소세지 야채볶음, 해당 레시피가 마음에 들었나요?"
        tv.backgroundColor = .clear
        tv.autocapitalizationType = .none
        tv.autocorrectionType = .no
        tv.smartDashesType = .no
        tv.smartQuotesType = .no
        tv.smartInsertDeleteType = .no
        tv.spellCheckingType = .no
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let tipLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.main
        lbl.font = BaseFont.menuTitle
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "🤔 요리 이후에 정리는 어떻게 할까요?"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    private let starImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "rating_on")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        //img.layer.masksToBounds = true
        return img
    }()
    
    private let nextBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("리뷰 완료", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = BaseFont.bold
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.backgroundColor = BaseColor.btnColor
        btn.layer.cornerRadius = 4
        return btn
    }()
    
    private lazy var starStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 4
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let progressBar: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 4
        slider.value = 2
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.thumbTintColor = .clear
        slider.minimumTrackTintColor = .clear
        slider.maximumTrackTintColor = .clear
        return slider
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUp()
        
        progressBar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sliderTapped(_:))))
        
        }

        @objc private func sliderTapped(_ tapRecognizer: UITapGestureRecognizer) {
            let location = tapRecognizer.location(in: progressBar)
            let step = progressBar.bounds.width/5
            let value = Int(location.x/step)
            progressBar.value = Float(Int(location.x/step))
            rating = value
            setStarSlider(value: rating)
        }
    
}

extension EndCookingViewController {
    private func setUp() {
        setTableView()
        setNavi()
        addViews()
        setConstraints()
        bind()
        fetch()
        hideTextFieldKeyboardWhenTappedBackground()
        starImageInit()
        setStarSlider()
    }
    
    private func starImageInit() {
        for i in 0..<5 {
            let img = UIImageView()
            img.image = UIImage(named: "rating_on")
            img.translatesAutoresizingMaskIntoConstraints = false
            img.isUserInteractionEnabled = true
            img.contentMode = .scaleAspectFit
            img.tag = i
            starStackView.addArrangedSubview(img)
        }
    }
    private func setStarSlider(value: Int = 2) {
        for index in 0..<5 {
            if let starImage = starStackView.viewWithTag(index) as? UIImageView {
                if index <= value {
                    starImage.image = UIImage(named: "rating_on")
                } else {
                    starImage.image = UIImage(named: "rating_off")
                }
            }
        }
    }

    private func setTableView(){
        tableView = UITableView()
        //        tableView = UITableView(frame: .zero, style: .plain)
                tableView.dataSource = self
        tableView.delegate = self
//        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .white
        tableView.alwaysBounceVertical = false
        //        tableView.register(CommunityHeaderView.self, forHeaderFooterViewReuseIdentifier: CommunityHeaderView.headerViewID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func fetch() {

    }


    private func bind() {
        
        
        progressBar.rx.value
            .subscribe(onNext:{ [unowned self] res in
                var value = Int(res)
                if res < 0.5 {
                    value = 0
                } else if res < 1.5 {
                    value = 1
                } else if res < 2.5 {
                    value = 2
                } else if res < 3.5 {
                    value = 3
                } else {
                    value = 4
                }
                setStarSlider(value: value)
                self.rating = value
                progressBar.value = Float(Int(rating))
            })
            .disposed(by: disposeBag)

        reviewTextView.rx.didBeginEditing
            .subscribe(onNext:{ [unowned self] res in
                if(self.reviewTextView.text == placeholder){
                    self.reviewTextView.text = nil
                    self.reviewTextView.textColor = BaseColor.main
                }
            })
            .disposed(by: disposeBag)
        
        reviewTextView.rx.didEndEditing
            .subscribe(onNext:{ [unowned self] res in
                if(self.reviewTextView.text == "" || self.reviewTextView.text == nil){
                    self.reviewTextView.text = placeholder
                    self.reviewTextView.textColor = BaseColor.placeholder
                }
            })
            .disposed(by: disposeBag)
        
        nextBtn.rx.tap
            .subscribe(onNext:{ [unowned self] res in
                self.backTwo(self.idx)
            })
            .disposed(by: disposeBag)
     
        naviView.backBtn.rx.tap
            .subscribe(onNext:{ [unowned self] _ in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    

    private func setNavi() {
        naviView.titleLbl.text = "리뷰 작성하기"
    }

    private func addViews() {

        view.addSubview(naviView)
        view.addSubview(titleLbl)
        view.addSubview(starStackView)
        view.addSubview(progressBar)
        view.addSubview(reviewTextView)
        view.addSubview(tipLbl)
        view.addSubview(tableView)
        view.addSubview(nextBtn)
    }

    private func setConstraints() {
        naviView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        naviView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        naviView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        naviView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        titleLbl.topAnchor.constraint(equalTo: naviView.bottomAnchor,constant: 44).isActive = true
        titleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 60).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -60).isActive = true
        
        starStackView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 20).isActive = true
        starStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        starStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        starStackView.widthAnchor.constraint(equalToConstant: 216).isActive = true
        
        progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: starStackView.centerYAnchor).isActive = true
        progressBar.widthAnchor.constraint(equalToConstant: 200).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 40).isActive = true

        reviewTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        reviewTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        reviewTextView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        reviewTextView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 96).isActive = true
        
        tipLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tipLbl.topAnchor.constraint(equalTo: reviewTextView.bottomAnchor, constant: 40).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: tipLbl.bottomAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        nextBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
        nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        nextBtn.heightAnchor.constraint(equalToConstant: 52).isActive = true
        nextBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45).isActive = true
    }
}

extension EndCookingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.font = BaseFont.normal
        if indexPath.row == 0 {
            cell.textLabel?.text = "  " + "양파 보관법"
        } else {
            cell.textLabel?.text = "  " + "파프리카 보관법"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = TipDetailViewController()
        self.navigationController?.pushViewController(
            nextVC, animated: true)
    }
}

extension EndCookingViewController {
    func backTwo(_ idx: Int) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
}
