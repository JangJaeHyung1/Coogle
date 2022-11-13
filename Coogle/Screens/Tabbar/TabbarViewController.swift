//
//  TabbarViewController.swift
//  Coogle
//
//  Created by jh on 2022/08/14.
//

import UIKit
import RxSwift
import RxCocoa

class TabbarViewController: UITabBarController  {
    private let safeLayoutView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        overrideUserInterfaceStyle = .light
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 88
        tabBar.frame.origin.y = view.frame.height - 88
    }
    
}

extension TabbarViewController {
    private func setUp() {
        setTabBar()
        setupStyle()
        setNavi()
        setSafeLayoutGuideView()
    }
    
    private func setSafeLayoutGuideView() {
        view.addSubview(safeLayoutView)
        self.safeLayoutView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.safeLayoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.safeLayoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.safeLayoutView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
    }
    private func setupStyle() {
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
    }
    
    private func setNavi() {
//        self.navigationItem.title = "여행 일정"
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    private func setTabBar(){
        let vc1 = MainViewController()
        let vc2 = TipViewController()
        let vc3 = BookmarkViewController()
        let vc4 = SettingViewController()
        vc1.title = "레시피"
        vc2.title = "꿀팁"
        vc3.title = "북마크"
        vc4.title = "마이페이지"
        self.setViewControllers([vc1,vc2,vc3,vc4], animated: false)
        
        guard let items = self.tabBar.items else { return }
        
        let itemsImage = ["tab_recipe","tab_tip","tab_bookmark","tab_myProfile"]
        
        for x in 0...3 {
            let image = UIImage(named: itemsImage[x])?.resizedImage(Size: CGSize(width: 24, height: 24))
            items[x].image = image
        }
        
        self.tabBar.tintColor = BaseColor.tabbarTintColor
    }
}


class SecondViewController: UIViewController {
    override func viewWillLayoutSubviews() {
        view.layoutMargins = .zero
        view.safeAreaLayoutGuide.accessibilityFrame = .zero
        view.insetsLayoutMarginsFromSafeArea = false
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
    }
}

class ThirdViewController: UIViewController {
    override func viewWillLayoutSubviews() {
        view.layoutMargins = .zero
        view.safeAreaLayoutGuide.accessibilityFrame = .zero
        view.insetsLayoutMarginsFromSafeArea = false
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}
