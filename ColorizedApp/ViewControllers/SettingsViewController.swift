//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Денис Хафизов on 30.09.2023.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func sendColor(_ color: UIColor)
}

final class SettingsViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    @IBOutlet weak var redColorValue: UILabel!
    @IBOutlet weak var greenColorValue: UILabel!
    @IBOutlet weak var blueColorValue: UILabel!
    
    @IBOutlet weak var redTF: UITextField!
    @IBOutlet weak var greenTF: UITextField!
    @IBOutlet weak var blueTF: UITextField!
    
    weak var delegate: SettingsViewControllerDelegate!
    
    var mainViewColor = UIColor.white
    var currentColor: CIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 10

        currentColor = CIColor(color: mainViewColor)
        setupSlider()
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func colorSliderAction(_ sender: UISlider) {
        if sender.tag == 0 {
            redColorValue.text = String(format: "%.1f", sender.value)
            redTF.text = String(format: "%.1f", sender.value)
        } else if sender.tag == 1 {
            greenColorValue.text = String(format: "%.1f", sender.value)
            greenTF.text = String(format: "%.1f", sender.value)
        } else {
            blueColorValue.text = String(format: "%.1f", sender.value)
            blueTF.text = String(format: "%.1f", sender.value)
        }
    }
    
    @IBAction func doneButtonPressed() {
        delegate.sendColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    private func setupSlider() {
        redColorSlider.value = Float(currentColor.red)
        greenColorSlider.value = Float(currentColor.green)
        blueColorSlider.value = Float(currentColor.blue)
        
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
    
    private func updateColorValue(textField: UITextField, slider: UISlider, label: UILabel) {
        guard let value = Float(textField.text ?? "0.5") else {
            slider.value = 0.5
            label.text = "0.5"
            textField.text = "0.5"
            setupAlert(title: "Неверное значение", message: "Введите корректное значение")
            return
        }
        
        if value > 1 || value < 1{
            setupAlert(title: "Неверное значение", message: "Введите число в пределах от -1 до 1")
            slider.value = 0.5
            label.text = "0.5"
            textField.text = "0.5"
        } else {
            slider.value = value
            label.text = String(value)
            changeColor()
        }
    }
    
    private func setupAlert(title: String, message: String?) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case redTF:
            updateColorValue(textField: textField, slider: redColorSlider, label: redColorValue)
        case greenTF:
            updateColorValue(textField: textField, slider: greenColorSlider, label: greenColorValue)
        default:
            updateColorValue(textField: textField, slider: blueColorSlider, label: blueColorValue)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
