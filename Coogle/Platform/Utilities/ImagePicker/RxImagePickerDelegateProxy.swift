//
//  RxImagePickerDelegateProxy.swift
//  Brit
//
//  Created by jh on 2021/11/25.
//

#if os(iOS)

import RxSwift
import RxCocoa
import UIKit

open class RxImagePickerDelegateProxy
    : RxNavigationControllerDelegateProxy, UIImagePickerControllerDelegate {

    public init(imagePicker: UIImagePickerController) {
        super.init(navigationController: imagePicker)
    }

}

#endif

