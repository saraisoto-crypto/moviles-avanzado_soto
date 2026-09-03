# Prompts utilizados — Laboratorio 02

## Herramienta de IA utilizada
Claude

## Ejercicio 6 — Carrito mejorado

### Prompt (estructura CTRFE):
CONTEXTO: Tengo un carrito de compras en Swift con productos, subtotales, 
descuento por monto e IGV ya calculados (ejercicio 5 del lab).
TAREA: Agrega 5 funcionalidades: descuento por cantidad (3+ unidades = 5% extra 
por producto), cupón "DESCUENTO20" (20% adicional), envío gratis si el total 
supera S/. 3000 (si no, S/. 25), puntos de fidelidad (1 punto por cada S/. 100), 
y validación de precios negativos o cantidades en 0.
RESTRICCIONES: Debe usar if/else y operadores existentes del curso (semana 2), 
no arrays ni funciones. Cada línea debe tener un comentario explicando qué hace.
FORMATO: Código Swift comentado línea por línea, listo para pegar en Playground.
EJEMPLO: Se compartió el código del ejercicio 5 ya resuelto como base.

### ¿Funcionó a la primera?
Sí, compiló y corrió sin errores en el primer intento.

### ¿La IA usó algo que no conocías?
Sí — el operador ternario `condición ? valorSiTrue : valorSiFalse`, usado por 
ejemplo en `let descuentoCant1 = cant1 >= 3 ? sub1 * 0.05 : 0.0`. Investigué 
que es una forma corta de escribir un if/else que devuelve un valor directamente.

## Ejercicio 7 — Juego de adivinanza

### Prompt (estructura CTRFE):
CONTEXTO: Necesito un mini juego de adivinanza de números para Playground, 
usando lo visto en el lab (while, comparaciones, contadores).
TAREA: Número secreto fijo (42), simular 5 intentos con variables, recorrer 
con while, mostrar "Muy alto"/"Muy bajo"/"¡Correcto!" en cada intento, contar 
cuántos intentos usó, y mostrar "Perdiste. El número era: X" si no acierta en 5.
RESTRICCIONES: No usar arrays (contenido de semana 3), comentar cada línea, 
explicar la lógica de comparación.
FORMATO: Código Swift comentado, ejecutable en Playground.
EJEMPLO: Se compartió el ejercicio 4 (while) como referencia de estilo.

### ¿Funcionó a la primera?
Sí, compiló y corrió sin errores en el primer intento.

### ¿La IA usó algo que no conocías?
No, la lógica de while y comparaciones ya se había visto en el ejercicio 4 
del lab (bucles while).