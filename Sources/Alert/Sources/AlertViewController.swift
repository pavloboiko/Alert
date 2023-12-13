//
//  AlertViewController.swift
//  Alert
//
//  Created by Ursus on 10/22/20.
//  Copyright © 2020 Aisberg LLC. All rights reserved.
//

import Reusable
import RxSwift

private func bold(_ size: CGFloat) -> UIFont {
    UIFont(name: "SFProDisplay-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
}

private func medium(_ size: CGFloat) -> UIFont {
    UIFont(name: "SFProDisplay-Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
}

private func regular(_ size: CGFloat) -> UIFont {
    UIFont(name: "SFProDisplay-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
}

private func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
    UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: 1.0)
}

open class AlertViewController: UIViewController, StoryboardBased {
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var iconContainer: UIView!
    @IBOutlet var iconSuperview: UIView!
    @IBOutlet var icon: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var horizontalStack: UIStackView!
    @IBOutlet var primaryHorizontalButton: UIButton!
    @IBOutlet var secondaryHorizontalButton: UIButton!
    
    @IBOutlet var verticalStack: UIStackView!
    @IBOutlet var primaryVerticalButton: UIButton!
    @IBOutlet var secondaryVerticalButton: UIButton!
    
    public var viewModel = AlertViewModel()
    
    public lazy var transition = AlertTransition()
    
    private let bag = DisposeBag()
    
    open override func loadView() {
        super.loadView()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        configureViewModel()
    }
    
    open func setupPrimaryButton(_ button: UIButton) {
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor(red: 1, green: 96.0 / 255, blue: 90.0 / 255, alpha: 1).cgColor
        //button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 10
    }
    
    open func setupSubviews() {
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        containerView.layer.cornerRadius = 30
        iconSuperview.layer.cornerRadius = 20
        
        titleLabel.font = bold(16)
        
        descriptionLabel.textColor = rgb(170, 177, 190)
        descriptionLabel.font = regular(14)
        
        setupPrimaryButton(primaryHorizontalButton)
        secondaryHorizontalButton.backgroundColor = .clear
        secondaryHorizontalButton.layer.cornerRadius = 20
        secondaryVerticalButton.layer.cornerRadius = 20
        
        setupPrimaryButton(primaryVerticalButton)
        primaryVerticalButton.titleLabel?.font = bold(16)
        primaryVerticalButton.setTitleColor(.white, for: [])
        secondaryVerticalButton.titleLabel?.font = medium(16)
        secondaryHorizontalButton.backgroundColor = .clear
    }
    
    private func configureViewModel() {
        primaryHorizontalButton.rx.tap
            .bind(to: viewModel.primaryButtonTapped)
            .disposed(by: bag)
        
        secondaryHorizontalButton.rx.tap
            .bind(to: viewModel.secondaryButtonTapped)
            .disposed(by: bag)
        
        primaryVerticalButton.rx.tap
            .bind(to: viewModel.primaryButtonTapped)
            .disposed(by: bag)
        
        secondaryVerticalButton.rx.tap
            .bind(to: viewModel.secondaryButtonTapped)
            .disposed(by: bag)
        
        viewModel.iconHidden
            .bind(to: iconContainer.rx.isHidden)
            .disposed(by: bag)
        
        viewModel.iconImage
            .bind(to: icon.rx.image)
            .disposed(by: bag)
        
        viewModel.titleHidden
            .bind(to: titleLabel.rx.isHidden)
            .disposed(by: bag)
        
        viewModel.titleText
            .map { $0?.uppercased() }
            .bind(to: titleLabel.rx.text)
            .disposed(by: bag)
        
        viewModel.subtitleHidden
            .bind(to: descriptionLabel.rx.isHidden)
            .disposed(by: bag)
        
        viewModel.subtitleText
            .compactMap { $0 }
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: bag)
        
        viewModel.attributedSubtitleText
            .compactMap { $0 }
            .bind(to: descriptionLabel.rx.attributedText)
            .disposed(by: bag)
        
        viewModel.horizontalButtonStackHidden
            .bind(to: horizontalStack.rx.isHidden)
            .disposed(by: bag)
        
        viewModel.primaryHorizontalButtonTitle
            .bind(to: primaryHorizontalButton.rx.title())
            .disposed(by: bag)
        
        viewModel.secondaryHorizontalButtonHidden
            .bind(to: secondaryHorizontalButton.rx.isHidden)
            .disposed(by: bag)
        
        viewModel.verticalButtonStackHidden
            .bind(to: verticalStack.rx.isHidden)
            .disposed(by: bag)
        
        viewModel.primaryVerticalButtonTitle
            .bind(to: primaryVerticalButton.rx.title())
            .disposed(by: bag)
        
        viewModel.secondaryVerticalButtonTitle
            .bind(to: secondaryVerticalButton.rx.title())
            .disposed(by: bag)
        
        viewModel.dismiss
            .bind { [weak self] in
                self?.dismiss(animated: true)
            }
            .disposed(by: bag)
    }
    
    open override var shouldAutorotate: Bool { false }
}
