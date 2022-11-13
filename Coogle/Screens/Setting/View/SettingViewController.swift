//
//  SettingViewController.swift
//  Coogle
//
//  Created by jh on 2022/10/27.
//

import UIKit

class SettingViewController: UIViewController {

    private let naviView: NaviBackUIView = {
        let view = NaviBackUIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private var tableView: UITableView!
    private var tipArray: [String] = ["내가 만든 레시피 🔥",
                                      "내 정보",
                                      "설정"]
    
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


extension SettingViewController {
    private func setUp() {
        setTableView()
        setNavi()
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
    
    private func fetch() {
        
    }
    
    private func bind() {
        
    }
    
    private func setNavi() {
        naviView.titleLbl.text = "마이페이지"
        naviView.backBtn.isHidden = true
    }
    
    private func addViews() {
        view.addSubview(naviView)
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            naviView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            naviView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            naviView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            naviView.heightAnchor.constraint(equalToConstant: 42),
            
            tableView.topAnchor.constraint(equalTo: naviView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tipArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TipTableViewCell.cellId, for: indexPath) as! TipTableViewCell
        cell.selectionStyle = .none
        cell.configure(with: tipArray[indexPath.row])
        if indexPath.row == 0 {
            cell.textLbl.textColor = BaseColor.red
            cell.textLbl.font = BaseFont.bold
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let nextVC = MyRecipeViewController()
            self.navigationController?.pushViewController(
                nextVC, animated: true)
        } else if indexPath.row == 1 {
            let nextVC = MySettingViewController()
            self.navigationController?.pushViewController(
                nextVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}
