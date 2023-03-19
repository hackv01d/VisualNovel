//
//  StartViewController.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import UIKit
import SnapKit

class StartViewController: UIViewController {
    
    private let headerLabel = UILabel()
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
        viewModel.getStageDetail()
    }
    
    @objc
    private func handleContinueButton() {
        viewModel.moveOn()
    }
    
    private func setup() {
        setupSuperView()
        setupHeaderLabel()
        setupContinueButton()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .white
    }
    
    private func setupHeaderLabel() {
        view.addSubview(headerLabel)
        
        headerLabel.textColor = .white
        headerLabel.font = UIFont.systemFont(ofSize: 40)
        headerLabel.textAlignment = .center
        headerLabel.numberOfLines = 0
        headerLabel.backgroundColor = .black
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.bounds.height * 0.25)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.width.equalToSuperview()
        }
    }
    
    private func setupContinueButton() {
        view.addSubview(continueButton)
        
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = .black
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        continueButton.addTarget(self, action: #selector(handleContinueButton), for: .touchUpInside)
        
        continueButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview()
            make.top.equalTo(headerLabel.snp.bottom).offset(view.bounds.height * 0.25)
        }
    }
}

private extension StartViewController {
    func bindViewModel() {
        viewModel.didUpdateHeader = { [weak self] header in
            self?.headerLabel.text = header
        }
        
        viewModel.didUpdateTitle = { [weak self] title in
            self?.continueButton.setTitle(title, for: .normal)
        }
    }
}
