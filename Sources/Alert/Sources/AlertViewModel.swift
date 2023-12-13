//
//  AlertViewModel.swift
//  Alert
//
//  Created by Ursus on 10/22/20.
//  Copyright © 2020 Aisberg LLC. All rights reserved.
//

import RxFlow
import RxRelay
import RxSwift
import Foundation
import UIKit

private func hideText(_ text: String?) -> Bool {
    if let text = text {
        return text.isEmpty
    } else {
        return true
    }
}
private func hideText(_ text: NSAttributedString?) -> Bool {
    if let text = text {
        return text.length == 0
    } else {
        return true
    }
}

public class AlertViewModel: Stepper {
    
    // Input
    
    let primaryButtonTapped = PublishRelay<Void>()
    let secondaryButtonTapped = PublishRelay<Void>()
    
    // Output
    
    let iconHidden = BehaviorRelay<Bool>(value: true)
    let iconImage = BehaviorRelay<UIImage?>(value: nil)
    
    let titleHidden = BehaviorRelay<Bool>(value: false)
    let titleText = BehaviorRelay<String?>(value: nil)
    
    let subtitleHidden = BehaviorRelay<Bool>(value: false)
    let subtitleText = BehaviorRelay<String?>(value: nil)
    let attributedSubtitleText = BehaviorRelay<NSAttributedString?>(value: nil)
  
    let horizontalButtonStackHidden = BehaviorRelay<Bool>(value: false)
    let primaryHorizontalButtonTitle = BehaviorRelay<String?>(value: nil)
    let secondaryHorizontalButtonHidden = BehaviorRelay<Bool>(value: false)
    let secondaryHorizontalButtonTitle = BehaviorRelay<String?>(value: nil)
    
    let verticalButtonStackHidden = BehaviorRelay<Bool>(value: true)
    let primaryVerticalButtonTitle = BehaviorRelay<String?>(value: nil)
    let secondaryVerticalButtonHidden = BehaviorRelay<Bool>(value: false)
    let secondaryVerticalButtonTitle = BehaviorRelay<String?>(value: nil)
    
    let dismiss = PublishRelay<Void>()
    
    let indexSelected = PublishRelay<Int>()
    
    private var bag = DisposeBag()
    
    public let steps = PublishRelay<Step>()
    
    public var contents: AlertContents {
        didSet {
            setup()
        }
    }
    
    public init(options: AlertOptions = .init(contents: AlertContents())) {
        contents = options.contents
        setup()
        
        iconImage.map { $0 == nil }.bind(to: iconHidden).disposed(by: bag)
        titleText.map(hideText).bind(to: titleHidden).disposed(by: bag)
        
        Observable.zip(subtitleText.compactMap(hideText), attributedSubtitleText.compactMap(hideText))
            .filter { (hasText, hasAttributeText) -> Bool in
                print("Observable.merge  text - \(hasText) || \(hasAttributeText)  <<\(hasText || hasAttributeText)>>")
                return hasText || hasAttributeText
            }
            .map { _ in false }
            .bind(to: subtitleHidden)
            .disposed(by: bag)
        
        secondaryHorizontalButtonTitle.map(hideText).bind(to: secondaryHorizontalButtonHidden).disposed(by: bag)
        secondaryVerticalButtonTitle.map(hideText).bind(to: secondaryVerticalButtonHidden).disposed(by: bag)
        
        primaryButtonTapped.map { 0 }.bind(to: indexSelected).disposed(by: bag)
        secondaryButtonTapped.map { 1 }.bind(to: indexSelected).disposed(by: bag)
        indexSelected.asObservable().map { _ in () }.bind(to: dismiss).disposed(by: bag)
        indexSelected.bind(to: options.callback).disposed(by: bag)
    }
    
    private func setup() {
        iconImage.accept(contents.icon)
        titleText.accept(contents.title)
        subtitleText.accept(contents.subtitle)
        attributedSubtitleText.accept(contents.attributedSubtitle)
        
        horizontalButtonStackHidden.accept(contents.verticalStack)
        primaryHorizontalButtonTitle.accept(contents.primaryButtonTitle)
        secondaryHorizontalButtonTitle.accept(contents.secondaryButtonTitle)
        
        verticalButtonStackHidden.accept(!contents.verticalStack)
        primaryVerticalButtonTitle.accept(contents.primaryButtonTitle)
        secondaryVerticalButtonTitle.accept(contents.secondaryButtonTitle)
    }
}
