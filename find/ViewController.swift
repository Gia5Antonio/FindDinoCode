//
//  ViewController.swift
//  find
//
//  Created by Antonio Giaquinto on 20/02/2018.
//  Copyright © 2018 Antonio Giaquinto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewB: UIView!
    let numberOfButton = 130
    let numberOfTarget = 30
    let target = #imageLiteral(resourceName: "Target")
    let foundImage = #imageLiteral(resourceName: "TargetColorato")
    let nonTarget = [#imageLiteral(resourceName: "a"), #imageLiteral(resourceName: "b"), #imageLiteral(resourceName: "c"), #imageLiteral(resourceName: "d"), #imageLiteral(resourceName: "e"), #imageLiteral(resourceName: "f"), #imageLiteral(resourceName: "g"), #imageLiteral(resourceName: "h"), #imageLiteral(resourceName: "i"), #imageLiteral(resourceName: "l"), #imageLiteral(resourceName: "m"), #imageLiteral(resourceName: "n"), #imageLiteral(resourceName: "o"), #imageLiteral(resourceName: "p"), #imageLiteral(resourceName: "q"), #imageLiteral(resourceName: "r")]
    var newImage: UIImage!
    var point = 0
    var points30s = 0
    var points120s = 0
    var seconds = 0
    var timer = Timer()
    var isTimerRunning = false
    let button = UIButton(type: UIButtonType.system)
    var posX = [Int]()
    var posY = [Int]()
    var centerP = [CGPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runTimer()
        viewB.backgroundColor = .white
        
        for i in 0...numberOfButton - 1 {
        
            let button = UIButton(type: UIButtonType.system)
            let randomX = Int(arc4random_uniform(UInt32(((viewB.frame.width)-167) - button.frame.width)))
            let randomY = Int(arc4random_uniform(UInt32(((viewB.frame.height)-167) - button.frame.height)))
            
            posX.append(randomX)
            posY.append(randomY)
            
            control(randomXf: randomX, randomYf: randomY)

            button.frame = CGRect(x: randomX, y: randomY, width: 40, height: 40)
            //control(randomCenter: button.center)
            centerP.append(button.center)
//           debugPrint(centerP)
            let randomNumber = Int(arc4random_uniform((UInt32(nonTarget.count))))
            newImage = nonTarget[randomNumber]
            button.setBackgroundImage(newImage, for: UIControlState.normal)
            button.isEnabled = false
            
            // Add button to controller's view
            viewB.addSubview(button)
            debugPrint("\(i)")
        }
        
        for j in 0...numberOfTarget - 1 {
            
            let button = UIButton(type: UIButtonType.system)
            let randomX = Int(arc4random_uniform(UInt32(((viewB.frame.width)-167) - button.frame.width)))
            let randomY = Int(arc4random_uniform(UInt32(((viewB.frame.height)-167) - button.frame.height)))
            
            posX.append(randomX)
            posY.append(randomY)
            
            control(randomXf: randomX, randomYf: randomY)
            
            button.frame = CGRect(x: randomX, y: randomY, width: 40, height: 40)
            button.setBackgroundImage(target, for: UIControlState.normal)
            button.setBackgroundImage(foundImage, for: UIControlState.highlighted)
            button.tag = j
            // Add action to button
            button.addTarget(self, action: #selector(targetTapped), for: .touchUpInside)
            
            // Add button to controller's view
            viewB.addSubview(button)
            debugPrint("\(j)")
        }
    }
    
    func control(randomXf: Int, randomYf: Int){
        for x in posX {
            for y in posY {
                if abs(Float(randomYf - y)) < Float(button.frame.height) {
                    let randomX = Int(arc4random_uniform(UInt32(((viewB.frame.width)-167) - button.frame.width)))
                    let randomY = Int(arc4random_uniform(UInt32(((viewB.frame.height)-167) - button.frame.height)))
                    control(randomXf: randomX, randomYf: randomY)
                } else if abs(Float(randomXf - x)) < Float(button.frame.width) {
                    let randomX = Int(arc4random_uniform(UInt32(((viewB.frame.width)-167) - button.frame.width)))
                    let randomY = Int(arc4random_uniform(UInt32(((viewB.frame.height)-167) - button.frame.height)))
                    control(randomXf: randomX, randomYf: randomY)
                }
            }
        }
        return
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    func endTimer() {
        print("Restart ok")
        timer.invalidate()
        seconds = 0
        isTimerRunning = false
    }
    
    @objc func updateTimer(){
        seconds += 1
        //debugPrint(seconds)
        
        if seconds == 30 {
            points30s = point
            debugPrint("Points 30s: \(points30s)")
        }
        
        if seconds == 120 {
            points120s = point
            debugPrint("Points 120s: \(points120s)")
        }
        
        if point == 30 {
            endTimer()
        }
    }
    
    //MARK: - Actions and Selectors
    @IBAction func targetTapped(sender:UIButton){
        print("Target is tapped \(sender.tag)")
        sender.isEnabled = false
        sender.setBackgroundImage(foundImage, for: .normal)
        point += 1
    }
}
