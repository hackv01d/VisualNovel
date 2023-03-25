//
//  MainViewController.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {
    
    private enum Constants {
            enum HeaderLabel {
                static let ratioTop: CGFloat = 0.25
                static let ratioHeight: CGFloat = 0.2
                static let numberOfLines: Int = 0
            }
            
            enum ContinueLabel {
                static let height: CGFloat = 50
                static let ratioTop: CGFloat = 0.25
            }
    }
    
    private let headerLabel = UILabel()
    private let continueLabel = DialogueLabel(style: .prompt)
    
    private var viewModel: MainViewModelType
    
    init(with viewModel: MainViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bindViewModel()
        viewModel.getSceneDetail()
    }
    
    @objc
    private func handleContinueTap() {
        viewModel.moveOn()
    }
    
    private func setup() {
        setupHeaderLabel()
        setupContinueLabel()
        setupContinueLabelTapGesture()
    }
    
    private func setupHeaderLabel() {
        view.addSubview(headerLabel)
        
        headerLabel.font = .mainHeader
        headerLabel.textColor = .appText
        headerLabel.backgroundColor = .mainHeader
        headerLabel.textAlignment = .center
        headerLabel.numberOfLines = Constants.HeaderLabel.numberOfLines
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.bounds.height * Constants.HeaderLabel.ratioTop)
            make.height.equalToSuperview().multipliedBy(Constants.HeaderLabel.ratioHeight)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupContinueLabel() {
        view.addSubview(continueLabel)
        
        continueLabel.snp.makeConstraints { make in
            make.height.equalTo(Constants.ContinueLabel.height)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerLabel.snp.bottom).offset(view.bounds.height * Constants.ContinueLabel.ratioTop)
        }
    }
    
    private func setupContinueLabelTapGesture() {
        let continueTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleContinueTap))
        continueLabel.isUserInteractionEnabled = true
        continueLabel.addGestureRecognizer(continueTapGesture)
    }
}

private extension MainViewController {
    func bindViewModel() {
        viewModel.didUpdateChoice = { [weak self] text in
            self?.continueLabel.text = text
        }
        
        viewModel.didUpdateHeader = { [weak self] header in
            self?.headerLabel.text = header
        }

        viewModel.didUpdateBackground = { [weak self] imageName in
            self?.setBackgroundImage(named: imageName)
        }
    }
}
