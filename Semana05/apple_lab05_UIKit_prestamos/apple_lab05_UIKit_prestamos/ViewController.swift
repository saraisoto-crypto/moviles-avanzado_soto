//
//  ViewController.swift
//  Calculadora de Préstamos
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var capitalTextField: UITextField!
    @IBOutlet weak var rateTextField: UITextField!
    @IBOutlet weak var yearsTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!

    // MARK: - Paleta de colores
    private let primaryColor = UIColor(red: 0.29, green: 0.25, blue: 0.80, alpha: 1.0)
    private let backgroundColor = UIColor(red: 0.93, green: 0.94, blue: 1.00, alpha: 1.0)
    private let successColor = UIColor(red: 0.85, green: 0.96, blue: 0.88, alpha: 1.0)
    private let successText = UIColor(red: 0.07, green: 0.40, blue: 0.20, alpha: 1.0)
    private let errorColor = UIColor(red: 1.00, green: 0.88, blue: 0.88, alpha: 1.0)
    private let errorText = UIColor(red: 0.70, green: 0.10, blue: 0.10, alpha: 1.0)

    // MARK: - Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        configurarTitulo()
        configurarCampos()
        configurarBoton()
        configurarResultado()

        let tap = UITapGestureRecognizer(target: self, action: #selector(cerrarTeclado))
        view.addGestureRecognizer(tap)
    }

    // MARK: - Estilos
    private func configurarTitulo() {
        titleLabel.text = "💰 Calculadora de Préstamos"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = .white
        titleLabel.backgroundColor = primaryColor
        titleLabel.textAlignment = .center
        titleLabel.layer.cornerRadius = 12
        titleLabel.clipsToBounds = true
    }

    private func configurarCampos() {
        let campos: [(UITextField, String)] = [
            (capitalTextField, "Ej: 10000"),
            (rateTextField, "Ej: 12"),
            (yearsTextField, "Ej: 2")
        ]
        for (campo, texto) in campos {
            campo.placeholder = texto
            campo.keyboardType = .decimalPad
            campo.borderStyle = .roundedRect
            campo.backgroundColor = .white
            campo.textAlignment = .center
            campo.layer.cornerRadius = 8
            campo.layer.borderWidth = 1.5
            campo.layer.borderColor = primaryColor.cgColor
        }
    }

    private func configurarBoton() {
        var config = UIButton.Configuration.filled()
        config.title = "Calcular préstamo"
        config.image = UIImage(systemName: "plus.forwardslash.minus")
        config.imagePadding = 8
        config.baseBackgroundColor = primaryColor
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        calculateButton.configuration = config
    }

    private func configurarResultado() {
        resultLabel.text = "Introduce capital, tasa y plazo"
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        resultLabel.textColor = primaryColor
        resultLabel.backgroundColor = .white
        resultLabel.layer.cornerRadius = 12
        resultLabel.layer.borderWidth = 1.5
        resultLabel.layer.borderColor = primaryColor.cgColor
        resultLabel.clipsToBounds = true
    }

    private func mostrarError(_ mensaje: String) {
        resultLabel.text = "⚠️ " + mensaje
        resultLabel.textColor = errorText
        resultLabel.backgroundColor = errorColor
        resultLabel.layer.borderColor = errorText.cgColor
    }

    private func mostrarExito(_ mensaje: String) {
        resultLabel.text = mensaje
        resultLabel.textColor = successText
        resultLabel.backgroundColor = successColor
        resultLabel.layer.borderColor = successText.cgColor
    }

    // MARK: - Utilidades
    @objc private func cerrarTeclado() {
        view.endEditing(true)
    }

    private func leerNumero(_ campo: UITextField) -> Double {
        let texto = (campo.text ?? "").replacingOccurrences(of: ",", with: ".")
        return Double(texto) ?? 0
    }

    private func formatoMoneda(_ valor: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        return "S/ " + (formatter.string(from: NSNumber(value: valor)) ?? "0.00")
    }

    // MARK: - Acción del botón
    @IBAction func CalcularResultado(_ sender: Any) {
        cerrarTeclado()

        let capital = leerNumero(capitalTextField)
        let tasaAnual = leerNumero(rateTextField)
        let anios = leerNumero(yearsTextField)

        if capital <= 0 || anios <= 0 || tasaAnual < 0 {
            mostrarError("Por favor, ingresa valores válidos.")
            return
        }

        let r = (tasaAnual / 100) / 12
        let n = anios * 12

        var cuota: Double
        if r == 0 {
            cuota = capital / n
        } else {
            let factor = pow(1 + r, n)
            cuota = capital * (r * factor) / (factor - 1)
        }

        let totalPagar = cuota * n
        let intereses = totalPagar - capital

        let mensaje = """
        📅 Cuota mensual: \(formatoMoneda(cuota))
        💵 Total a pagar: \(formatoMoneda(totalPagar))
        📈 Intereses: \(formatoMoneda(intereses))
        """
        mostrarExito(mensaje)
    }
}
