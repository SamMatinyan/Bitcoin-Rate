//
//  PageViewController.swift
//  Bitcoin Rate
//
//  Created by Apple on 12.05.21.
//  Copyright © 2021 ForZa. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    private var storyboardIDs = [""]
    private var pages = [UIViewController]()
    private var pageControleSubviews = [UIPageControl]()
    
    private var currentIndex: Int {
        if let visibleViewController = viewControllers?.first,
           let curIndex = pages.firstIndex(of: visibleViewController) {
            return curIndex
        } else {
            return 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        for id in storyboardIDs {
            let vc = storyboard?.instantiateViewController(identifier: id)
            guard let safeVc = vc else { return }
            pages.append(safeVc)
        }
        setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
    }
    
    func getPages() -> [UIViewController] {
        return pages
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard currentIndex != 0 else { return nil }
        let prev = (currentIndex - 1)
        return pages[prev]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard currentIndex != pages.count - 1 else { return nil }
        let next = currentIndex + 1
        return pages[next]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let mainParent = parent as? IntroViewController
        
        if finished {
            //mainParent.pageControl.currentPage = currentIndex
        } else {
            //mainParent.pageControl.currentPage = currentIndex - 1
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let mainParent = parent as? IntroViewController
        let firstPendingVC = pendingViewControllers[0]
        //Changing pageControl's currentPage index in the 'didFinishAnimating' method will cause a small delay
        //mainParent.pageControl.currentPage = pages.firstIndex(of: firstPendingVC)
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
}
