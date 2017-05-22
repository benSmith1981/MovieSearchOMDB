//
//  MainNavigation.swift
//  OMDB
//
//  Created by Ben Smith on 10/05/16.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit

class MainNavigation: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navigationBar.barTintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir", size: 18)!,
            NSForegroundColorAttributeName : Color.navigation.main]
        navigationController?.navigationBar.shadowImage = UIImage()
        
//        navigationBar.isTranslucent = false
        navigationBar.clipsToBounds = false
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
