
# Calculadora de Préstamos (UIKit)

**Curso:** Programación en Móviles Avanzado (5 C24)
**Laboratorio:** N° 05 - Interfaces mediante UIKit (actividad)
**Docente:** Juan León
**Alumna:** Sarai Sthefanie Soto López
**Institución:** Tecsup

## Descripción

App para iOS hecha con Xcode, Swift, UIKit y Storyboard. Calcula la cuota mensual, el total a pagar y los intereses de un préstamo a partir del capital, la tasa de interés anual y el plazo en años.

## Requerimientos funcionales

| Código | Requerimiento |
|--------|---------------|
| RF-01 | La app debe permitir ingresar el **capital inicial** (monto del préstamo). |
| RF-02 | La app debe permitir ingresar la **tasa de interés anual** (%). |
| RF-03 | La app debe permitir ingresar el **plazo del préstamo** en años. |
| RF-04 | La app debe tener un botón **"Calcular préstamo"** que ejecute el cálculo. |
| RF-05 | La app debe validar los datos: capital y plazo mayores a 0, y tasa no negativa. Si hay datos vacíos o inválidos, debe mostrar un mensaje de error. |
| RF-06 | La app debe calcular la **cuota mensual** con la fórmula de amortización. |
| RF-07 | La app debe calcular el **monto total a pagar** (cuota mensual x número total de pagos). |
| RF-08 | La app debe calcular el **total de intereses** (total a pagar - capital). |
| RF-09 | La app debe mostrar los resultados en una etiqueta, con formato de soles (S/) y dos decimales. |
| RF-10 | La app debe manejar el caso de tasa 0% dividiendo el capital entre el número de pagos. |
| RF-11 | La app debe mostrar el resultado en verde si el cálculo es correcto y en rojo si hay un error. |
| RF-12 | La app debe cerrar el teclado al presionar el botón o al tocar fuera de los campos. |

## Fórmula utilizada

M = P x [ r(1 + r)^n ] / [ (1 + r)^n - 1 ]

- M: cuota mensual
- P: capital del préstamo
- r: tasa de interés mensual (tasa anual / 100 / 12)
- n: número total de pagos (años x 12)

Monto total a pagar = M x n

## Ejemplo de prueba

| Capital | Tasa anual | Plazo | Cuota mensual | Total a pagar |
|---------|-----------|-------|---------------|---------------|
| 10000 | 12 | 2 años | S/ 470.73 | S/ 11,297.63 |

## Diseño

- Controles: UILabel, UITextField y UIButton, conectados con @IBOutlet y @IBAction.
- Auto Layout: constraints para mantener los elementos ordenados al rotar la pantalla.
- Estilo: título con fondo índigo, campos con bordes redondeados, botón con ícono y fondo lavanda en la pantalla.

## Cómo ejecutarlo

1. Abrir apple_lab05_UIKit_prestamos.xcodeproj con Xcode.
2. Elegir un simulador de iPhone en la parte superior.
3. Presionar Play (o Product -> Run).
