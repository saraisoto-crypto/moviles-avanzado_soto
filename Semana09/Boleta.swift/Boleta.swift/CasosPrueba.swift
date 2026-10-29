//
//  CasosPrueba.swift
//  Boleta.swift
//
//  Created by Sarai Sthefanie Soto on 28/10/26.
//

import Foundation

struct CasosPrueba {

    struct Caso {
        let nombre: String
        let datos: DatosBoleta
        let netoEsperado: Decimal?     // nil = el caso no trae respuesta
        let essaludEsperado: Decimal?
    }

    static let casos: [Caso] = [
        Caso(nombre: "Caso 1",
             datos: DatosBoleta(sueldoBasico: dec("2500"), diasLaborados: 30,
                                tieneHijos: false, sistema: .onp),
             netoEsperado: dec("2175.00"), essaludEsperado: dec("225.00")),

        Caso(nombre: "Caso 2",
             datos: DatosBoleta(sueldoBasico: dec("1800"), diasLaborados: 27,
                                tieneHijos: true, sistema: .onp),
             netoEsperado: dec("1516.41"), essaludEsperado: dec("156.87")),

        Caso(nombre: "Caso 3",
             datos: DatosBoleta(sueldoBasico: dec("3000"), diasLaborados: 30,
                                tieneHijos: true, sistema: .afp,
                                horasExtras25: 4, horasExtras35: 4,
                                adelantos: dec("200")),
             netoEsperado: dec("2631.73"), essaludEsperado: dec("292.77")),

        // El caso 4 no trae respuesta en el enunciado: lo revisa el docente
        Caso(nombre: "Caso 4",
             datos: DatosBoleta(sueldoBasico: dec("4200"), diasLaborados: 24,
                                tieneHijos: true, sistema: .afp,
                                horasExtras25: 2, horasExtras35: 2,
                                adelantos: dec("100")),
             netoEsperado: nil, essaludEsperado: nil)
    ]

    /// Calcula cada caso y compara con la respuesta del enunciado.
    static func verificar() {
        for caso in casos {
            let b = Boleta(datos: caso.datos)
            var estado = "sin respuesta oficial (lo revisa el docente)"

            if let neto = caso.netoEsperado, let essalud = caso.essaludEsperado {
                let correcto = (b.neto == neto) && (b.essalud == essalud)
                estado = correcto ? "OK" : "ERROR, esperado neto \(neto.soles())"
            }

            print("\(caso.nombre): neto \(b.neto.soles()) | EsSalud \(b.essalud.soles()) -> \(estado)")
        }
    }
}
