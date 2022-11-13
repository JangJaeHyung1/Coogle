//
//  DetailViewController.swift
//  Coogle
//
//  Created by jh on 2022/08/14.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    var isBookmark: Bool
    var canEdit: Bool
    
    private var tableView1: UITableView!
    private var tableView2: UITableView!
    private var tableView3: UITableView!
    
    private var tableViewConstraint: [NSLayoutConstraint] = []
    private var tableViewConstraint3: [NSLayoutConstraint] = []
    
    private let disposeBag = DisposeBag()
    private let menuArray1: [[String]] = [["비엔나소시지","200 g"],
                                          ["양파","1 개"],
                                          ["파프리카","1 개"],
                                          ["파프리카","1 개"]]
    
    private let menuArray2: [[String]] = [["간장","1 큰술"],["설탕","1 큰술"]]
    private let naviView: NaviBackUIView = {
        let view = NaviBackUIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let bookmarkBtn: UIButton = {
        let btn = UIButton()
//        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.setImage(UIImage(named: "bookmark_white"), for: .normal)
        btn.setImage(UIImage(named: "bookmark_onClick"), for: .selected)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        //    btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    private let settingBtn: UIButton = {
        let btn = UIButton()
//        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.setImage(UIImage(named: "setting_white"), for: .normal)
        btn.setImage(UIImage(named: "setting_onClick"), for: .selected)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        //    btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "testImage2")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFill
//        img.layer.masksToBounds = true
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
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let nextBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("요리 시작하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = BaseFont.bold
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.backgroundColor = BaseColor.btnColor
        btn.layer.cornerRadius = 4
        return btn
    }()
    
    private let detailTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = BaseFont.detailTitle
        lbl.textColor = BaseColor.main
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "소세지 야채 볶음"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    private let subTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = BaseFont.subTitle
        lbl.textColor = BaseColor.sub
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "간단한 밥반찬으로 딱 좋은 소세지 야채볶음!"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    private let creatorNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.font = BaseFont.subBold
        lbl.textColor = BaseColor.sub
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "매콤왕 김매콤"
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
    
    private let ingredientLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.main
        lbl.font = BaseFont.bold
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "메인 재료"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    private let ingredientSubLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.sub
        lbl.font = BaseFont.normal
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "1인분 기준"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    private let ingredientLbl2: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.main
        lbl.font = BaseFont.bold
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "조미료"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    private let difficultyBgView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.btnColor
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
        lbl.textColor = .white
        lbl.font = BaseFont.difficulty
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "쉬움"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    private let reviewNumLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = BaseFont.detailTitle
        lbl.textColor = BaseColor.btnColor
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "20개"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()

    private let reviewGuideLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = BaseFont.detailTitle
        lbl.textColor = BaseColor.main
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "의 리뷰가 있습니다"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    init(isBookmark: Bool, canEdit: Bool) {
        self.isBookmark = isBookmark
        self.canEdit = canEdit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.bookmarkBtn.isSelected = self.isBookmark
    }
    
    override func updateViewConstraints() {
        NSLayoutConstraint.deactivate(self.tableViewConstraint)
        self.tableViewConstraint = [
            tableView1.heightAnchor.constraint(equalToConstant: CGFloat(40 * menuArray1.count)),
            tableView2.heightAnchor.constraint(equalToConstant: CGFloat(40 * menuArray2.count))
        ]
        NSLayoutConstraint.activate(self.tableViewConstraint)
        super.updateViewConstraints()
    }
    
}

extension DetailViewController {
    private func setUp() {
        setTableView()
        setNavi()
        addViews()
        setConstraints()
        bind()
        fetch()
    }
    private func setTableView(){
        tableView1 = UITableView()
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView1.separatorStyle = .none
        tableView1.showsHorizontalScrollIndicator = false
        tableView1.showsVerticalScrollIndicator = false
        tableView1.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.cellId)
        tableView1.translatesAutoresizingMaskIntoConstraints = false
        tableView1.tag = 1
        tableView1.isScrollEnabled = false
        
        tableView2 = UITableView()
        tableView2.delegate = self
        tableView2.dataSource = self
        tableView2.separatorStyle = .none
        tableView2.showsHorizontalScrollIndicator = false
        tableView2.showsVerticalScrollIndicator = false
        tableView2.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.cellId)
        tableView2.translatesAutoresizingMaskIntoConstraints = false
        tableView2.tag = 2
        tableView2.isScrollEnabled = false
        
        tableView3 = UITableView()
        tableView3.delegate = self
        tableView3.dataSource = self
        tableView3.separatorStyle = .singleLine
        tableView3.showsHorizontalScrollIndicator = false
        tableView3.showsVerticalScrollIndicator = false
        tableView3.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.cellId)
        tableView3.translatesAutoresizingMaskIntoConstraints = false
        tableView3.tag = 3
        tableView3.isScrollEnabled = false
        
        tableView1.backgroundColor = .white
        tableView2.backgroundColor = .white
        tableView3.backgroundColor = .white
    }
    private func fetch() {
        
    }
    
    private func bind() {
        settingBtn.rx.tap
            .subscribe(onNext:{ [weak self] _ in
                guard let self = self else { return }
                //action sheet title 지정
                let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                //옵션 초기화
                
                let saveAction = UIAlertAction(title: "신고하기", style: .destructive, handler: {
                    (alert: UIAlertAction!) -> Void in
                })
                let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: {
                    (alert: UIAlertAction!) -> Void in
                })
                
                if self.canEdit {
                    let deleteAction = UIAlertAction(title: "수정하기", style: .default, handler: {
                        (alert: UIAlertAction!) -> Void in
                    })
                    
                    optionMenu.addAction(deleteAction)
                }
                
                optionMenu.addAction(saveAction)
                optionMenu.addAction(cancelAction)
               //show
                self.present(optionMenu, animated: true, completion: nil)
                
            })
            .disposed(by: disposeBag)
        
        bookmarkBtn.rx.tap
            .subscribe(onNext:{ [weak self] _ in
                guard let self = self else { return }
                self.bookmarkBtn.isSelected = !self.bookmarkBtn.isSelected
            })
            .disposed(by: disposeBag)
        
        naviView.backBtn.rx.tap
            .subscribe(onNext:{
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        nextBtn.rx.tap
            .subscribe(onNext:{
                let nextVC = CookingViewController(idx: 1)
                self.navigationController?.pushViewController(
                    nextVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setNavi() {
        naviView.backBtn.setImage(UIImage(named: "backBtn_white"), for: .normal)
    }
    
    private func addViews() {
        view.addSubview(imageView)
        view.addSubview(imageBoardView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(detailTitleLbl)
        contentView.addSubview(subTitleLbl)
        contentView.addSubview(creatorNameLbl)
        contentView.addSubview(starImageView)
        contentView.addSubview(difficultyBgView)
        difficultyBgView.addSubview(difficultyLbl)
        contentView.addSubview(rateNumLbl)
        contentView.addSubview(ingredientLbl)
        contentView.addSubview(ingredientLbl2)
        contentView.addSubview(tableView1)
        contentView.addSubview(tableView2)
        contentView.addSubview(tableView3)
        
        contentView.addSubview(reviewNumLbl)
        contentView.addSubview(reviewGuideLbl)
        
        view.addSubview(nextBtn)
        
        
        view.addSubview(naviView)
        view.addSubview(bookmarkBtn)
        view.addSubview(settingBtn)
    }
    
    private func setConstraints() {
        naviView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        naviView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        naviView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        naviView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        settingBtn.centerYAnchor.constraint(equalTo: naviView.centerYAnchor).isActive = true
        bookmarkBtn.centerYAnchor.constraint(equalTo: naviView.centerYAnchor).isActive = true
        
        settingBtn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        settingBtn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        bookmarkBtn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        bookmarkBtn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        settingBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        bookmarkBtn.trailingAnchor.constraint(equalTo: settingBtn.leadingAnchor, constant: -10).isActive = true
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 200).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true // 세로 스크롤
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        imageBoardView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageBoardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageBoardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageBoardView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        detailTitleLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        detailTitleLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        subTitleLbl.topAnchor.constraint(equalTo: detailTitleLbl.bottomAnchor, constant: 4).isActive = true
        subTitleLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        creatorNameLbl.topAnchor.constraint(equalTo: subTitleLbl.bottomAnchor, constant: 10).isActive = true
        creatorNameLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        rateNumLbl.topAnchor.constraint(equalTo: creatorNameLbl.bottomAnchor,constant: 12)
            .isActive = true
        rateNumLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor,constant: 6 - 34).isActive = true
        
        starImageView.centerYAnchor.constraint(equalTo: rateNumLbl.centerYAnchor).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        starImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        starImageView.trailingAnchor.constraint(equalTo: rateNumLbl.leadingAnchor, constant: -5).isActive = true
        
        
        difficultyBgView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        difficultyBgView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        difficultyBgView.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor).isActive = true
        difficultyBgView.leadingAnchor.constraint(equalTo: rateNumLbl.trailingAnchor, constant: 20).isActive = true
        
        difficultyLbl.centerXAnchor.constraint(equalTo: difficultyBgView.centerXAnchor).isActive = true
        difficultyLbl.centerYAnchor.constraint(equalTo: difficultyBgView.centerYAnchor).isActive = true
        
        
        ingredientLbl.topAnchor.constraint(equalTo: rateNumLbl.bottomAnchor, constant: 22).isActive = true
        ingredientLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50).isActive = true
        
        tableView1.topAnchor.constraint(equalTo: ingredientLbl.bottomAnchor,constant: 10).isActive = true
        tableView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 50).isActive = true
        tableView1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50).isActive = true
        
        ingredientLbl2.topAnchor.constraint(equalTo: tableView1.bottomAnchor, constant: 40).isActive = true
        ingredientLbl2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50).isActive = true
        
        tableView2.topAnchor.constraint(equalTo: ingredientLbl2.bottomAnchor,constant: 10).isActive = true
        tableView2.leadingAnchor.constraint(equalTo: tableView1.leadingAnchor).isActive = true
        tableView2.trailingAnchor.constraint(equalTo: tableView1.trailingAnchor).isActive = true
