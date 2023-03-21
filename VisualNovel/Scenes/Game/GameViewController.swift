//
//  GameViewController.swift
//  VisualNovel
//
//  Created by Ivan Semenov on 20.03.2023.
//

import UIKit

class GameViewController: UIViewController {

    private var viewModel: GameViewModelType
    
    init(with viewModel: GameViewModelType) {
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
    
    private func setup() {
        setupSuperView()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .red
    }

}

private extension GameViewController {
    func bindViewModel() {
        viewModel.didUpdateHeader = { [weak self] header in
            print(header)
        }
        
        viewModel.didUpdateTitle = { [weak self] title in
            print(title)
        }
    }
}
