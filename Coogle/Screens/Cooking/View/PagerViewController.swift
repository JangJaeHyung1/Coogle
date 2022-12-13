//
//  PagerViewController.swift
//  Coogle
//
//  Created by jh on 2022/12/12.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation
import Speech

class PagerViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let naviView: NaviBackUIView = {
        let view = NaviBackUIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        return vc
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
    
    lazy var dataViewControllers: [CookingViewController] = []
    
    var recognizerCheckFlag: Bool = true
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var audioData = AVAudioCompressedBuffer()
    private var tapMicButton = UITapGestureRecognizer()
    private var inputNode: AVAudioInputNode? = nil
    
    var limitPageNum: Int
    
    init(limitPageNum: Int) {
        self.limitPageNum = limitPageNum
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
        
        
        for i in 0..<limitPageNum {
            dataViewControllers.append(CookingViewController(idx: i, limit: limitPageNum))
        }
        
        if let firstVC = dataViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        speechRecognizer?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
            if granted {
                if self.audioEngine.isRunning {
                    self.inputNode?.removeTap(onBus: 0)
                    self.audioEngine.stop()
                    self.recognitionRequest?.endAudio()
                } else {
                    self.startRecording()
                    
                }
            } else {
                print("🔴 Mic: 권한 거부")
            }
        })
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
            self.recognitionRequest = nil
            self.recognitionTask = nil
            self.recognitionTask?.cancel()
            self.recognitionRequest?.endAudio()
            if self.recognizerCheckFlag {
                if stt.contains("다음") {
                    
                }
            }
        })
    }
}


extension PagerViewController {
    private func setUp() {
        setupDelegate()
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
    
    private func setupDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    
    private func fetch() {
        
    }
    
    private func bind() {
        naviView.backBtn.rx.tap
            .subscribe(onNext:{ [unowned self] _ in
                debugPrint("🔵back btn tap")
                self.inputNode?.removeTap(onBus: 0)
                self.audioEngine.stop()
                self.recognitionRequest?.endAudio()
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
                nextVC.idx = self.limitPageNum
                self.navigationController?.pushViewController(
                    nextVC, animated: true)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func setNavi() {
        naviView.titleLbl.text = "소세지 야채 볶음"
    }
    
    private func addViews() {
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        view.addSubview(naviView)
        view.addSubview(nextBtn)
    }
    
    private func setConstraints() {
        naviView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        naviView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        naviView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        naviView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        pageViewController.didMove(toParent: self)
        
        nextBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
        nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        nextBtn.heightAnchor.constraint(equalToConstant: 52).isActive = true
        nextBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
    }
}

extension PagerViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController as! CookingViewController) else { return nil }
        let previousIndex = index - 1
        DispatchQueue.main.async {
            self.nextBtn.isHidden = true
        }
//        print("before index : \(index)")
        if previousIndex < 0 {
            return nil
        }
        return dataViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController as! CookingViewController) else { return nil }
//        print("next index : \(index)")
        let nextIndex = index + 1
        if nextIndex == limitPageNum {
            DispatchQueue.main.async {
                self.nextBtn.isHidden = false
            }
        }
        if nextIndex == dataViewControllers.count {
            return nil
        }
        return dataViewControllers[nextIndex]
    }
}
extension PagerViewController {
    
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
}



extension PagerViewController: SFSpeechRecognizerDelegate {
    
    
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
