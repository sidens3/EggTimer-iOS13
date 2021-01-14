//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer?
    
    let eggTime = ["Soft" : 5 * 60, "Medium" : 7 * 60, "Hard" : 12 * 60]
    
    var totalTime : Float = 60
    var secondsPassed : Float = 0
    var timer = Timer()
    
    var persentagesProgress = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressBar.progress = 0
        screenTitle.text = "How do you like your eggs?"
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        guard let hardness = sender.currentTitle else { return }
        guard let cookingTimeByHardness = eggTime[hardness] else { return }
        
        startTimer(timeToWait: Float(cookingTimeByHardness))
    }
    
    func startTimer(timeToWait: Float){
        timer.invalidate()
        secondsPassed = 0
        progressBar.progress = 0
        screenTitle.text = "Eggs in progress"
        
        totalTime = timeToWait
    
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if secondsPassed != totalTime {
            secondsPassed += 1
            print("\(secondsPassed)" + "/" + "\(totalTime)" )
        } else {
            timer.invalidate()
            screenTitle.text = "Complete"
            playAlarm()
        }
        let persentProgress = secondsPassed / totalTime
        progressBar.progress = persentProgress
    }
    

    func playAlarm() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
