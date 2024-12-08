//
//  SplashVC.swift
//  Beyond Fit
//
//  Created by Andrew on 03/10/2021.
//

import UIKit

class SplashVC: UIViewController {
    
    // MARK:- Enum
    enum ScrollDirection {
        case right, left
    }
    
    // MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var firstIndicator: UIView!
    @IBOutlet weak var secondIndicator: UIView!
    @IBOutlet weak var thirdIndicator: UIView!
    @IBOutlet weak var getStartedButton: UIButton!
    
    // MARK:- Properties
    private var collectionViewDidLayedout = false
    private var scrollDirection: ScrollDirection = .right
    private var currentItemIndex = 0
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getStartedButton.layer.cornerRadius = 16
        getStartedButton.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
        firstIndicator.layer.cornerRadius = 6
        secondIndicator.layer.cornerRadius = 6
        thirdIndicator.layer.cornerRadius = 6
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard collectionViewDidLayedout == false else { return }
        collectionViewDidLayedout = true
        setupCollectionView()
    }
}

// MARK:- Private Methods
extension SplashVC {
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "SplashCell", bundle: nil), forCellWithReuseIdentifier: "SplashCell")
        let layout = CustomFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        layout.itemSize = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = .zero
    }
    
    @objc private func getStartedTapped() {
        let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "HomeVC")
        let homeNav = UINavigationController(rootViewController: homeVC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = homeNav
    }
}

// MARK:- CollectionView Delegate
extension SplashVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SplashCell", for: indexPath) as! SplashCell
        switch indexPath.item {
        case 0:
            cell.configure(image: "Beyond Fit-01 copy", title: "Welcome to Beyond Fit", subtitle: "Where you can go beyond what you can do!")
        case 1:
            cell.configure(image: "Full Body", title: "All exercises in one place!", subtitle: "We will provide updates for you're needs at the gym and home.")
        default:
            cell.configure(image: "Beyond Fit-01 copy", title: "Keep the app updated!", subtitle: "We will notify you when any updates have been made and new workouts have been put in to help you out!")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == 2 {
            scrollDirection = .left
        } else {
            scrollDirection = .right
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            firstIndicator.backgroundColor = .lightGray
            secondIndicator.backgroundColor = .label
            currentItemIndex = 1
        case 1:
            secondIndicator.backgroundColor = .lightGray
            if scrollDirection == .left {
                thirdIndicator.backgroundColor = .label
                currentItemIndex = 2
            } else {
                guard collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) != nil else { return }
                firstIndicator.backgroundColor = .label
                currentItemIndex = 0
            }
        case 2:
            thirdIndicator.backgroundColor = .lightGray
            secondIndicator.backgroundColor = .label
            currentItemIndex = 1
        default:
            break
        }
    }
    
}


final class CustomFlowLayout: UICollectionViewFlowLayout {
    
    let cellSpacing: CGFloat = 0
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let attributes = super.layoutAttributesForElements(in: rect) {
            for (index, attribute) in attributes.enumerated() {
                if index == 0 { continue }
                let prevLayoutAttributes = attributes[index - 1]
                let origin = prevLayoutAttributes.frame.maxX
                if (origin + cellSpacing + attribute.frame.size.width < self.collectionViewContentSize.width) {
                    attribute.frame.origin.x = origin + cellSpacing
                }
            }
            return attributes
        }
        return nil
    }
    
}
