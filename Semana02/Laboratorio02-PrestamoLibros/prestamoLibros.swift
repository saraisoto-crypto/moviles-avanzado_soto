import Foundation

// MARK: - CONFIGURACIÓN DE USUARIOS

struct ConfigUsuario {
    let multaBase: Double
    let diasMaximos: Int
}

let configs: [String: ConfigUsuario] = [
    "alumno": ConfigUsuario(multaBase: 1.5, diasMaximos: 7),
    "docente": ConfigUsuario(multaBase: 2.0, diasMaximos: 15),
    "administrador": ConfigUsuario(multaBase: 3.0, diasMaximos: 10),
    "coordinador": ConfigUsuario(multaBase: 4.0, diasMaximos: 15)
]

// MARK: - FORMATO DE FECHAS

let formatter = DateFormatter()
formatter.dateFormat = "dd/MM/yyyy"
formatter.locale = Locale(identifier: "es_PE")

let calendar = Calendar.current

// MARK: - FUNCIÓN PARA CALCULAR MULTA

func multaDelDia(_ dia: Int, base: Double) -> Double {
    switch dia {
    case 1...3:
        return 0.0
    case 4...6:
        return base * 0.25
    case 7...10:
        return base * 0.50
    case 11...20:
        return base * 1.00
    default:
        return base * 1.00
    }
}

// MARK: - REGISTRAR PRÉSTAMO

func registrarPrestamo() {

    print("")
    print(String(repeating: "=", count: 50))
    print("           REGISTRAR PRÉSTAMO")
    print(String(repeating: "=", count: 50))

    // ENTRADA DE DATOS

    print("Título del libro:")
    let libro = readLine() ?? ""

    print("Usuario:")
    let usuario = readLine() ?? ""

    print("Tipo de usuario (alumno/docente/administrador/coordinador):")
    let tipoUsuario = (readLine() ?? "").lowercased()

    // VALIDAR TIPO DE USUARIO

    guard let config = configs[tipoUsuario] else {
        print("")
        print("❌ Tipo de usuario inválido.")
        print("Tipos permitidos:")
        print("- alumno")
        print("- docente")
        print("- administrador")
        print("- coordinador")
        return
    }

    print("Fecha límite (promesa de devolución) (dd/MM/yyyy):")
    let fechaLimiteStr = readLine() ?? ""

    print("Fecha de devolución real (dd/MM/yyyy):")
    let fechaDevolucionStr = readLine() ?? ""

    // VALIDAR FECHAS

    guard let fechaLimite = formatter.date(from: fechaLimiteStr),
          let fechaDevolucion = formatter.date(from: fechaDevolucionStr) else {

        print("")
        print("❌ Fechas inválidas.")
        print("Usa el formato dd/MM/yyyy")
        return
    }

    // CALCULAR DÍAS DE ATRASO

    let componentes = calendar.dateComponents(
        [.day],
        from: fechaLimite,
        to: fechaDevolucion
    )

    let diasAtraso = max(0, componentes.day ?? 0)

    // CALCULAR MULTA TOTAL

    var multaTotal: Double = 0
    var diasConMulta = 0

    if diasAtraso > 0 {

        for dia in 1...diasAtraso {

            let multaDia = multaDelDia(
                dia,
                base: config.multaBase
            )

            multaTotal += multaDia

            if multaDia > 0 {
                diasConMulta += 1
            }
        }
    }

    // DETERMINAR ESTADO

    let estado: String

    if diasAtraso == 0 {
        estado = "A tiempo"
    } else if diasAtraso <= 3 {
        estado = "Atrasado - Sin multa"
    } else if diasAtraso <= 6 {
        estado = "Atrasado - Multa 25%"
    } else if diasAtraso <= 10 {
        estado = "Atrasado - Multa 50%"
    } else if diasAtraso <= 20 {
        estado = "Atrasado - Multa 100%"
    } else {
        estado = "Retraso crítico"
    }

    // VERIFICAR MÁXIMO PERMITIDO

    let excedeMaximo = diasAtraso > config.diasMaximos

    // VERIFICAR SUSPENSIÓN

    let suspendido = diasAtraso > 20

    let situacion: String

    if suspendido {
        situacion = "SUSPENDIDO"
    } else if excedeMaximo {
        situacion = "EXCEDE EL MÁXIMO"
    } else {
        situacion = "Habilitado"
    }

    // MARK: - REPORTE

    print("")
    print(String(repeating: "=", count: 50))
    print("             REPORTE DE PRÉSTAMO")
    print(String(repeating: "=", count: 50))

    print("Libro: \(libro)")
    print("Usuario: \(usuario)")
    print("Tipo: \(tipoUsuario)")
    print("Fecha límite: \(fechaLimiteStr)")
    print("Fecha de devolución: \(fechaDevolucionStr)")
    print("Días de atraso: \(diasAtraso)")
    print("Estado: \(estado)")
    print("Situación: \(situacion)")
    print("Máximo permitido: \(config.diasMaximos) días")
    print("Multa base: S/ \(String(format: "%.2f", config.multaBase))")

    // MARK: - DETALLE DE MULTAS

    if diasAtraso > 0 {

        print("")
        print(String(repeating: "-", count: 60))
        print("                 DETALLE DE MULTAS")
        print(String(repeating: "-", count: 60))

        print("Día\tFecha\t\tMulta\t\tAcumulado")

        var acumulado: Double = 0

        for dia in 1...diasAtraso {

            let fechaDia = calendar.date(
                byAdding: .day,
                value: dia,
                to: fechaLimite
            )!

            let multaDia = multaDelDia(
                dia,
                base: config.multaBase
            )

            acumulado += multaDia

            print(
                "\(dia)\t\(formatter.string(from: fechaDia))\t" +
                "S/ \(String(format: "%.2f", multaDia))\t" +
                "S/ \(String(format: "%.2f", acumulado))"
            )
        }

        print(String(repeating: "-", count: 60))
        print("Multa total: S/ \(String(format: "%.2f", multaTotal))")
        print("Días con multa: \(diasConMulta)")
    }

    // MARK: - ADVERTENCIA

    if excedeMaximo && !suspendido {

        print("")
        print("⚠️ ADVERTENCIA:")
        print("El usuario ha superado el máximo permitido")
        print("para su tipo de usuario: \(config.diasMaximos) días.")
    }

    // MARK: - SUSPENSIÓN

    if suspendido {

        print("")
        print(String(repeating: "!", count: 50))
        print("              USUARIO SUSPENDIDO")
        print("El atraso supera los 20 días.")
        print(String(repeating: "!", count: 50))
    }

    print("")
    print(String(repeating: "=", count: 50))
}

