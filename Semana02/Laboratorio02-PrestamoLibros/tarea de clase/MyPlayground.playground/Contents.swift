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
