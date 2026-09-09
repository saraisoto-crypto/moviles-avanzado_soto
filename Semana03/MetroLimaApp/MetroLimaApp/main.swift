import Foundation

// =====================================================================
// APP: Consulta de Estaciones - Metro de Lima
// Curso: Programación en Móviles Avanzado
// =====================================================================

struct Estacion {
let nombre: String
let distrito: String
let lineas: [Int]
}

let estaciones: [Estacion] = [

// ---------- LÍNEA 1 (Villa El Salvador -> Bayóvar, 26 estaciones) ----------
Estacion(nombre: "Villa El Salvador", distrito: "Villa El Salvador", lineas: [1]),
Estacion(nombre: "Parque Industrial", distrito: "Villa El Salvador", lineas: [1]),
Estacion(nombre: "Pumacahua", distrito: "Villa María del Triunfo", lineas: [1]),
Estacion(nombre: "Villa María", distrito: "Villa María del Triunfo", lineas: [1]),
Estacion(nombre: "María Auxiliadora", distrito: "San Juan de Miraflores", lineas: [1]),
Estacion(nombre: "San Juan", distrito: "San Juan de Miraflores", lineas: [1]),
Estacion(nombre: "Atocongo", distrito: "San Juan de Miraflores", lineas: [1]),
Estacion(nombre: "Jorge Chávez", distrito: "San Juan de Miraflores", lineas: [1]),
Estacion(nombre: "Ayacucho", distrito: "Santiago de Surco", lineas: [1]),
Estacion(nombre: "Cabitos", distrito: "Santiago de Surco", lineas: [1]),
Estacion(nombre: "Angamos", distrito: "Surquillo", lineas: [1]),
Estacion(nombre: "San Borja Sur", distrito: "San Borja", lineas: [1, 2]),
Estacion(nombre: "La Cultura", distrito: "San Borja", lineas: [1, 2]),
Estacion(nombre: "Arriola", distrito: "San Luis", lineas: [1]),
Estacion(nombre: "Gamarra", distrito: "La Victoria", lineas: [1]),
Estacion(nombre: "Miguel Grau", distrito: "La Victoria", lineas: [1]),
Estacion(nombre: "El Ángel", distrito: "Cercado de Lima", lineas: [1]),
Estacion(nombre: "Presbítero Maestro", distrito: "Cercado de Lima", lineas: [1]),
Estacion(nombre: "Caja de Agua", distrito: "El Agustino", lineas: [1]),
Estacion(nombre: "Pirámide del Sol", distrito: "El Agustino", lineas: [1]),
Estacion(nombre: "Los Jardines", distrito: "San Juan de Lurigancho", lineas: [1]),
Estacion(nombre: "Los Postes", distrito: "San Juan de Lurigancho", lineas: [1]),
Estacion(nombre: "San Carlos", distrito: "San Juan de Lurigancho", lineas: [1]),
Estacion(nombre: "San Martín", distrito: "San Juan de Lurigancho", lineas: [1]),
Estacion(nombre: "Santa Rosa", distrito: "San Juan de Lurigancho", lineas: [1]),
Estacion(nombre: "Bayóvar", distrito: "San Juan de Lurigancho", lineas: [1]),

// ---------- LÍNEA 2 (tramo operativo, inaugurado dic. 2023) ----------
Estacion(nombre: "Nicolás Arriola", distrito: "San Luis", lineas: [2]),
Estacion(nombre: "Evitamiento", distrito: "Santa Anita", lineas: [2]),
Estacion(nombre: "Ate", distrito: "Ate", lineas: [2])
]

// ---------------------------------------------------------------------
// Utilidades
// ---------------------------------------------------------------------

func normalizar(_ texto: String) -> String {
return texto.folding(
options: .diacriticInsensitive,
locale: .current
).lowercased()
}

// Lee la entrada y elimina espacios al inicio y al final
func leerEntrada() -> String? {
return readLine()?.trimmingCharacters(in: .whitespacesAndNewlines)
}

