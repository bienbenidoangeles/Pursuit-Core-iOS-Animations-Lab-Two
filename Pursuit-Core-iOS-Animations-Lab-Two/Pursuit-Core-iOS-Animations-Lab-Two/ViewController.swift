//
//  ViewController.swift
//  Pursuit-Core-iOS-Animations-Lab-Two
//
//  Created by Bienbenido Angeles on 2/12/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let animationsView = AnimationsView()
    
    override func loadView() {
        view = animationsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

}

