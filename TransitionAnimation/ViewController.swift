//
//  ViewController.swift
//  TransitionAnimation
//
//  Created by Cary Zhou on 9/10/19.
//  Copyright © 2019 Cary Zhou. All rights reserved.
//

import UIKit

let green = UIColor(red: 66/255, green: 245/255, blue: 185/255, alpha: 1)
let red = UIColor(red: 255/255, green: 84/255, blue: 84/255, alpha: 1)

class ViewController: UIViewController {

    @IBAction func tapped(_ sender: UIButton) {
        let buttonvc = ButtonViewController(number: 0)

        // TODO: - Update `defaultAnimation` field
        let navController = AnimatedNavigationController(rootViewController: buttonvc,
                                                         defaultAnimation: .native)
        present(navController, animated: true)
    }
}


class ButtonViewController: UIViewController {

    var number: Int!

    convenience init(number: Int) {
        self.init()
        self.number = number
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    // MARK: - Actions - the juicy bits
    @objc func doneAction() {
        self.navigationController?.dismiss(animated: true)
    }

    @objc func nativePush() {
        let navController = navigationController as! AnimatedNavigationController
        let buttonvc = ButtonViewController(number: number + 1)
        navController.pushViewController(buttonvc, animated: true)

    }

    @objc func customPush() {
        let navController = navigationController as! AnimatedNavigationController
        let buttonvc = ButtonViewController(number: number + 1)
        navController.pushViewController(buttonvc, using: .fade)
    }

    // MARK: - ViewConfiguration
    private func configureViews() {
        view.backgroundColor = number % 2 == 0 ? green : red
        view.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.title = "VC #\(String(describing: number!))"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))

        let nativeButton = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 50))
        nativeButton.addTarget(self, action: #selector(nativePush), for: .touchUpInside)
        nativeButton.setTitle("Default", for: .normal)
        nativeButton.setTitleColor(.blue, for: .normal)
        nativeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

        let customButton = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 50))
        customButton.addTarget(self, action: #selector(customPush), for: .touchUpInside)
        customButton.setTitle("Custom", for: .normal)
        customButton.setTitleColor(.purple, for: .normal)
        customButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

        let stack = UIStackView(frame: CGRect(x: 100, y: 200, width: 100, height: 50))
        view.addSubview(stack)
        stack.center = view.center
        stack.axis = .vertical
        stack.addArrangedSubview(nativeButton)
        stack.addArrangedSubview(customButton)
    }

    deinit {
        print("🌈 deinit VC#\(number!)")
    }
}
