//
//  LaunchScreenViewController.swift
//  GetDirections
//
//  Created by Luis Puentes on 7/26/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(transitionFromLaunchScreenToMainScreen), userInfo: nil, repeats: false)
    }
    
    func transitionFromLaunchScreenToMainScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainView")
        self.present(nextViewController, animated: true, completion: nil)
    }
}
