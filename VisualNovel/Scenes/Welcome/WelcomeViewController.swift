//
//  WelcomeViewController.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 19.03.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private var viewModel: WelcomeViewModelType
    
    init(with viewModel: WelcomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSuperView()
        bindViewModel()
    }

    private func setup() {
        setupSuperView()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .green
    }
}

private extension WelcomeViewController {
    func bindViewModel() {
        
    }
}
