//
//  LoginViewController.swift
//  Coogle
//
//  Created by jh on 2023/02/02.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import KakaoSDKCommon
import RxKakaoSDKCommon
import KakaoSDKAuth
import RxKakaoSDKAuth
import KakaoSDKUser
import RxKakaoSDKUser

protocol SetTabbarMainDelegate{
    func setTabbarMain ()
}

class LoginViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var delegate: SetTabbarMainDelegate?
    
    private let closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "closeBtn"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    private let logoImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "login_logo")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let titleImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "login_title")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        //img.layer.masksToBounds = true
        return img
    }()
    
    private let subTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.font = BaseFont.subTitle
        lbl.textColor = BaseColor.sub
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "자세한 레시피를 알고 싶다면?"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    private let loginGuideLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.font = BaseFont.subTitle
        lbl.textColor = BaseColor.sub
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "간편하게 로그인하고 시작하기!"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    private let policyLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.font = BaseFont.sub
        lbl.textColor = BaseColor.sub
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "서비스 약관 및 프라이버시 정책에 동의합니다"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    private let kakaoLoginBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "login_kakao"), for: .normal)
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}



extension LoginViewController {
    private func setUp() {
        configure()
        setNavi()
        addViews()
        setConstraints()
        bind()
        fetch()
    }
    private func configure() {
        view.backgroundColor = .white
    }
    
    private func fetch() {
        
    }
    
    private func bind() {
        closeBtn.rx.tap
            .subscribe(onNext:{ [weak self] _ in
                guard let self = self else { return }
                self.delegate?.setTabbarMain()
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        kakaoLoginBtn.rx.tap
            .subscribe(onNext:{ [unowned self] res in
                if (UserApi.isKakaoTalkLoginAvailable()) {
                    UserApi.shared.rx.loginWithKakaoTalk()
                        .subscribe(onNext:{ (oauthToken) in
                            print("loginWithKakaoTalk() success.")
                            UserApi.shared.rx.me()
                                .map({ (user) -> User in

                                    //필요한 scope을 아래의 예제코드를 참고해서 추가한다.
                                    //아래 예제는 모든 스콥을 나열한것.
                                    var scopes = [String]()
                                    
                                    if (user.kakaoAccount?.profileNeedsAgreement == true) { scopes.append("profile") }
                                    if (user.kakaoAccount?.emailNeedsAgreement == true) { scopes.append("account_email") }
                                    if (user.kakaoAccount?.birthdayNeedsAgreement == true) { scopes.append("birthday") }
                                    if (user.kakaoAccount?.birthyearNeedsAgreement == true) { scopes.append("birthyear") }
                                    if (user.kakaoAccount?.genderNeedsAgreement == true) { scopes.append("gender") }
                                    if (user.kakaoAccount?.phoneNumberNeedsAgreement == true) { scopes.append("phone_number") }
                                    if (user.kakaoAccount?.ageRangeNeedsAgreement == true) { scopes.append("age_range") }
                                    if (user.kakaoAccount?.ciNeedsAgreement == true) { scopes.append("account_ci") }
            //                         scopes.append("openid")
                                    
                                    if (scopes.count > 0) {
                                        print("사용자에게 추가 동의를 받아야 합니다.")

                                        // OpenID Connect 사용 시
                                        // scope 목록에 "openid" 문자열을 추가하고 요청해야 함
                                        // 해당 문자열을 포함하지 않은 경우, ID 토큰이 재발급되지 않음
                                        // scopes.append("openid")
                                        
                                        // scope 목록을 전달하여 SdkError 처리
                                        throw SdkError(scopes:scopes)
                                    }
                                    else {
                                        print("사용자의 추가 동의가 필요하지 않습니다.")

                                        return user
                                    }
                                })
                                .retry(when: Auth.shared.rx.incrementalAuthorizationRequired())
                                .subscribe(onSuccess:{ ( user ) in
//                                    print("me() success.")
//                                    dump(user)
                                    //do something
                                    let userHash = String(describing: user.id)
                                    LoginUserHashCache.shared.store(value: userHash)
                                    self.dismiss(animated: true)
                                    
                                }, onFailure: {error in
                                    print(error)
                                })
                                .disposed(by: self.disposeBag)
                            //do something
                            _ = oauthToken
                        }, onError: {error in
                            print(error)
                        })
                    .disposed(by: disposeBag)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setNavi() {
    }
    
    private func addViews() {
        view.addSubview(closeBtn)
        view.addSubview(logoImage)
        view.addSubview(titleImage)
        view.addSubview(subTitleLbl)
        view.addSubview(loginGuideLbl)
        view.addSubview(kakaoLoginBtn)
        view.addSubview(policyLbl)
    }
    
    private func setConstraints() {
        
        kakaoLoginBtn.snp.makeConstraints { make in
            make.top.equalTo(loginGuideLbl.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
        }
        
        closeBtn.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        logoImage.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(42 + 84)
        }
        
        titleImage.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImage.snp.bottom).offset(25)
        }
        
        subTitleLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loginGuideLbl.snp.top).offset(-20)
        }
        
        loginGuideLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(policyLbl.snp.top).offset(-164)
        }
        
        policyLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-60)
        }
        
        
    }
}
