//
//  StartViewController.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import UIKit
import SnapKit

class StartViewController: UIViewController {
    
    private enum Constants {
            enum HeaderLabel {
                static let ratioTop: CGFloat = 0.25
                static let ratioHeight: CGFloat = 0.2
            }
            
            enum ContinueLabel {
                static let height: CGFloat = 50
                static let ratioTop: CGFloat = 0.25
            }
    }
    
    private let headerLabel = UILabel()
    private let continueLabel = DialogueLabel(style: .prompt)
    
    private var viewModel: StartViewModelType
    
    init(with viewModel: StartViewModelType) {
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
        setupSuperView()
        setupHeaderLabel()
        setupContinueLabel()
        setupContinueLabelTapGesture()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .white
    }
    
    private func setupHeaderLabel() {
        view.addSubview(headerLabel)
        
        headerLabel.font = .startHeader
        headerLabel.textColor = .appText
        headerLabel.backgroundColor = .startHeader
        headerLabel.textAlignment = .center
        headerLabel.numberOfLines = 0
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.bounds.height * Constants.HeaderLabel.ratioTop)
            make.height.equalToSuperview().multipliedBy(Constants.HeaderLabel.ratioHeight)
            make.width.equalToSuperview()
        }
    }
    
    private func setupContinueLabel() {
        view.addSubview(continueLabel)
        
        continueLabel.snp.makeConstraints { make in
            make.height.equalTo(Constants.ContinueLabel.height)
            make.width.equalToSuperview()
            make.top.equalTo(headerLabel.snp.bottom).offset(view.bounds.height * Constants.ContinueLabel.ratioTop)
        }
    }
    
    private func setupContinueLabelTapGesture() {
        let continueTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleContinueTap))
        continueLabel.isUserInteractionEnabled = true
        continueLabel.addGestureRecognizer(continueTapGesture)
    }
}

private extension StartViewController {
    func bindViewModel() {
        viewModel.didUpdateHeader = { [weak self] header in
            self?.headerLabel.text = header
        }
        
        viewModel.didUpdateTitle = { [weak self] text in
            self?.continueLabel.text = text
        }
    }
}
