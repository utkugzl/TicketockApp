//
//  ViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 26.09.2023.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = true
        
        
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.pageIndicatorTintColor = .gray
        pageControl.isUserInteractionEnabled = false
 
        return pageControl
    }()
    
    private let onboardingButton = CustomButton(title: "Next", hasBackground: true, fontSize: .big)
    
    
    
    var slides = [
        OnboardingModel(title: "Welcome to Ticketock", description: "The best place to buy movies tickets. You can effortlessly book tickets for your favorite movies all from the comfort of your device. ", image: UIImage(named: "onboarding1")!),
        OnboardingModel(title: "Easy Ticket Booking", description: "Skip the queues and reserve your seats with just a few taps.We have the best prices", image: UIImage(named: "onboarding2")!),
        OnboardingModel(title: "Online Payment", description: "100% secure payments. Your payment information is protected with state-of-the-art encryption, ensuring your data remains confidential and secure.", image: UIImage(named: "onboarding3")!)
    ]
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                onboardingButton.setTitle("Get Started", for: .normal)
            } else {
                onboardingButton.setTitle("Next", for: .normal)
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    

    
    @objc func didTapOnboardingButton(_ sender: UIButton) {
        
        if currentPage == slides.count - 1 {
            let controller = LoginViewController()
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .partialCurl
            present(controller, animated: true)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.isPagingEnabled = false
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            collectionView.isPagingEnabled = true
        }

    }
    
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setup(slides[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}


// MARK: - Configurations

extension OnboardingViewController {

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        onboardingButton.frame = CGRect(
            x: 120,
            y: view.bottom - 100,
            width: view.width - 240,
            height: 50
        )
        
        pageControl.frame = CGRect(
            x: 30,
            y: onboardingButton.top - 40,
            width: view.width - 60,
            height: 25
        )
        
        collectionView.frame = CGRect(
            x: 0,
            y: view.top,
            width: view.width,
            height: view.height - 150
        )

    }
    
    
    private func configure() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(onboardingButton)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: OnboardingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        
        onboardingButton.addTarget(self, action: #selector(didTapOnboardingButton), for: .touchUpInside)
        
    }
}
