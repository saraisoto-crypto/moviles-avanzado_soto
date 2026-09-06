// Desarrollado por: Sarai Soto
import Foundation

// Diccionario que guardará el nombre de cada alumno como clave y un array de 3 notas como valor
var notasAlumnos: [String: [Double]] = [:]

// Pedimos cuántos alumnos se van a registrar
print("¿Cuántos alumnos?")
// Convertimos el texto ingresado a Int, si falla usamos 0
let cantidadAlumnos = Int(readLine() ?? "") ?? 0

// Solo entramos al bucle si se ingresó un número válido mayor a 0
if cantidadAlumnos > 0 {
    // Recorremos desde el alumno 1 hasta el último ingresado
    for i in 1...cantidadAlumnos {
        // Pedimos el nombre del alumno actual
        print("\nAlumno \(i) - Nombre:")
        let nombre = readLine() ?? ""
        // Creamos un array vacío para guardar las 3 notas de este alumno
        var notas: [Double] = []
        // Pedimos 3 notas para el alumno
        for j in 1...3 {
            print("Nota \(j) de \(nombre):")
            let nota = Double(readLine() ?? "") ?? 0
            notas.append(nota)
        }
        // Guardamos el array de notas en el diccionario usando el nombre como clave
        notasAlumnos[nombre] = notas
    }
}

// Array donde guardaremos el promedio de cada alumno junto a su nombre
var promedios: [(nombre: String, promedio: Double)] = []

// Recorremos el diccionario para calcular el promedio de cada alumno
for (nombre, notas) in notasAlumnos {
    // Sumamos todas las notas del alumno
    let suma = notas.reduce(0, +)
    // Dividimos entre la cantidad de notas para obtener el promedio
    let promedio = suma / Double(notas.count)
    // Guardamos el resultado en el array de promedios
    promedios.append((nombre: nombre, promedio: promedio))
}

// Mostramos el reporte individual con clasificación (solo si hay datos)
if promedios.count > 0 {
    print("\n===== REPORTE DE NOTAS =====")
    for item in promedios {
        // Variable que guardará el texto de la clasificación
        var clasificacion = ""
        // Clasificamos según el rango del promedio
        switch item.promedio {
        case 17...20:
            clasificacion = "Excelente"
        case 14..<17:
            clasificacion = "Bueno"
        case 13..<14:
            clasificacion = "Aprobado"
        default:
            clasificacion = "Desaprobado"
        }
        // Imprimimos el nombre, promedio (redondeado a 2 decimales) y clasificación
        print("\(item.nombre): \(String(format: "%.2f", item.promedio)) → \(clasificacion)")
    }

    // Calculamos el promedio general de toda la clase
    let sumaPromedios = promedios.reduce(0) { $0 + $1.promedio }
    let promedioGeneral = sumaPromedios / Double(promedios.count)

    // Buscamos el promedio más alto usando la función max, comparando por el campo promedio
    let notaMasAlta = promedios.max { $0.promedio < $1.promedio }
    // Buscamos el promedio más bajo usando la función min
    let notaMasBaja = promedios.min { $0.promedio < $1.promedio }

    // Contamos cuántos alumnos tienen promedio aprobatorio (>= 13)
    let cantidadAprobados = promedios.filter { $0.promedio >= 13 }.count
    // Calculamos el porcentaje de aprobados sobre el total
    let porcentajeAprobados = (Double(cantidadAprobados) / Double(promedios.count)) * 100

    // Mostramos las estadísticas generales
    print("\n===== ESTADÍSTICAS =====")
    print("Promedio general: \(String(format: "%.2f", promedioGeneral))")
    if let alto = notaMasAlta {
        print("Nota más alta: \(alto.nombre) con \(String(format: "%.2f", alto.promedio))")
    }
    if let bajo = notaMasBaja {
        print("Nota más baja: \(bajo.nombre) con \(String(format: "%.2f", bajo.promedio))")
    }
    print("Porcentaje de aprobados: \(String(format: "%.1f", porcentajeAprobados))%")

    // Ordenamos la lista de promedios de mayor a menor usando sorted
    let ordenadosPorPromedio = promedios.sorted { $0.promedio > $1.promedio }

    // Mostramos el ranking final ordenado
    print("\n===== RANKING (mayor a menor) =====")
    for item in ordenadosPorPromedio {
        print("\(item.nombre): \(String(format: "%.2f", item.promedio))")
    }
}