//        tableView2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50).isActive = true
        
        NSLayoutConstraint.deactivate(self.tableViewConstraint)
        self.tableViewConstraint = [
            tableView1.heightAnchor.constraint(equalToConstant: 0),
            tableView2.heightAnchor.constraint(equalToConstant: 0)
        ]
        NSLayoutConstraint.activate(self.tableViewConstraint)
        
        nextBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
        nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        nextBtn.heightAnchor.constraint(equalToConstant: 52).isActive = true
        nextBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45).isActive = true
        
        reviewNumLbl.topAnchor.constraint(equalTo: tableView2.bottomAnchor, constant: 80).isActive = true
        reviewNumLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        reviewGuideLbl.leadingAnchor.constraint(equalTo: reviewNumLbl.trailingAnchor).isActive = true
        reviewGuideLbl.topAnchor.constraint(equalTo: reviewNumLbl.topAnchor).isActive = true
        
        tableView3.topAnchor.constraint(equalTo: reviewGuideLbl.bottomAnchor, constant: 20).isActive = true
        tableView3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        tableView3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tableView3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,  constant: -80).isActive = true
        tableView3.heightAnchor.constraint(equalToConstant: 360).isActive = true
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return menuArray1.count
        } else if tableView.tag == 2 {
            return menuArray2.count
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.cellId, for: indexPath) as! ReviewTableViewCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.cellId, for: indexPath) as! DetailTableViewCell
            cell.selectionStyle = .none
            if tableView.tag == 1 {
                cell.menuNameLbl.text = menuArray1[indexPath.row][0]
                cell.detailLbl.text = menuArray1[indexPath.row][1]
            } else {
                cell.menuNameLbl.text = menuArray2[indexPath.row][0]
                cell.detailLbl.text = menuArray2[indexPath.row][1]
            }
            return cell
        }
    }
    
}


private let scrollView: UIScrollView = {
    let sv = UIScrollView()
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.showsVerticalScrollIndicator = false
    return sv
}()

private let contentView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
}()