func nombreLinea(_ n: Int) -> String {
return n == 1 ? "Línea 1" : "Línea 2"
}

func estacionesDeLinea(_ linea: Int) -> [Estacion] {
return estaciones.filter { $0.lineas.contains(linea) }
}

// ---------------------------------------------------------------------
// RF1 - Listar estaciones
// ---------------------------------------------------------------------

func listarEstaciones() {

print("\n¿Qué línea deseas listar? (1, 2, 0 = ambas)")

guard let opcion = leerEntrada(),
      let linea = Int(opcion) else {
    print("Opción inválida.")
    return
}

let lista = linea == 0 ? estaciones : estacionesDeLinea(linea)

if lista.isEmpty {
    print("No se encontraron estaciones para esa línea.")
    return
}

print("\n--- Estaciones (\(linea == 0 ? "Línea 1 y 2" : nombreLinea(linea))) ---")

for (i, e) in lista.enumerated() {
    let lineasTxt = e.lineas.map { "L\($0)" }.joined(separator: "/")
    print("\(i + 1). \(e.nombre) — \(e.distrito) [\(lineasTxt)]")
}

}

// ---------------------------------------------------------------------
// RF2 - Buscar estación por nombre
// ---------------------------------------------------------------------

func buscarPorNombre() {

print("\nEscribe el nombre (o parte del nombre) de la estación:")

guard let texto = leerEntrada(),
      !texto.isEmpty else {
    print("Debes escribir un texto.")
    return
}

let objetivo = normalizar(texto)

let resultados = estaciones.filter {
    normalizar($0.nombre).contains(objetivo)
}

if resultados.isEmpty {
    print("No se encontró ninguna estación con ese nombre.")
    return
}

print("\n--- Resultados ---")

for e in resultados {
    let lineasTxt = e.lineas
        .map { nombreLinea($0) }
        .joined(separator: " y ")

    print("• \(e.nombre) — Distrito: \(e.distrito) — Atendida por: \(lineasTxt)")
}

}

// ---------------------------------------------------------------------
// RF3 - Qué línea(s) cubren un distrito o lugar
// ---------------------------------------------------------------------

func lineasPorLugar() {

print("\nEscribe el distrito o lugar que quieres consultar:")

guard let texto = leerEntrada(),
      !texto.isEmpty else {
    print("Debes escribir un texto.")
    return
}

let objetivo = normalizar(texto)

let resultados = estaciones.filter {
    normalizar($0.distrito).contains(objetivo)
}

if resultados.isEmpty {
    print("No hay estaciones registradas cerca de '\(texto)'.")
    return
}

let lineasEncontradas = Set(
    resultados.flatMap { $0.lineas }
).sorted()

let lineasTxt = lineasEncontradas
    .map { nombreLinea($0) }
    .joined(separator: " y ")

print("\nEn '\(texto)' pasa(n): \(lineasTxt)")
print("Estaciones en esa zona:")

for e in resultados {
    print("• \(e.nombre)")
}

}

// ---------------------------------------------------------------------
// RF4 - "Estoy en tal lugar, ¿qué línea tomaría?"
// ---------------------------------------------------------------------

func queLineaTomar() {

print("\n¿En qué lugar te encuentras (distrito o estación cercana)?")

guard let texto = leerEntrada(),
      !texto.isEmpty else {
    print("Debes escribir un texto.")
    return
}

let objetivo = normalizar(texto)

let resultados = estaciones.filter {
    normalizar($0.distrito).contains(objetivo) ||
    normalizar($0.nombre).contains(objetivo)
}

if resultados.isEmpty {
    print("No encontramos estaciones cerca de '\(texto)'. Intenta con otro distrito o estación.")
    return
}

print("\nSegún tu ubicación, la estación más cercana registrada es:")

for e in resultados {
    let lineasTxt = e.lineas
        .map { nombreLinea($0) }
        .joined(separator: " o ")

    print("• \(e.nombre) (\(e.distrito)) → deberías tomar: \(lineasTxt)")
}

}

