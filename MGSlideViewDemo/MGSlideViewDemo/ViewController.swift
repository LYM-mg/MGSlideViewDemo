//
//  ViewController.swift
//  MGSlideViewDemo
//
//  Created by ming on 16/6/5.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

let MGScreenWidth = UIScreen.mainScreen().bounds.width
let MGScreenHeight = UIScreen.mainScreen().bounds.height
let offsetDetailRight:CGFloat = 90
let offsetMainRight:CGFloat = 320


class ViewController: UIViewController,UIGestureRecognizerDelegate {

    
    var detailView: UIView?
    var coverView: UIView?
    var mainView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpChildrenView()
        
        setupGestureRecognizer()
    }
    
    // 创建右边的控制器
    func setUpChildrenView(){
        let detailViewController = MGDetailViewController()
        self.addChildViewController(detailViewController)
        detailViewController.view.frame = CGRectMake(-offsetDetailRight,self.view.frame.origin.y, self.view.frame.width, self.view.frame.height)
        self.view.addSubview(detailViewController.view)
        self.detailView = detailViewController.view
        
        let mainViewController = MGMainTViewController()
        self.addChildViewController(mainViewController)

        mainViewController.view.frame = self.view.bounds
        self.view.addSubview(mainViewController.view)
        self.mainView = mainViewController.view;
        self.mainView!.backgroundColor = UIColor.greenColor()
        self.mainView!.addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.Old, context: nil)
        
        // 添加coverView
        let coverView = UIView()
        coverView.frame = self.mainView!.frame
        coverView.hidden = true
        coverView.alpha = 0.9
        self.mainView!.addSubview(coverView)
        self.coverView = coverView;
        let tap = UITapGestureRecognizer(target: self, action: Selector("tap"))
        self.coverView?.addGestureRecognizer(tap)
    }
    

    func tap(){
        if self.mainView!.frame.origin.x != 0 {
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                
                self.mainView!.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height);
                self.detailView!.frame = CGRectMake(-offsetDetailRight, self.view.frame.origin.y, self.view.frame.width, self.view.frame.height);
                });
        }
    }
    // KVO 监听mainView的frame的变化
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if self.mainView!.frame.origin.x == offsetMainRight {
            self.coverView?.hidden = false;
        } else {
            self.coverView?.hidden = true;
        }
    }
    
    // 添加pan手势
    func setupGestureRecognizer(){
        let pan = UIPanGestureRecognizer(target: self, action: Selector("pan:"))
//        pan.delegate = self;
        self.mainView!.addGestureRecognizer(pan)
    }
    func pan(pan:UIPanGestureRecognizer){
        let transP = pan.translationInView(self.view)
        
        self.mainView!.frame = mainFrameWithoffsetX(transP.x)
        pan.setTranslation(CGPointZero, inView: self.mainView!)
        
        self.detailView!.frame = detailFrameWithoffsetX(transP.x)
        pan.setTranslation(CGPointZero, inView: self.detailView!)
        
        
        if pan.state == UIGestureRecognizerState.Ended {
            var targetMain:CGFloat = 0
            var targetDetail:CGFloat = offsetDetailRight
            if (self.mainView!.frame.origin.x > MGScreenWidth * 0.5) {
                targetMain = offsetMainRight
                targetDetail = 0;
            }
            
            let offsetMainX:CGFloat = targetMain - self.mainView!.frame.origin.x
            let offsetDetailX:CGFloat = -targetDetail
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.mainView!.frame = self.mainFrameWithoffsetX(offsetMainX)
                self.detailView!.frame = CGRectMake(offsetDetailX, 0, self.view.frame.width, self.view.frame.height)
            })
        }
    }
    
    // 返回主View的frame
    func mainFrameWithoffsetX(offsetX: CGFloat) -> CGRect{
        var frame = self.mainView!.frame
        frame.origin.x += offsetX
        if frame.origin.x <= 0 {
            frame.origin.x = 0
        }
        return frame
    }
    
    // 返回detailView的frame
    func detailFrameWithoffsetX(offsetX: CGFloat) -> CGRect{
        var frame = self.detailView?.frame
        frame!.origin.x += (offsetX * offsetDetailRight / offsetMainRight)
        if frame!.origin.x >= 0 {
            frame!.origin.x = 0
        }
        return frame!
    }
    
    
    // MARK: - UIGestureRecognizerDelegate
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

