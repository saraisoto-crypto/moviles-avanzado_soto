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

// ===== Ejercicio 7: Inventario con menú =====

// Diccionarios que guardan el precio y el stock de cada producto usando el nombre como clave
var preciosInv: [String: Double] = [:]
var stocksInv: [String: Int] = [:]

// Pedimos cuántos productos se van a registrar antes de mostrar el menú
print("¿Cuántos productos va a registrar?")
// Convertimos la entrada a Int, usando 0 si falla la conversión
let cantidadInv = Int(readLine() ?? "") ?? 0

// Solo registramos productos si se ingresó un número válido
if cantidadInv > 0 {
    for i in 1...cantidadInv {
        // Pedimos el nombre del producto
        print("Producto \(i) - Nombre:")
        let nombre = readLine() ?? ""
        // Pedimos el precio del producto
        print("Precio:")
        let precio = Double(readLine() ?? "") ?? 0
        // Pedimos el stock del producto
        print("Stock:")
        let stock = Int(readLine() ?? "") ?? 0
        // Guardamos el precio en el diccionario de precios
        preciosInv[nombre] = precio
        // Guardamos el stock en el diccionario de stocks
        stocksInv[nombre] = stock
    }
}

// Variable de control que mantiene el menú activo mientras sea true
var continuar = true

// Bucle while que se repite hasta que el usuario elija salir
while continuar {
    // Mostramos las opciones del menú
    print("\n===== MENÚ INVENTARIO =====")
    print("1) Ver inventario")
    print("2) Buscar producto")
    print("3) Stock bajo")
    print("4) Valor total")
    print("5) Salir")
    print("Elige una opción:")
    // Leemos la opción elegida por el usuario
    let opcion = readLine() ?? ""

    // Si no hay más entrada disponible, salimos para evitar bucle infinito
    if opcion == "" {
        continuar = false
        break
    }

    // Evaluamos qué opción escogió con un switch
    switch opcion {
    case "1":
        print("\n----- INVENTARIO COMPLETO -----")
        for (nombre, precio) in preciosInv {
            let stock = stocksInv[nombre] ?? 0
            print("\(nombre): S/. \(precio) — Stock: \(stock)")
        }
    case "2":
        print("Nombre del producto a buscar:")
        let buscado = readLine() ?? ""
        if let precio = preciosInv[buscado] {
            let stock = stocksInv[buscado] ?? 0
            print("\(buscado): S/. \(precio) — Stock: \(stock)")
        } else {
            print("Producto no encontrado")
        }
    case "3":
        print("\n----- STOCK BAJO -----")
        for (nombre, stock) in stocksInv {
            if stock < 5 {
                print("\(nombre): quedan \(stock) unidades")
            }
        }
    case "4":
        var valorTotal = 0.0
        for (nombre, precio) in preciosInv {
            let stock = stocksInv[nombre] ?? 0
            valorTotal += precio * Double(stock)
        }
        print("Valor total del inventario: S/. \(valorTotal)")
    case "5":
        print("Saliendo del sistema... ¡Hasta pronto!")
        continuar = false
    default:
        print("Opción inválida, intenta de nuevo")
    }
}
