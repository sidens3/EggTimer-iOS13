//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var eggTime = ["Soft" : 5 * 60, "Medium" : 7 * 60, "Hard" : 12 * 60]
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        guard let hardness = sender.currentTitle else { return }
        guard let cookingTimeByHardness = eggTime[hardness] else { return }
        
        print(cookingTimeByHardness)
        startTimer(time: cookingTimeByHardness)
    }
    
    func startTimer(time: Int){
        var seconds = time

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            seconds -= 1
            if seconds == 0 {
                timer.invalidate()
            } else {
                print(seconds)
            }
        }
    }
}
