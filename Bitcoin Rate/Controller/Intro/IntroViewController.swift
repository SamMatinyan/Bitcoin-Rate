//
//  IntroViewController.swift
//  Bitcoin Rate
//
//  Created by Apple on 12.05.21.
//  Copyright © 2021 ForZa. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var pageViewController: PageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(pageControl)
        pageControl.currentPage = 0
        //pageControl.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
    }
    
    @IBAction func pageControlValueChanged(_ sender: UIPageControl) {
        pageViewController.setViewControllers([pageViewController.getPages()[pageControl.currentPage]],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "infoPagesSeg" {
            pageViewController = (segue.destination as! PageViewController)
        }
    }
}
