//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Денис Хафизов on 18.10.2023.
//

import UIKit

class MainViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingsViewController else { return }
        settingVC.mainViewColor = view.backgroundColor ?? UIColor.white
        settingVC.delegate = self
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func sendColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
