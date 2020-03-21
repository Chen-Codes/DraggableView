//
//  ViewController.swift
//  ChenCodesDraggableView
//
//  Created by Chen Codes on 3/21/20.
//  Copyright © 2020 Chen Codes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupPanGestureRecognizer()
    }
    
    private func setupViews() {
        view.addSubview(hoopView)
        view.addSubview(basketballView)
        hoopView.frame = .init(x: (view.frame.size.width/2) - 100,
                               y: 100,
                               width: Constant.hoopViewWidth,
                               height: Constant.hoopViewWidth)
        setupBasketballViewLayout()
    }
    
    private func setupBasketballViewLayout() {
        let size = view.frame.size
        basketballView.frame = .init(x: (size.width/2) - (Constant.basketballViewWidth/2),
                                     y: size.height - 200,
                                     width: Constant.basketballViewWidth,
                                     height: Constant.basketballViewWidth)
    }
    
    private func setupPanGestureRecognizer() {
        let panRecognizer = UIPanGestureRecognizer(target: self,
                                                   action: #selector(handlePan))
        basketballView.isUserInteractionEnabled = true
        basketballView.addGestureRecognizer(panRecognizer)
    }
    
    @objc private func handlePan(panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        panGesture.setTranslation(.zero, in: view)
        basketballView.center = CGPoint(x: basketballView.center.x + translation.x,
                                        y: basketballView.center.y + translation.y)
        if panGesture.state == .ended {
            detectMadeShot()
        }
    }
    
    private func detectMadeShot() {
        if (basketballView.frame.intersects(hoopView.frame)) {
            setupBasketballViewLayout()
        }
    }
    
    private let basketballView: UIImageView = {
        let basketballView = UIImageView(image: UIImage(named: "basketball"))
        basketballView.contentMode = .scaleAspectFit
        return basketballView
    }()
    
    private let hoopView: UIImageView = {
        let hoopView = UIImageView(image: UIImage(named: "hoop"))
        hoopView.contentMode = .scaleAspectFit
        return hoopView
    }()
    
    private enum Constant {
        static let basketballViewWidth: CGFloat = 100
        static let hoopViewWidth: CGFloat = 200
    }
}

