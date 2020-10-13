//
//  ViewController.swift
//  Swift-tvOSFocusProject
//
//  Created by narendra. vadde on 12/10/20.
//  Copyright © 2020 narendra. vadde. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var focusGuide: UIFocusGuide!
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [textField]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        focusGuide = UIFocusGuide()
        view.addLayoutGuide(focusGuide)
        
        focusGuide.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        focusGuide.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        focusGuide.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        focusGuide.preferredFocusEnvironments = [nextButton]
        
        restoresFocusAfterTransition = false
        
        if let focusView = UIScreen.main.focusedView {
            print(focusView)
        }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.previouslyFocusedView == textField {
            focusGuide.preferredFocusEnvironments = [nextButton]
        } else {
            focusGuide.preferredFocusEnvironments = [textField]
        }
        
        if context.nextFocusedView == textField {
            coordinator.addCoordinatedAnimations({
                self.textLabel.alpha = 1
            }, completion: nil)
            
        } else {
            coordinator.addCoordinatedAnimations({
                self.textLabel.alpha = 0
            }, completion: nil)
        }
    }

    @IBAction func showAlert(_ sender : UIButton) {
        let alert = UIAlertController(title: "Hello", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

