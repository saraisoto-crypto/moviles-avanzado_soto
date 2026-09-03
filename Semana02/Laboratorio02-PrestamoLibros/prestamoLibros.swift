import Foundation

// ENTRADA DE DATOS
print("Título del libro:")
let libro = readLine() ?? ""

print("Usuario:")
let usuario = readLine() ?? ""

print("Tipo de usuario (alumno/docente/admin):")
let tipoUsuario = (readLine() ?? "").lowercased()

print("Fecha límite (promesa de devolución) (dd/MM/yyyy):")
let fechaLimiteStr = readLine() ?? ""

print("Fecha de devolución real (dd/MM/yyyy):")
let fechaDevolucionStr = readLine() ?? ""

// LÓGICA DE NEGOCIO
let formatter = DateFormatter()
formatter.dateFormat = "dd/MM/yyyy"

let multaBase: Double
switch tipoUsuario {
case "alumno":
    multaBase = 1.5
case "docente":
    multaBase = 2.0
case "admin":
    multaBase = 3.0
default:
    multaBase = 1.5
}

guard let fechaLimite = formatter.date(from: fechaLimiteStr),
      let fechaDevolucion = formatter.date(from: fechaDevolucionStr) else {
    print("Fechas inválidas")
    exit(1)
}

let calendar = Calendar.current
let componentes = calendar.dateComponents([.day], from: fechaLimite, to: fechaDevolucion)
let diasAtraso = max(0, componentes.day ?? 0)

func multaDelDia(_ dia: Int, base: Double) -> Double {
    if dia <= 3 {
        return base
    } else if dia <= 6 {
        return base * 1.5
    } else {
        return base * 2.0
    }
}

var multaTotal: Double = 0
if diasAtraso > 0 {
    for dia in 1...diasAtraso {
        multaTotal += multaDelDia(dia, base: multaBase)
    }
}

let estado = diasAtraso > 0 ? "Atrasado" : "A tiempo"
let situacion = diasAtraso >= 10 ? "Suspendido" : "Habilitado"

// SALIDA DE RESULTADOS
print("\n===== REPORTE DE PRÉSTAMO =====")
print("Libro: \(libro)")
print("Usuario: \(usuario) (\(tipoUsuario))")
print("Fecha límite (promesa): \(fechaLimiteStr)")
print("Fecha de devolución: \(fechaDevolucionStr)")
print("Días de atraso: \(diasAtraso)")
print("Estado: \(estado)")
print("Situación del usuario: \(situacion)")

if diasAtraso > 0 {
    print("\nDía\tFecha\t\tMulta\tAcumulado")
    var acumulado: Double = 0
    for dia in 1...diasAtraso {
        let fechaDia = calendar.date(byAdding: .day, value: dia, to: fechaLimite)!
        let multaDia = multaDelDia(dia, base: multaBase)
        acumulado += multaDia
        print("\(dia)\t\(formatter.string(from: fechaDia))\t\(String(format: "%.2f", multaDia))\t\(String(format: "%.2f", acumulado))")
    }
    print("\nMulta total: S/ \(String(format: "%.2f", multaTotal))")
}
