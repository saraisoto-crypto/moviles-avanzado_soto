import Foundation
//Docente : Juan León S.

// ===== EJERCICIO 1: CONDICIONALES =====

// --- Ejemplo (ya resuelto): ---

let nota = 15.0

if nota >= 13.0 {

print("Aprobado con \(nota)")

} else {

print("Desaprobado con \(nota)")

}

// --- TODO 1: Validar si una persona es mayor de edad ---

let edad = 17
if edad >= 18 {
    print("Es mayor de edad")
} else {
    print("Es menor de edad")
}

// --- TODO 2: Clasificar una nota con else if ---

let miNota = 16.0

// Categorías: Excelente (18-20), Bueno (15-17),

// Aprobado (13-14), Desaprobado (0-12)

if miNota >= 18 {
    print("Excelente")
} else if miNota >= 15 {
    print("Bueno")
} else if miNota >= 13 {
    print("Aprobado")
} else {
    print("Desaprobado")
}

// --- TODO 3: Verificar si un número es positivo, negativo o cero ---

let numero = -5

// Escribe la estructura if / else if / else completa

if numero > 0 {
    print("El número es positivo")
} else if numero < 0 {
    print("El número es negativo")
} else {
    print("El número es cero")
}

// ===== FIX: Encuentra y corrige los 3 errores =====
let temperatura = 35
if temperatura > 30 {
    print("Hace calor")
} else if temperatura > 20 { // FIX 1: Agregué '{' que faltaba
    print("Clima agradable")
} else {
    print("Hace frio")
}

let saldo = 100.0
let compra = 150.0
if saldo > compra {
    print("Compra realizada")
} else {
    print("Saldo insuficiente: te faltan \(saldo - compra)") // FIX 2: Agregué '\' antes de '(saldo - compra)'
}

let hora = 25
if hora >= 0 && hora < 12 {
    print("Buenos días")
} else if hora >= 12 && hora < 18 {
    print("Buenas tardes")
} else if hora >= 18 && hora < 24 { // FIX 3: Cambié '<= 23' por '< 24' para que 25 sea inválido
    print("Buenas noches")
} else {
    print("Hora inválida")
}

// PREDICT: ¿Qué imprime cada bloque?

let x = 10
if x > 5 && x < 20 {
    print("Dentro del rango")
} else {
    print("Fuera del rango")
}
// PREDICT 1: Imprime "Dentro del rango"

let y = 15
if y > 20 {
    print("Mayor que 20")
} else if y > 10 {
    print("Mayor que 10")
} else if y > 5 {
    print("Mayor que 5")
}
// PREDICT 2: Imprime "Mayor que 10"
// ¿Por qué no imprime "Mayor que 5" también?
// Porque la primera condición que se cumple (y > 10) hace que el resto de 'else if' se omitan.

let esLunes = true
let llueve = false
if esLunes && llueve {
    print("Lunes lluvioso")
} else if esLunes || llueve {
    print("Es lunes O llueve")
} else {
    print("Ni lunes ni llueve")
}
// PREDICT 3: Imprime "Es lunes O llueve"
