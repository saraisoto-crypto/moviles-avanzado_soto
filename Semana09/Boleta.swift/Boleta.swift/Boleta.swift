//
//  Boleta.swift
//  Boleta.swift
//
//  Created by Sarai Sthefanie Soto on 28/10/26.
//

import Foundation

// MARK: - Utilidades

func dec(_ texto: String) -> Decimal {
    Decimal(string: texto, locale: Locale(identifier: "en_US_POSIX")) ?? 0
}

extension Decimal {
    /// Redondea a 2 decimales (mitad hacia arriba)
    func redondeado() -> Decimal {
        var origen = self
        var resultado = Decimal()
        NSDecimalRound(&resultado, &origen, 2, .plain)
        return resultado
    }

    /// Formato "2,500.00"
    func soles() -> String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.minimumFractionDigits = 2
        f.maximumFractionDigits = 2
        f.locale = Locale(identifier: "en_US")
        return f.string(from: self as NSDecimalNumber) ?? "0.00"
    }
}

// MARK: - Parámetros (un solo lugar)

struct TasasAFP {
    let fondo: Decimal
    let comision: Decimal
    let seguro: Decimal
}

struct Parametros {
    static let rmv: Decimal = dec("1230")                          // D.S. RMV, desde 1 oct 2026
    static let porcentajeAsignacionFamiliar: Decimal = dec("0.10") // Ley 25129
    static let porcentajeONP: Decimal = dec("0.13")                // D.L. 19990
    static let porcentajeEsSalud: Decimal = dec("0.09")            // Ley 26790
    static let recargoHE25: Decimal = dec("1.25")
    static let recargoHE35: Decimal = dec("1.35")
    static let diasMes = 30
    static let horasDia = 8

    // Diccionario: nombre de AFP -> tasas
    // "AFP Ejemplo" es solo para casos de prueba. Para datos reales usar valores de la SBS.
    static let tasasAFP: [String: TasasAFP] = [
        "AFP Ejemplo": TasasAFP(fondo: dec("0.10"),
                                comision: dec("0.016"),
                                seguro: dec("0.0135"))
    ]
}

// MARK: - Datos de entrada

enum SistemaPension: String, CaseIterable {
    case onp = "ONP"
    case afp = "AFP"
}

struct DatosBoleta {
    var sueldoBasico: Decimal
    var diasLaborados: Int
    var tieneHijos: Bool
    var sistema: SistemaPension
    var nombreAFP: String = "AFP Ejemplo"
    var horasExtras25: Decimal = 0
    var horasExtras35: Decimal = 0
    var adelantos: Decimal = 0
}

// MARK: - Concepto (fila de la boleta)

struct Concepto: Identifiable {
    let id = UUID()
    let nombre: String
    let monto: Decimal
}

// MARK: - Boleta (calcula)

class Boleta {
    let datos: DatosBoleta

    private(set) var remuneraciones: [Concepto] = []   // array de remuneraciones
    private(set) var descuentos: [Concepto] = []       // array de descuentos
    private(set) var totalRemuneraciones: Decimal = 0
    private(set) var totalDescuentos: Decimal = 0
    private(set) var neto: Decimal = 0
    private(set) var essalud: Decimal = 0

    init(datos: DatosBoleta) {
        self.datos = datos
        calcular()
    }

    private func calcular() {
        let d = datos
        let baseHoras = Decimal(Parametros.diasMes * Parametros.horasDia) // 240

        // --- Remuneraciones ---
        let sueldoComputable = (d.sueldoBasico * Decimal(d.diasLaborados)
                                / Decimal(Parametros.diasMes)).redondeado()

        let asignacion: Decimal = d.tieneHijos
            ? (Parametros.rmv * Parametros.porcentajeAsignacionFamiliar).redondeado()
            : 0

        // valor hora = sueldo / 30 / 8; se multiplica primero y se divide al final
        // para no perder precisión
        let he25 = (d.sueldoBasico * Parametros.recargoHE25 * d.horasExtras25
                    / baseHoras).redondeado()
        let he35 = (d.sueldoBasico * Parametros.recargoHE35 * d.horasExtras35
                    / baseHoras).redondeado()

        remuneraciones = [
            Concepto(nombre: "Sueldo computable", monto: sueldoComputable),
            Concepto(nombre: "Asignación familiar", monto: asignacion),
            Concepto(nombre: "Horas extras 25%", monto: he25),
            Concepto(nombre: "Horas extras 35%", monto: he35)
        ]
        totalRemuneraciones = remuneraciones.reduce(0) { $0 + $1.monto }

        // --- Descuentos ---
        var onp: Decimal = 0
        var afpFondo: Decimal = 0
        var afpComision: Decimal = 0
        var afpSeguro: Decimal = 0

        if d.sistema == .onp {
            onp = (totalRemuneraciones * Parametros.porcentajeONP).redondeado()
        } else if let tasas = Parametros.tasasAFP[d.nombreAFP] {
            afpFondo = (totalRemuneraciones * tasas.fondo).redondeado()
            afpComision = (totalRemuneraciones * tasas.comision).redondeado()
            afpSeguro = (totalRemuneraciones * tasas.seguro).redondeado()
        }

        descuentos = [
            Concepto(nombre: "ONP", monto: onp),
            Concepto(nombre: "AFP fondo", monto: afpFondo),
            Concepto(nombre: "AFP comisión", monto: afpComision),
            Concepto(nombre: "AFP seguro", monto: afpSeguro),
            Concepto(nombre: "Adelantos", monto: d.adelantos)
        ]
        totalDescuentos = descuentos.reduce(0) { $0 + $1.monto }

        // --- Resultado ---
        neto = totalRemuneraciones - totalDescuentos
        essalud = (totalRemuneraciones * Parametros.porcentajeEsSalud).redondeado()
    }
}
