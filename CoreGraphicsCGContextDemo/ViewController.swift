//
//  ViewController.swift
//  CoreGraphicsCGContextDemo
//
//  Created by Jayden Garrick on 9/12/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properies
    let drawView: DrawView = {
        let dView = DrawView()
        dView.backgroundColor = .white
        return dView
    }()
    
    let clearButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setTitle("Erase", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let redButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    let greenButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    let blueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    let yellowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    var lastSelectedButton: UIButton!

    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        lastSelectedButton = redButton
        setupViews()
    }
    
    // MARK: - Setup
    func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.924549159, blue: 0.7879967056, alpha: 1)
        
        // Add Subview
        view.addSubview(drawView)
        view.addSubview(redButton)
        view.addSubview(blueButton)
        view.addSubview(greenButton)
        view.addSubview(yellowButton)
        view.addSubview(clearButton)
        
        let stackView = UIStackView(arrangedSubviews: [redButton, blueButton, greenButton, yellowButton, clearButton])
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        // Constraints
        drawView.translatesAutoresizingMaskIntoConstraints = false
        drawView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        drawView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        drawView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stackView.topAnchor.constraint(equalTo: drawView.bottomAnchor, constant: 8).isActive = true
    }

    // MARK: - Action Functions
    @objc func buttonTapped(sender: UIButton) {
        sender.layer.borderWidth = 3
        sender.layer.borderColor = UIColor.black.cgColor
        lastSelectedButton.layer.borderWidth = 0
        lastSelectedButton = sender
        guard let buttonColor = sender.backgroundColor else { return }
        drawView.strokeColor = buttonColor == .white ? UIColor.white.cgColor : buttonColor.cgColor
    }
}

