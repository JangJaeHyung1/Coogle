//
//  CookingViewController.swift
//  Coogle
//
//  Created by jh on 2022/08/21.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation
import Speech

protocol popNaviDelegate {
    func popNavi()
}

class CookingViewController: UIViewController {
    var delegate: popNaviDelegate?
    private let disposeBag = DisposeBag()
    var idx: Int
    var limitPageNum: Int = 4
    var recognizerCheckFlag: Bool = true
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var audioData = AVAudioCompressedBuffer()
    private var tapMicButton = UITapGestureRecognizer()
    private var inputNode: AVAudioInputNode? = nil
    
    
    init(idx: Int){
        self.idx = idx
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let naviView: NaviBackUIView = {
        let view = NaviBackUIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
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
    
    private let nextBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("요리 완성", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = BaseFont.bold
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.backgroundColor = BaseColor.btnColor
        btn.layer.cornerRadius = 4
        btn.isHidden = true
        return btn
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
        navigationController?.delegate = self
        speechRecognizer?.delegate = self
        
        if idx == limitPageNum {
            nextBtn.isHidden = false
            self.inputNode?.removeTap(onBus: 0)
            self.audioEngine.stop()
            self.recognitionRequest?.endAudio()
        }
        stepNumLbl.text = "\(idx)/\(limitPageNum)"
        stepTitleLbl.text = "STEP 0\(idx)"
    }
    
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let coordinator = navigationController.topViewController?.transitionCoordinator {
            coordinator.notifyWhenInteractionChanges({ (context) in
                print("Is cancelled: \(context.isCancelled)")
                if context.isCancelled == false {
                    self.inputNode?.removeTap(onBus: 0)
                    self.audioEngine.stop()
                    self.recognitionRequest?.endAudio()
                    print("pop delegate 이전 : \(self.recognizerCheckFlag)")
                    self.delegate?.popNavi()
                    print("pop delegate 이후 : \(self.recognizerCheckFlag)")
                }
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidappear : \(self.idx) flag : \(self.recognizerCheckFlag)")
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
            if granted {
                if self.audioEngine.isRunning {
                    self.inputNode?.removeTap(onBus: 0)
                    self.audioEngine.stop()
                    self.recognitionRequest?.endAudio()
                } else {
                    if self.idx != self.limitPageNum {
                        self.startRecording()
                    }
                }
            } else {
                print("🔴 Mic: 권한 거부")
            }
        })
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
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(CookingViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left :
                if idx != limitPageNum {
                    let nextVC = CookingViewController(idx: self.idx + 1 )
                    nextVC.delegate = self
                    self.inputNode?.removeTap(onBus: 0)
                    self.audioEngine.stop()
                    self.recognitionRequest?.endAudio()
                    self.navigationController?.pushViewController(
                        nextVC, animated: true)
                }
            default:
                break
            }
        }
    }
    
    private func fetch() {
        
    }
    
    private func bind() {
        naviView.backBtn.rx.tap
            .subscribe(onNext:{ [unowned self] _ in
                self.inputNode?.removeTap(onBus: 0)
                self.audioEngine.stop()
                self.recognitionRequest?.endAudio()
                delegate?.popNavi()
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        nextBtn.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(onNext:{ [unowned self] res in
                if self.audioEngine.isRunning {
                    debugPrint("🔵next btn tap : engine stop")
                    self.inputNode?.removeTap(onBus: 0)
                    self.audioEngine.stop()
                    self.recognitionRequest?.endAudio()
                }
                let nextVC = EndCookingViewController()
                nextVC.idx = self.idx
                self.navigationController?.pushViewController(
                    nextVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setNavi() {
        naviView.titleLbl.text = "소세지 야채 볶음"
    }
    
    private func addViews() {
        view.addSubview(naviView)
        view.addSubview(imageView)
        view.addSubview(stepTitleLbl)
        view.addSubview(stepNumLbl)
        view.addSubview(subLbl)
        view.addSubview(nextBtn)
        view.addSubview(contentView)
        contentView.addSubview(contentLbl)
    }
    
    private func setConstraints() {
        naviView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        naviView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        naviView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        naviView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        imageView.topAnchor.constraint(equalTo: naviView.bottomAnchor, constant: 20).isActive = true
        
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
        
        nextBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
        nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        nextBtn.heightAnchor.constraint(equalToConstant: 52).isActive = true
        nextBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
    }
}

extension CookingViewController {
    
    func requestMicrophonePermission(){
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
            if granted {
                print("Mic: 권한 허용")
            } else {
                print("Mic: 권한 거부")
            }
        })
    }
    
    private func startRecording() {
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, options: .defaultToSpeaker)
            try audioSession.setMode(.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("🔴audioSession properties weren't set because of an error.")
        }
        
        voiceRecognizerTask()
        
        inputNode = audioEngine.inputNode
        
        let recordingFormat = inputNode?.outputFormat(forBus: 0)
        
        inputNode?.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] (buffer, when) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if self.recognitionRequest == nil {
                    self.voiceRecognizerTask()
                }
            }
            
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("🔴audioEngine couldn't start because of an error.")
        }
        
    }
    
    
    private func voiceRecognizerTask() {
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        guard let recognitionRequest = recognitionRequest else { return }
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { [weak self] (result, error) in
            guard let self = self else { return }
            guard let result = result else { return }
            let stt = result.bestTranscription.formattedString
            print("recognizerCheckFlag : \(self.recognizerCheckFlag) \n idx : \(self.idx)")
            self.recognitionRequest = nil
            self.recognitionTask = nil
            self.recognitionTask?.cancel()
            self.recognitionRequest?.endAudio()
            if self.recognizerCheckFlag {
                if stt.contains("다음") {
                    self.recognizerCheckFlag = false
                    DispatchQueue.main.async {
                        print("check point")
                        if self.idx != self.limitPageNum {
                            let nextVC = CookingViewController(idx: self.idx + 1)
                            
                            self.inputNode?.removeTap(onBus: 0)
                            self.audioEngine.stop()
                            self.recognitionRequest?.endAudio()
                            nextVC.delegate = self
                            self.navigationController?.pushViewController(
                                nextVC, animated: true)
                        }
                    }
                }
            }
        })
    }
}

