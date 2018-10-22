//
//  HistoryViewController.swift
//  simple-calc
//
//  Created by Jue Chen on 10/22/18.
//  Copyright © 2018 Jue Chen. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
  
  var history: [String] = []
  
  @IBOutlet weak var historyText: UILabel!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    var currentText = ""
    for item in history {
      currentText = currentText + item + "\n"
    }
    historyText.text = currentText
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "historyToMain" {
      let mainVC = segue.destination as! ViewController
      mainVC.history = history
    }
  }
}
