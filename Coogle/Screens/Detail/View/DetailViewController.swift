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
    
    private let disposeBag = DisposeBag()
    private var tableView: UITableView!
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
    
    private let safeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = .white
        view.layer.opacity = 0
        return view
    }()
    
    private let secondNaviView: NaviBackUIView = {
        let view = NaviBackUIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = .white
        view.layer.opacity = 0
        return view
    }()
    
    private let naviTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = .black
        lbl.lineBreakMode = .byWordWrapping
        lbl.font = BaseFont.menuTitle
        lbl.addCharacterSpacing()
        lbl.text = "소세지 야채 볶음"
        lbl.isUserInteractionEnabled = true
        lbl.layer.opacity = 0
        //    lbl.adjustsFontSizeToFitWidth = true
        //    lbl.minimumScaleFactor = 0.5
        return lbl
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
    
    private let secondBookmarkBtn: UIButton = {
        let btn = UIButton()
//        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.setImage(UIImage(named: "bookmark"), for: .normal)
        btn.setImage(UIImage(named: "bookmark_onClick"), for: .selected)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.layer.opacity = 0
//        btn.isHidden = true
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
    
    private let secondSettingBtn: UIButton = {
        let btn = UIButton()
//        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.setImage(UIImage(named: "setting"), for: .normal)
        btn.setImage(UIImage(named: "setting_onClick"), for: .selected)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.layer.opacity = 0
//        btn.isHidden = true
        //    btn.imageView?.contentMode = .scaleAspectFit
        return btn
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
        self.secondBookmarkBtn.isSelected = self.isBookmark
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
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.cellId)
        tableView.register(DetailFristTableViewCell.self, forCellReuseIdentifier: DetailFristTableViewCell.cellId)
        
        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.contentInset = .init(top: 0, left: 0, bottom: 90, right: 0)
        tableView.contentInsetAdjustmentBehavior = .never
        let headerView = DetailFirstHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        headerView.imageView.image = UIImage(named: "testImage2")
        tableView.tableHeaderView = headerView
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
                        let nextVC = CreateRecipeViewController()
                        nextVC.recipeName = "소세지 야채 볶음"
                        nextVC.viewModel.input.firstPageCategory.accept("메인요리")
                        nextVC.viewModel.input.firstPageDifficulty.accept(0)
                        nextVC.viewModel.input.firstPageDescription.accept("간단한 밥반찬으로 딱 좋은 소세지 야채볶음!")
                        nextVC.viewModel.input.secondPageIngredientFrist.accept([["비엔나소세지", "200 g"],["양파", "1 개"], ["파프리카", "1 개"]])
                        nextVC.viewModel.input.secondPageIngredientSecond.accept([["간장", "1 큰술"],["설탕","1 큰술"]])
                        let imgData = UIImage(named: "cookImage")?.jpegData(compressionQuality: 0.7)
                        nextVC.viewModel.input.thirdPageImageData.accept([imgData])
                        nextVC.viewModel.input.thirdPageDescription.accept(["소세지와 야채는 잘라서 준비해주세요."])
                        self.navigationController?.pushViewController(
                            nextVC, animated: true)
                    })
                    
                    optionMenu.addAction(deleteAction)
                }
                
                optionMenu.addAction(saveAction)
                optionMenu.addAction(cancelAction)
               //show
                self.present(optionMenu, animated: true, completion: nil)
                
            })
            .disposed(by: disposeBag)
        
        secondSettingBtn.rx.tap
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
                        let nextVC = CreateRecipeViewController()
                        nextVC.recipeName = "소세지 야채 볶음"
                        nextVC.viewModel.input.firstPageCategory.accept("메인요리")
                        nextVC.viewModel.input.firstPageDifficulty.accept(0)
                        nextVC.viewModel.input.firstPageDescription.accept("간단한 밥반찬으로 딱 좋은 소세지 야채볶음!")
                        nextVC.viewModel.input.secondPageIngredientFrist.accept([["비엔나소세지", "200 g"],["양파", "1 개"], ["파프리카", "1 개"]])
                        nextVC.viewModel.input.secondPageIngredientSecond.accept([["간장", "1 큰술"],["설탕","1 큰술"]])
                        let imgData = UIImage(named: "cookImage")?.jpegData(compressionQuality: 0.7)
                        nextVC.viewModel.input.thirdPageImageData.accept([imgData])
                        nextVC.viewModel.input.thirdPageDescription.accept(["소세지와 야채는 잘라서 준비해주세요."])
                        self.navigationController?.pushViewController(
                            nextVC, animated: true)
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
                self.secondBookmarkBtn.isSelected = self.bookmarkBtn.isSelected
            })
            .disposed(by: disposeBag)
        
        naviView.backBtn.rx.tap
            .subscribe(onNext:{
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        
        secondBookmarkBtn.rx.tap
            .subscribe(onNext:{ [weak self] _ in
                guard let self = self else { return }
                self.secondBookmarkBtn.isSelected = !self.secondBookmarkBtn.isSelected
                self.bookmarkBtn.isSelected = self.secondBookmarkBtn.isSelected
            })
            .disposed(by: disposeBag)
        
        secondNaviView.backBtn.rx.tap
            .subscribe(onNext:{
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        nextBtn.rx.tap
            .subscribe(onNext:{
                let nextVC = PagerViewController(limitPageNum: 10)
                self.navigationController?.pushViewController(
                    nextVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setNavi() {
        naviView.backBtn.setImage(UIImage(named: "backBtn_white"), for: .normal)
    }
    
    private func addViews() {
        view.addSubview(tableView)
        view.addSubview(nextBtn)
        view.addSubview(naviView)
        view.addSubview(bookmarkBtn)
        view.addSubview(settingBtn)
        
        view.addSubview(safeView)
        view.addSubview(secondNaviView)
        view.addSubview(secondBookmarkBtn)
        view.addSubview(secondSettingBtn)
        view.addSubview(naviTitleLbl)
        
    }
    
    private func setConstraints() {
        
        naviTitleLbl.leadingAnchor.constraint(equalTo: naviView.backBtn.trailingAnchor, constant: 10).isActive = true
        naviTitleLbl.centerYAnchor.constraint(equalTo: naviView.centerYAnchor).isActive = true
        
        safeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        safeView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        safeView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        safeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        naviView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        naviView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        naviView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        naviView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        secondNaviView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        secondNaviView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        secondNaviView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        secondNaviView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        secondSettingBtn.centerYAnchor.constraint(equalTo: secondNaviView.centerYAnchor).isActive = true
        secondBookmarkBtn.centerYAnchor.constraint(equalTo: secondNaviView.centerYAnchor).isActive = true
        secondSettingBtn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        secondSettingBtn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        secondBookmarkBtn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        secondBookmarkBtn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        secondSettingBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        secondBookmarkBtn.trailingAnchor.constraint(equalTo: secondSettingBtn.leadingAnchor, constant: -10).isActive = true
        
        
        settingBtn.centerYAnchor.constraint(equalTo: naviView.centerYAnchor).isActive = true
        bookmarkBtn.centerYAnchor.constraint(equalTo: naviView.centerYAnchor).isActive = true
        settingBtn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        settingBtn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        bookmarkBtn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        bookmarkBtn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        settingBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        bookmarkBtn.trailingAnchor.constraint(equalTo: settingBtn.leadingAnchor, constant: -10).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        nextBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
        nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        nextBtn.heightAnchor.constraint(equalToConstant: 52).isActive = true
        nextBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 62
        } else if section == 2 {
            return 62
        } else {
            return 130
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = DetailFirstHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
            headerView.imageView.image = UIImage(named: "testImage2")
            return headerView
        } else if section == 1 {
            let headerView = DetailIngredientHeaderView()
            headerView.subTitleLbl.isHidden = false
            headerView.recipeNameLbl.text = "메인 재료"
            return headerView
        } else if section == 2 {
            let headerView = DetailIngredientHeaderView()
            headerView.recipeNameLbl.text = "조미료"
            return headerView
        } else {
            let headerView = ReviewHeaderView()
            headerView.reviewNumLbl.text = "21개"
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return menuArray1.count
        } else if section == 2 {
            return menuArray2.count
        } else {
            return 10
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailFristTableViewCell.cellId, for: indexPath) as! DetailFristTableViewCell
            
            cell.selectionStyle = .none
            return cell
        }
        
        else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.cellId, for: indexPath) as! ReviewTableViewCell
            cell.deleteBtn.isHidden = true
            if indexPath.row == 0 {
                cell.deleteBtn.isHidden = false
            }
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.cellId, for: indexPath) as! DetailTableViewCell
            cell.selectionStyle = .none
            if indexPath.section == 1 {
                cell.menuNameLbl.text = menuArray1[indexPath.row][0]
                cell.detailLbl.text = menuArray1[indexPath.row][1]
            } else {
                cell.menuNameLbl.text = menuArray2[indexPath.row][0]
                cell.detailLbl.text = menuArray2[indexPath.row][1]
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 160
        } else if indexPath.section == 3 {
            return 120
        } else {
            return 30
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? DetailFirstHeaderView else { return }
        header.scrollViewDidScroll(scrollView: tableView)
//        print(scrollView.contentOffset.y)
        
        if scrollView.contentOffset.y < 125 {
            setOpacity(0)
        } else if scrollView.contentOffset.y >= 125 && scrollView.contentOffset.y < 200 {
            let temp = (scrollView.contentOffset.y - 125) / 75
            setOpacity(Float(temp))
        } else {
            setOpacity(1)
        }
    }
    
    func setOpacity(_ opacity: Float) {
        secondBookmarkBtn.layer.opacity = opacity
        secondNaviView.layer.opacity = opacity
        secondSettingBtn.layer.opacity = opacity
        naviTitleLbl.layer.opacity = opacity
        safeView.layer.opacity = opacity
    }
}