extension CookingViewController: SFSpeechRecognizerDelegate {
    
    
    func audioBufferToNSData(PCMBuffer: AVAudioPCMBuffer) -> NSData {
        let channelCount = 1  // given PCMBuffer channel count is 1
        let channels = UnsafeBufferPointer(start: PCMBuffer.floatChannelData, count: channelCount)
        let data = NSData(bytes: channels[0], length:Int(PCMBuffer.frameLength * PCMBuffer.format.streamDescription.pointee.mBytesPerFrame))
        
        return data
    }
    
    
    func dataToPCMBuffer(format: AVAudioFormat, data: NSData) -> AVAudioPCMBuffer {
        
        let audioBuffer2 = AVAudioPCMBuffer(pcmFormat: format,
                                            frameCapacity: UInt32(data.length) / format.streamDescription.pointee.mBytesPerFrame)
        
        audioBuffer2?.frameLength = audioBuffer2!.frameCapacity
        let channels = UnsafeBufferPointer(start: audioBuffer2?.floatChannelData, count: Int(audioBuffer2!.format.channelCount))
        data.getBytes(UnsafeMutableRawPointer(channels[0]) , length: data.length)
        return audioBuffer2!
    }
}


extension CookingViewController{
    func stopRecong(){
        DispatchQueue.main.async { [unowned self] in
            guard let task = self.recognitionTask else {
                fatalError("Error")
            }
            task.cancel()
            task.finish()
        }
    }
}

extension CookingViewController: UINavigationControllerDelegate {
    
}

extension CookingViewController: popNaviDelegate {
    func popNavi() {
        recognizerCheckFlag = true
    }
}
