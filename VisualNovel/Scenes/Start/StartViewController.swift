//
//  StartViewController.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import UIKit
import SnapKit

class StartViewController: UIViewController {
    
    private let promptLabel = UILabel()
    private let continueButton = UIButton(type: .system)
    
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
    private func handleContinueButton() {
        viewModel.moveOn()
    }
    
    private func setup() {
        setupSuperView()
        setupPromptLabel()
        setupContinueButton()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .white
    }
    
    private func setupPromptLabel() {
        view.addSubview(promptLabel)
        
        promptLabel.textColor = .white
        promptLabel.font = .scenePrompt
        promptLabel.textAlignment = .center
        promptLabel.numberOfLines = 0
        promptLabel.backgroundColor = .black
        
        promptLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.bounds.height * 0.25)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.width.equalToSuperview()
        }
    }
    
    private func setupContinueButton() {
        view.addSubview(continueButton)
        
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = .black
        continueButton.titleLabel?.font = .sceneTitle
        continueButton.addTarget(self, action: #selector(handleContinueButton), for: .touchUpInside)
        
        continueButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview()
            make.top.equalTo(promptLabel.snp.bottom).offset(view.bounds.height * 0.25)
        }
    }
}

private extension StartViewController {
    func bindViewModel() {
        viewModel.didUpdatePrompt = { [weak self] prompt in
            self?.promptLabel.text = prompt
        }
        
        viewModel.didUpdateTitle = { [weak self] title in
            self?.continueButton.setTitle(title, for: .normal)
        }
    }
}
