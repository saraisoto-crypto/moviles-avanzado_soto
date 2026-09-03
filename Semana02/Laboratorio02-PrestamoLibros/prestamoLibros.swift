import Foundation

// ENTRADA DE DATOS

print("Título del libro:")
let libro = readLine() ?? ""

print("Usuario:")
let usuario = readLine() ?? ""

print("Tipo de usuario (alumno/docente/administrador/coordinador):")
let tipoUsuario = (readLine() ?? "").lowercased()

print("Fecha límite (promesa de devolución) (dd/MM/yyyy):")
let fechaLimiteStr = readLine() ?? ""

print("Fecha de devolución real (dd/MM/yyyy):")
let fechaDevolucionStr = readLine() ?? ""

// LÓGICA DE NEGOCIO

let formatter = DateFormatter()
formatter.dateFormat = "dd/MM/yyyy"
formatter.locale = Locale(identifier: "es_PE")

// Configuración de cada tipo de usuario

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

// Validar tipo de usuario

guard let config = configs[tipoUsuario] else {
    print("Tipo de usuario inválido.")
    print("Tipos permitidos: alumno, docente, administrador, coordinador")
    exit(1)
}

// Validar fechas

guard let fechaLimite = formatter.date(from: fechaLimiteStr),
      let fechaDevolucion = formatter.date(from: fechaDevolucionStr) else {
    print("Fechas inválidas. Usa el formato dd/MM/yyyy")
    exit(1)
}

// Calcular días de atraso

let calendar = Calendar.current

let componentes = calendar.dateComponents(
    [.day],
    from: fechaLimite,
    to: fechaDevolucion
)

let diasAtraso = max(0, componentes.day ?? 0)

// Calcular multa según los rangos

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

// Calcular multa total

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

// Estado del préstamo

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

// Verificar máximo permitido

let excedeMaximo = diasAtraso > config.diasMaximos

// Suspensión

let suspendido = diasAtraso > 20

let situacion: String

if suspendido {
    situacion = "SUSPENDIDO"
} else if excedeMaximo {
    situacion = "EXCEDE EL MÁXIMO"
} else {
    situacion = "Habilitado"
}

// SALIDA DE RESULTADOS

print("")
print(String(repeating: "=", count: 45))
print("        REPORTE DE PRÉSTAMO")
print(String(repeating: "=", count: 45))

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

// DETALLE DE MULTAS

if diasAtraso > 0 {

    print("")
    print(String(repeating: "-", count: 55))
    print("              DETALLE DE MULTAS")
    print(String(repeating: "-", count: 55))

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

    print(String(repeating: "-", count: 55))
    print("Multa total: S/ \(String(format: "%.2f", multaTotal))")
    print("Días con multa: \(diasConMulta)")
}

// Advertencia por superar máximo

if excedeMaximo && !suspendido {

    print("")
    print("ADVERTENCIA:")
    print("El usuario ha superado el máximo permitido")
    print("para su tipo de usuario: \(config.diasMaximos) días.")
}

// Suspensión

if suspendido {

    print("")
    print(String(repeating: "!", count: 45))
    print("           USUARIO SUSPENDIDO")
    print("El atraso supera los 20 días.")
    print(String(repeating: "!", count: 45))
}

print("")
print(String(repeating: "=", count: 45))
