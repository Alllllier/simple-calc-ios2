//
//  ViewController.swift
//  simple-calc
//
//  Created by Jue Chen on 10/16/18.
//  Copyright © 2018 Jue Chen. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    displayField.text = ""
  }
  
  @IBOutlet weak var displayField: UILabel!
  var nums: [Double] = []
  var oper = 0
  var currentNum = ""
  var resulted = false
  var rpn = false
  var history: [String] = []
  
  @IBAction func rpnSwitch(_ sender: UISwitch) {
    rpn = sender.isOn
    setResult("")
  }
  
  @IBAction func enterClick(_ sender: Any) {
    if (rpn) {
      if (currentNum != "") {
        nums.append(Double(currentNum) ?? 0)
        currentNum = ""
      }
      addToDisplay(" ")
    }
  }
  
  @IBAction func numClick(_ sender: UIButton) {
    if (resulted) {
      displayField.text = ""
      resulted = false
    }
    var num = ""
    if sender.tag == 10 {
      num += "."
    } else{
      num += String(sender.tag)
    }
    addToDisplay(num)
    currentNum += num
  }
  
  @IBAction func operClick(_ sender: UIButton) {
    if (resulted) {
      displayField.text = ""
      resulted = false
    }
    if (currentNum != "") {
      nums.append(Double(currentNum) ?? 0)
      currentNum = ""
    }
    
    oper = sender.tag
    switch oper {
    case 1:
      addToDisplay("+")
    case 2:
      addToDisplay("-")
    case 3:
      addToDisplay("*")
    case 4:
      addToDisplay("/")
    case 5:
      addToDisplay("%")
    case 6:
      addToDisplay("AVG")
    case 7:
      addToDisplay("COUNT")
    case 8:
      addToDisplay("FACT")
    default:
      return
    }
  }
  
  @IBAction func calculateResult(_ sender: Any) {
    if currentNum != "" {
      if let num = Double(currentNum) {
        nums.append(num)
      }
    }
    
    var result: Double  = 0
    if 1...5 ~= oper {
      let num1 = nums[0]
      let num2 = nums[1]
      switch oper {
      case 1:
        result = num1 + num2
      case 2:
        result = num1 - num2
      case 3:
        result = num1 * num2
      case 4:
        result = num1 / num2
      case 5:
        result = num1.truncatingRemainder(dividingBy: num2)
      default:
        result = 0
      }
    } else {
      switch oper {
      case 6:
        for num in nums {
          result += num
        }
        result /= Double(nums.count)
      case 7:
        result = Double(nums.count)
      case 8:
        if nums.count == 1 {
          result = Double(factorial(Int(floor(nums[0]))))
        } else {
          setResult("Error！")
        }
      default:
        result = 0
      }
    }
    setResult(String(result))
  }
  
  func factorial(_ n: Int) -> Int {
    if n == 0 {
      return 1
    }
    else {
      return n * factorial(n - 1)
    }
  }
  
  func addToDisplay(_ str: String) {
    let currentText = displayField.text ?? ""
    displayField.text = currentText + str
  }
  
  func setResult(_ result: String) {
    var currentResult = (displayField.text ?? "") + " = "
    currentResult += result
    history.append(currentResult)
    nums = []
    oper = 0
    currentNum = ""
    resulted = true
    displayField.text = result
  }
  
  @IBAction func clear(_ sender: Any) {
    setResult("")
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "mainToHistory" {
      let historyVC = segue.destination as! HistoryViewController
      historyVC.history = history
    }
  }
}