// ---------------------------------------------------------------------
// RF5 - Estaciones de transferencia (L1 <-> L2)
// ---------------------------------------------------------------------

func mostrarTransferencias() {

let transferencias = estaciones.filter {
    $0.lineas.count > 1
}

if transferencias.isEmpty {
    print("No hay estaciones de transferencia registradas.")
    return
}

print("\n--- Estaciones de transferencia (cambio de línea) ---")

for e in transferencias {
    print("• \(e.nombre) — \(e.distrito) — conecta Línea 1 y Línea 2")
}

}

// ---------------------------------------------------------------------
// RF6 - Calcular ruta entre dos estaciones de la misma línea
// ---------------------------------------------------------------------

func calcularRuta() {

print("\nEscribe la estación de ORIGEN:")

guard let origenTxt = leerEntrada(),
      !origenTxt.isEmpty else {
    return
}

print("Escribe la estación de DESTINO:")

guard let destinoTxt = leerEntrada(),
      !destinoTxt.isEmpty else {
    return
}

guard let origen = estaciones.first(where: {
    normalizar($0.nombre) == normalizar(origenTxt)
}) else {
    print("No se encontró la estación de origen '\(origenTxt)'.")
    return
}

guard let destino = estaciones.first(where: {
    normalizar($0.nombre) == normalizar(destinoTxt)
}) else {
    print("No se encontró la estación de destino '\(destinoTxt)'.")
    return
}

let lineaComun = origen.lineas.first {
    destino.lineas.contains($0)
}

guard let linea = lineaComun else {
    print("\n'\(origen.nombre)' y '\(destino.nombre)' no comparten una línea directa.")
    print("Deberás hacer transferencia en: San Borja Sur o La Cultura.")
    return
}

let lista = estacionesDeLinea(linea)

guard let i1 = lista.firstIndex(where: {
    $0.nombre == origen.nombre
}),
let i2 = lista.firstIndex(where: {
    $0.nombre == destino.nombre
}) else {
    print("No se pudo calcular la ruta.")
    return
}

let paradas = abs(i2 - i1)

let rango: [Estacion]

if i1 < i2 {
    rango = Array(lista[i1...i2])
} else {
    rango = Array(lista[i2...i1].reversed())
}

print("\nRuta en \(nombreLinea(linea)): \(origen.nombre) → \(destino.nombre)")
print("Número de paradas (sin contar el origen): \(paradas)")
print("Recorrido:")

for (i, e) in rango.enumerated() {
    print("  \(i + 1). \(e.nombre)")
}

}

// ---------------------------------------------------------------------
// MENÚ PRINCIPAL
// ---------------------------------------------------------------------

func mostrarMenu() {

print("""

=====================================================
        METRO DE LIMA - Consulta de Estaciones
=====================================================
1. Listar estaciones
2. Buscar estación por nombre
3. Ver qué línea(s) cubren un distrito/lugar
4. ¿En qué línea me encuentro? (según mi ubicación)
5. Ver estaciones de transferencia
6. Calcular ruta entre dos estaciones
0. Salir
=====================================================
Elige una opción:
""")

}

func iniciarApp() {

var continuar = true

while continuar {

    mostrarMenu()

    guard let opcion = leerEntrada() else {
        continue
    }

    switch opcion {

    case "1":
        listarEstaciones()

    case "2":
        buscarPorNombre()

    case "3":
        lineasPorLugar()

    case "4":
        queLineaTomar()

    case "5":
        mostrarTransferencias()

    case "6":
        calcularRuta()

    case "0":
        print("\n¡Gracias por usar la app del Metro de Lima!")
        continuar = false

    default:
        print("Opción no válida, intenta de nuevo.")
    }
}

}

iniciarApp()
