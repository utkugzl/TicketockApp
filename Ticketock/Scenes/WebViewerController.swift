//
//  WebViewerController.swift
//  Ticketock
//
//  Created by Utku Güzel on 28.09.2023.
//

import UIKit
import WebKit

final class WebViewerController: UIViewController {
    
    private let webView = WKWebView()
    private let urlString: String
    
    init(with urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavBar()
        
        guard let url = URL(string: urlString) else {
            self.dismiss(animated: true)
            return
        }
        
        webView.load(URLRequest(url: url))
    }

}

// MARK: - Configurations

extension WebViewerController {
    
    private func configureUI()  {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureNavBar()  {
        navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView.frame = view.bounds
    }
}

// MARK: - Selectors

extension WebViewerController {
    
    @objc private func didTapDone() {
        dismiss(animated: true)
    }
    
}
