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

// ===== EJERCICIO 2: SWITCH =====
// --- Ejemplo (ya resuelto): ---
let diaSemana = 3
switch diaSemana {
case 1:
    print("Lunes")
case 2:
    print("Martes")
case 3:
    print("Miércoles")
case 4:
    print("Jueves")
case 5:
    print("Viernes")
case 6:
    print("Sábado")
case 7:
    print("Domingo")
default:
    print("Día inválido")
}

// --- TODO 4: Clasificar nota numérica a letra ---
let notaClasificada = 16
switch notaClasificada {
case 18...20:
    print("Excelente")
case 15...17:
    print("Bueno")
case 13...14:
    print("Aprobado")
case 0...12:
    print("Desaprobado")
default:
    print("Nota inválida")
}

// --- TODO 5: Calculadora simple con switch ---
let num1 = 20.0
let num2 = 5.0
let operacion = "+"
switch operacion {
case "+":
    print("Resultado: \(num1 + num2)")
case "-":
    print("Resultado: \(num1 - num2)")
case "*":
    print("Resultado: \(num1 * num2)")
case "/":
    // TODO: verificar que num2 no sea 0 antes de dividir
    if num2 != 0 {
        print("Resultado: \(num1 / num2)")
    } else {
        print("Error: División entre cero")
    }
default:
    print("Operación no válida")
}

// --- TODO 6: Categoría de producto por precio ---
let precio = 350.0
// Categorías: Económico (0-99), Medio (100-499),
// Premium (500-999), Lujo (1000+)
// Usa switch con rangos para clasificar
switch precio {
case 0...99:
    print("Económico")
case 100...499:
    print("Medio")
case 500...999:
    print("Premium")
case 1000...:
    print("Lujo")
default:
    print("Precio inválido") // Código defensivo por si hay precios negativos
}

// PREDICT: ¿Qué imprime?
let mes = 2
switch mes {
case 1, 3, 5, 7, 8, 10, 12:
    print("31 días")
case 4, 6, 9, 11:
    print("30 días")
case 2:
    print("28 o 29 días")
default:
    print("Mes inválido")
}
// PREDICT 4: Imprime "28 o 29 días"

let letra: Character = "a"
switch letra {
case "a", "e", "i", "o", "u":
    print("Vocal")
default:
    print("Consonante")
}
// PREDICT 5: Imprime "Vocal"

// ===== EJERCICIO 3: FOR-IN =====

// --- Ejemplo (ya resuelto): ---
// Imprime los números del 1 al 5:
for i in 1...5 {
    print("Número: \(i)")
}

// --- TODO 7: Tabla de multiplicar del 7 ---
// Imprime: 7 x 1 = 7, 7 x 2 = 14, ... 7 x 12 = 84
for i in 1...12 {
    print("7 x \(i) = \(7 * i)")
}

// --- TODO 8: Sumatoria del 1 al 100 ---
// Suma todos los números del 1 al 100
var suma = 0
for i in 1...100 {
    suma = suma + i
}
print("La suma del 1 al 100 es: \(suma)") // Debe dar 5050

// --- TODO 9: Calcular el factorial de 8 ---
// Factorial: 8! = 8 x 7 x 6 x 5 x 4 x 3 x 2 x 1 = 40320
var factorial = 1
for i in 1...8 {
    factorial = factorial * i
}
print("8! = \(factorial)")

// --- TODO 10: Patrón de asteriscos ---
// Imprime este patrón usando for anidados:
// *
// **
// ***
// ****
// *****
// ******
// Pista: usa String(repeating: "*", count: i)
for i in 1...6 {
    print(String(repeating: "*", count: i))
}

// ===== FIX: Encuentra los 2 errores =====
// Se quiere imprimir los números pares del 2 al 20:
for i in 1...20 {
    if i % 2 == 0 { // FIX 4: Cambié '1' por '0' para imprimir pares
        print(i)
    }
}

// Se quiere contar del 10 al 1 (cuenta regresiva):
for i in (1...10).reversed() { // FIX 5: Usé 'reversed()' para contar hacia atrás
    print(i)
}
// Pista: busca "stride" en Swift

// PREDICT: ¿Cuántas veces se ejecuta y qué imprime al final?

var total = 0
for i in 1...5 {
    total += i
}
print(total)
// PREDICT 6: Valor final = 15 (suma de 1+2+3+4+5)

var texto = ""
for _ in 1...3 {
    texto += "Hola "
}
print(texto)
// PREDICT 7: Imprime "Hola Hola Hola "
// ¿Para qué sirve _ en vez de i?
// _ se usa cuando no necesitas el valor del contador, solo quieres repetir el bucle N veces.

// ¿Cuántas iteraciones?
// El bucle for _ in 1...3 tiene 3 iteraciones
