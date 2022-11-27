//
//  PhotoPermissionManager.swift
//  Coogle
//
//  Created by jh on 2022/11/18.
//

import RxSwift
import RxCocoa
import Photos

class PhotoPermissionManager {
  static let shared = PhotoPermissionManager()
  private init() {}
  
  func requestPhoto() -> Observable<PHAuthorizationStatus> {
    Observable<PHAuthorizationStatus>.create { observable in
        PHPhotoLibrary.requestAuthorization { auth in
          DispatchQueue.main.async {
            observable.onNext(auth)
            observable.onCompleted()
          }
      }
      return Disposables.create()
    }
  }
}


