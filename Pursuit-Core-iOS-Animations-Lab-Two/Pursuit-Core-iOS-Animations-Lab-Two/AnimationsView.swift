//
//  AnimationsView.swift
//  Pursuit-Core-iOS-Animations-Lab-Two
//
//  Created by Bienbenido Angeles on 2/12/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import UIKit

class AnimationsView: UIView {

    lazy var linearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Linear", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(hideObject(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var easeInButton: UIButton = {
         let button = UIButton()
         button.setTitle("Ease In", for: .normal)
         button.setTitleColor(.systemBlue, for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(hideObject(_:)), for: .touchUpInside)
         return button
     }()
    
    lazy var easeOutButton: UIButton = {
         let button = UIButton()
         button.setTitle("Ease Out", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.tag = 2
        button.addTarget(self, action: #selector(hideObject(_:)), for: .touchUpInside)
         return button
     }()

    lazy var easeInOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ease InOut", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.tag = 3
        button.addTarget(self, action: #selector(hideObject(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [linearButton, easeInButton, easeOutButton, easeInOutButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var object1: UIImageView = {
        let width = self.bounds.width * 0.2
        
        let imageView = UIImageView(image: UIImage(named: "beach-ball")?.resizeImage(to: width, height: width))
        return imageView
    }()
    
    lazy var object2: UIImageView = {
        let width = self.bounds.width * 0.2
        let imageView = UIImageView(image: UIImage(named: "beach-ball")?.resizeImage(to: width, height: width))
        return imageView
    }()
    
    lazy var object3: UIImageView = {
        let width = self.bounds.width * 0.2

        let imageView = UIImageView(image: UIImage(named: "beach-ball")?.resizeImage(to: width, height: width))
        return imageView
    }()
    
    lazy var object4: UIImageView = {
        let width = self.bounds.width * 0.2

        let imageView = UIImageView(image: UIImage(named: "beach-ball")?.resizeImage(to: width, height: width))
        return imageView
    }()
    
    lazy var objects: [UIImageView] = {
        var objects = [object1, object2, object3, object4]
        return objects
    }()
    
    lazy var resetButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Reset", style: UIBarButtonItem.Style.plain, target: self, action: #selector(resetButtonPressed))
        return button
    }()
    
    lazy var animateButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Animate", style: UIBarButtonItem.Style.plain, target: self, action: #selector(animateButtonPressed))
        return button
    }()
    
    lazy var flexibleSpaceButton: UIBarButtonItem = {
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        return space
    }()

    
    lazy var toolBar: UIToolbar = {
       let toolbar = UIToolbar()
        toolbar.items = [resetButton, flexibleSpaceButton, animateButton]
        return toolbar
    }()
                
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    @objc
    private func hideObject(_ button: UIButton){
        objects[button.tag].isHidden.toggle()
    }
    
    @objc
    private func resetButtonPressed(){
        let animationDistance: CGFloat = self.bounds.height * 0.6
            
        for (index, object) in self.objects.enumerated(){

            UIView.transition(with: object, duration: 1, options: self.indexToAnimOptions(index: index), animations: {
                [unowned self] in
                object.constraintsAffectingLayout(for: .vertical)[2].constant -= animationDistance
                self.layoutIfNeeded()
            }, completion: nil)
            
        }
    }
    
    @objc private func animateButtonPressed(){
        
        let animationDistance: CGFloat = self.bounds.height * 0.6
            
        for (index, object) in self.objects.enumerated(){

            UIView.transition(with: object, duration: 5, options: self.indexToAnimOptions(index: index), animations: {
                [unowned self] in
                object.constraintsAffectingLayout(for: .vertical)[2].constant += animationDistance
                self.layoutIfNeeded()
            }, completion: nil)
            
        }
    }
    
    private func indexToAnimOptions(index: Int) -> UIView.AnimationOptions{
        let options = [UIView.AnimationOptions.curveLinear, AnimationOptions.curveEaseIn, AnimationOptions.curveEaseOut, AnimationOptions.curveEaseInOut]
        return options[index]
    }
    
    private func commonInit(){
        setupStackViewConstrainsts()
        setupObjectsConstraints()
        setupToolBarConstraints()
    }
    
    private func setupStackViewConstrainsts(){
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            stackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
        ])
    }
    
    private func setupObjectsConstraints(){
        objects.forEach{addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false;}
        for (index, object) in objects.enumerated(){
            NSLayoutConstraint.activate([
                object.centerYAnchor.constraint(equalTo: stackView.subviews[index].centerYAnchor, constant: object.frame.height),
                object.centerXAnchor.constraint(equalTo: stackView.subviews[index].centerXAnchor),
                object.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
                object.widthAnchor.constraint(equalTo: object.heightAnchor, multiplier: 1)
            ])
        }
    }
    
    private func setupToolBarConstraints(){
        addSubview(toolBar)
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            toolBar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension UIImage {
    func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
