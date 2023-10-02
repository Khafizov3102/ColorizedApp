//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Денис Хафизов on 30.09.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    @IBOutlet weak var redColorValue: UILabel!
    @IBOutlet weak var greenColorValue: UILabel!
    @IBOutlet weak var blueColorValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 10
        
        setupSlider()
    }
    
    @IBAction func redColorSliderAction() {
        redColorValue.text = String(format: "%.1f", redColorSlider.value)
        
        changeColor()
    }
    
    @IBAction func greenColorSliderAction() {
        greenColorValue.text = String(format: "%.1f", greenColorSlider.value)
        
        changeColor()
    }
    
    @IBAction func blueColorSliderAction() {
        blueColorValue.text = String(format: "%.1f", blueColorSlider.value)
        
        changeColor()
    }
    
    private func setupSlider() {
        redColorSlider.value = 0
        greenColorSlider.value = 0
        blueColorSlider.value = 0
        
        redColorSlider.minimumTrackTintColor = .red
        greenColorSlider.minimumTrackTintColor = .green
        blueColorSlider.minimumTrackTintColor = .blue
        
        colorView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
    }
    
    private func changeColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
    }
}

