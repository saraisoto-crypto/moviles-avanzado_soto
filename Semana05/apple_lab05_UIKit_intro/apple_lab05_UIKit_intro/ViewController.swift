//
//  ViewController.swift
//  Semana05_Desarrollo
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!

    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "Introduce tu Peso y Altura"
    }

    @IBAction func CalcularResultado(_ sender: Any) {
        // Obtener los valores de peso y altura
        let weight = Double(weightTextField.text ?? "") ?? 0
        let height = Double(heightTextField.text ?? "") ?? 0

        // Verificar si los valores de entrada son válidos
        if weight == 0 || height == 0 {
            resultLabel.text = "Por favor, ingresa valores válidos."
            return
        }

        // Calcular el IMC (usamos la fórmula estándar)
        let bmi = weight / (height * height)

        // Determinar si el peso es adecuado según el IMC
        var status = ""
        if bmi < 18.5 {
            status = "Bajo peso"
        } else if bmi < 25 {
            status = "Peso normal"
        } else if bmi < 30 {
            status = "Sobrepeso"
        } else {
            status = "Obesidad"
        }

        // Mostrar el resultado
        resultLabel.text = "IMC: \(String(format: "%.2f", bmi)) - \(status)"
    }
}
