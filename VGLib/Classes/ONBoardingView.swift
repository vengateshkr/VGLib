//
//  ONBoardingView.swift
//  DMOnBoarding
//
//  Created by Venkatesh on 07/07/18.
//  Copyright © 2018 Venkatesh. All rights reserved.
//

import UIKit

protocol ONBoardingViewDelegate {
    func buttonClicked()
}

class ONBoardingView: UIView {
    
    var delegate : ONBoardingViewDelegate?
    
    var scrollView : UIScrollView! = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required init(targetView : UIView, numberOfPages : Int) {
        super.init(frame: UIScreen.main.bounds)
        
        targetView.backgroundColor = .red
        targetView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.frame = CGRect(x: 0, y: 0, width: targetView.frame.width, height: targetView.frame.height)
        targetView.addSubview(scrollView)
        
        scrollView?.leftAnchor.constraint(equalTo: targetView.leftAnchor, constant: 30).isActive = true
        scrollView?.rightAnchor.constraint(equalTo: targetView.rightAnchor, constant: -30).isActive = true
        scrollView?.topAnchor.constraint(equalTo: targetView.topAnchor, constant: 60).isActive = true
        scrollView?.bottomAnchor.constraint(equalTo: targetView.bottomAnchor, constant: -60).isActive = true
        scrollView?.setNeedsLayout()
        scrollView?.layoutIfNeeded()
        scrollView?.contentSize = CGSize(width: (scrollView?.frame.width)! * CGFloat(numberOfPages), height: (scrollView?.frame.height)!)
        
        for i in 0...numberOfPages - 1 {
            layoutViews(numberOfPages, i)
        }
    }
    
    
    //MARK: - UI Custom Methods
    
    fileprivate func createPageCtrl(_ numberOfPages: Int, _ i: Int) -> UIPageControl {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        pageControl.numberOfPages = numberOfPages
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .green
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPage = i
        return pageControl
    }
    
    
    fileprivate func createCircleImageView(_ numberOfPages: Int, _ i: Int) -> UIImageView {
        let circleView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        circleView.layer.borderColor = UIColor.green.cgColor
        circleView.layer.borderWidth = 3.0
        circleView.backgroundColor = .white
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.layer.cornerRadius = circleView.frame.width / 2.0
        return circleView
    }
    
    
    fileprivate func createContainerView(_ numberOfPages: Int, _ i: Int) -> UIView {
        var frame : CGRect = CGRect()
        frame.origin.x = scrollView!.frame.width * CGFloat(i)
        frame.origin.y = 0
        frame.size = scrollView!.frame.size
        let containerView = UIView(frame: frame)
        containerView.backgroundColor = .white
        return containerView
    }
    
    
    fileprivate func createTitleLabel(_ numberOfPages: Int, _ i: Int) -> UILabel {
        
        let lbl = UILabel()
        lbl.backgroundColor = .clear
        lbl.textColor = .black
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.text = ONBoardingAttributes.titles[i]
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
    
    fileprivate func createDescriptionLabel(_ numberOfPages: Int, _ i: Int) -> UILabel {
        
        let lbl = UILabel()
        lbl.backgroundColor = .clear
        lbl.textColor = .black
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.text = ONBoardingAttributes.descriptions[i]
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
    
    
    fileprivate func createButton(_ numberOfPages: Int, _ i: Int) -> UIButton {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        if i == numberOfPages - 1 {
            button.setTitle(ONBoardingAttributes.lastPageBtnTitle, for: .normal)
            button.backgroundColor = .green
            button.setTitleColor(.white, for: .normal)
        }
        else {
            button.setTitle(ONBoardingAttributes.btnTitle, for: .normal)
            button.backgroundColor = .clear
            button.setTitleColor(.green, for: .normal)
        }
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(onbViewbuttonAction(_:)), for: .touchUpInside)
        return button
    }
    
    fileprivate func layoutViews(_ numberOfPages: Int, _ i: Int) {
        
        let pageControl = createPageCtrl(numberOfPages, i)
        let circleView = createCircleImageView(numberOfPages, i)
        let containerView = createContainerView(numberOfPages, i)
        let button = createButton(numberOfPages, i)
        let titleLbl = createTitleLabel(numberOfPages, i)
        let descLbl = createDescriptionLabel(numberOfPages, i)
        
        scrollView?.addSubview(containerView)
        containerView.addSubview(circleView)
        containerView.addSubview(titleLbl)
        containerView.addSubview(descLbl)
        containerView.addSubview(pageControl)
        containerView.addSubview(button)
        
        circleView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 110).isActive = true
        circleView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        circleView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        titleLbl.topAnchor.constraint(equalTo: circleView.topAnchor, constant: 120).isActive = true
        titleLbl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        titleLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titleLbl.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        descLbl.topAnchor.constraint(equalTo: titleLbl.topAnchor, constant: 100).isActive = true
        descLbl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        descLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        descLbl.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        pageControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        pageControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -60).isActive = true
        
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 30).isActive = true
        button.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -30).isActive = true
        button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
    }
    
    
    @objc func onbViewbuttonAction(_ sender: UIButton!) {
        //
    }
    
}