// MARK: - MOSTRAR TIPOS DE USUARIO

func mostrarTiposUsuario() {

    print("")
    print(String(repeating: "=", count: 50))
    print("             TIPOS DE USUARIO")
    print(String(repeating: "=", count: 50))

    print("Alumno:")
    print("  Multa base: S/ 1.50")
    print("  Máximo permitido: 7 días")

    print("")
    print("Docente:")
    print("  Multa base: S/ 2.00")
    print("  Máximo permitido: 15 días")

    print("")
    print("Administrador:")
    print("  Multa base: S/ 3.00")
    print("  Máximo permitido: 10 días")

    print("")
    print("Coordinador:")
    print("  Multa base: S/ 4.00")
    print("  Máximo permitido: 15 días")

    print(String(repeating: "=", count: 50))
}

// MARK: - MENÚ PRINCIPAL

var continuar = true

while continuar {

    print("")
    print(String(repeating: "=", count: 50))
    print("       SISTEMA DE PRÉSTAMO DE LIBROS")
    print(String(repeating: "=", count: 50))

    print("1. Registrar préstamo y devolución")
    print("2. Mostrar tipos de usuario")
    print("3. Salir")

    print("")
    print("Seleccione una opción:")

    let opcion = readLine() ?? ""

    switch opcion {

    case "1":
        registrarPrestamo()

    case "2":
        mostrarTiposUsuario()

    case "3":
        print("")
        print("Gracias por utilizar el sistema.")
        print("¡Hasta luego!")
        continuar = false

    default:
        print("")
        print("❌ Opción inválida.")
        print("Seleccione una opción del 1 al 3.")
    }
}
