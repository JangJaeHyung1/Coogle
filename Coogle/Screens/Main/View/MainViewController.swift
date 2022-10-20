//
//  ViewController.swift
//  Coogle
//
//  Created by jh on 2022/08/07.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let naviView: NaviBarUIView = {
        let view = NaviBarUIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private var collectionView: UICollectionView!
    private var tableViewMain: UITableView!
    private var categoryArray: [String] = ["전체", "메인요리", "국·찌개", "밑반찬", "다이어트", "건강주스"]
    
    private func setCollectionView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(NaviBarCollectionViewCell.self, forCellWithReuseIdentifier: NaviBarCollectionViewCell.cellId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
    }
    
    private func setTableView(){
        tableViewMain = UITableView()
        tableViewMain.dataSource = self
        tableViewMain.delegate = self
        tableViewMain.separatorStyle = .none
        tableViewMain.showsHorizontalScrollIndicator = false
        tableViewMain.showsVerticalScrollIndicator = false
        tableViewMain.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellId)
        tableViewMain.translatesAutoresizingMaskIntoConstraints = false
        tableViewMain.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

extension MainViewController {
    private func setUp() {
        setNavi()
        setCollectionView()
        collectionViewCellSetMargin()
        setTableView()
        addViews()
        setConstraints()
        bind()
        fetch()
    }
    
    private func fetch() {
        
    }
    
    private func bind() {
        
        tableViewMain.rx.itemSelected
            .subscribe(onNext:{ [unowned self] _ in
                let nextVC = DetailViewController()
                self.navigationController?.pushViewController(
                    nextVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setNavi() {
    }
    
    private func addViews() {
        view.addSubview(naviView)
        view.addSubview(collectionView)
        view.addSubview(bottomLine)
        view.addSubview(tableViewMain)
    }
    
    private func setConstraints() {
        naviView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        naviView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        naviView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        naviView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: naviView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: naviView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: naviView.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        tableViewMain.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        tableViewMain.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableViewMain.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableViewMain.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        bottomLine.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
    }
}

// MARK: - CollectionView Delegate, DataSource

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NaviBarCollectionViewCell.cellId, for: indexPath) as! NaviBarCollectionViewCell
        cell.titleLbl.text = categoryArray[indexPath.row]
        
        if indexPath.item == 0 {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = categoryArray[indexPath.item]
        // ✅ sizeToFit() : 텍스트에 맞게 사이즈가 조절
        label.sizeToFit()
        // ✅ cellWidth = 글자수에 맞는 UILabel 의 width + 10(여백)
        return CGSize(width: label.frame.width + 10, height: 40)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? NaviBarCollectionViewCell {
//            cell.selectedUnderLineView.isHidden = false
//            cell.titleLbl.font = BaseFont.bold
//            cell.titleLbl.textColor = BaseColor.main
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? NaviBarCollectionViewCell {
//            cell.selectedUnderLineView.isHidden = true
//            cell.titleLbl.font = BaseFont.normal
//            cell.titleLbl.textColor = BaseColor.unSelected
//        }
//    }
    
    //collection VC section 마진값
    func collectionViewCellSetMargin(){
        let interval:CGFloat = 16
        let flowLayout: UICollectionViewFlowLayout
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0 , left: interval, bottom: 0, right: 0)
        self.collectionView.collectionViewLayout = flowLayout
    }
}


// MARK: - TableView Delegate, DataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellId, for: indexPath) as! MainTableViewCell
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        return cell
    }
}
