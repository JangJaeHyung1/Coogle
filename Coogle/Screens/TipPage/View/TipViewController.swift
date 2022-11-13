//
//  TipViewController.swift
//  Coogle
//
//  Created by jh on 2022/10/24.
//

import UIKit

class TipViewController: UIViewController {
    
    private let naviView: NaviBackUIView = {
        let view = NaviBackUIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private var collectionView: UICollectionView!
    private var tableView: UITableView!
    private var categoryArray: [String] = ["재료 보관", "요리 상식"]
    private var tipArray: [String] = ["양파 보관법", "소고기 보관법", "돼지고기 보관법", "당근 보관법"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        view.backgroundColor = .white
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension TipViewController {
    private func setUp() {
        setNavi()
        setCollectionView()
        setTableView()
        collectionViewCellSetMargin()
        addViews()
        setConstraints()
        bind()
        fetch()
    }
    private func setTableView(){
        tableView = UITableView()
        //        tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TipTableViewCell.self, forCellReuseIdentifier: TipTableViewCell.cellId)
        tableView.backgroundColor = .white
        //        tableView.register(CommunityHeaderView.self, forHeaderFooterViewReuseIdentifier: CommunityHeaderView.headerViewID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
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
    
    private func fetch() {
        
    }
    
    private func bind() {
        
    }
    
    private func setNavi() {
        naviView.titleLbl.text = "요리 꿀팁"
        naviView.backBtn.isHidden = true
    }
    
    private func addViews() {
        view.addSubview(naviView)
        view.addSubview(collectionView)
        view.addSubview(bottomLine)
        view.addSubview(tableView)
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
        
        bottomLine.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        
        tableView.topAnchor.constraint(equalTo: bottomLine.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
// MARK: - CollectionView Delegate, DataSource

extension TipViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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

extension TipViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tipArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TipTableViewCell.cellId, for: indexPath) as! TipTableViewCell
        cell.selectionStyle = .none
        cell.configure(with: tipArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = TipDetailViewController()
        self.navigationController?.pushViewController(
            nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}
