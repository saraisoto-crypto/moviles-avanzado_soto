# 🚇 Metro Lima App

## 📌 Descripción

**Metro Lima App** es una aplicación desarrollada en **Swift** como parte del curso **Programación en Móviles Avanzado**.

El proyecto permite consultar información de estaciones del sistema de transporte mediante un menú interactivo en consola. El usuario puede buscar estaciones, consultar las líneas disponibles según una ubicación, visualizar estaciones de transferencia y calcular rutas entre estaciones.

La aplicación utiliza estructuras (`struct`), arreglos (`Array`), diccionarios (`Dictionary`), funciones, filtros y búsqueda de información para organizar y consultar los datos.

---

## 🎯 Objetivo del proyecto

Desarrollar una aplicación en Swift que permita:

* Consultar las estaciones disponibles.
* Identificar las líneas asociadas a cada estación.
* Buscar estaciones por nombre.
* Buscar estaciones por distrito o lugar.
* Identificar qué línea tomar según una ubicación.
* Mostrar la distancia aproximada y el tiempo estimado caminando hacia una estación.
* Consultar estaciones de transferencia.
* Calcular una ruta entre dos estaciones.
* Determinar el número de paradas de una ruta.

---

## 🛠️ Tecnologías utilizadas

* **Lenguaje:** Swift
* **Entorno:** Xcode
* **Tipo de aplicación:** Aplicación de consola
* **Framework utilizado:** Foundation
* **Control de versiones:** Git

---

## 📂 Estructura del proyecto

```text
MetroLimaApp/
│
├── MetroLimaApp.xcodeproj
│
├── MetroLimaApp/
│   └── main.swift
│
└── README.md
```

El archivo principal del proyecto es `main.swift`, donde se encuentran los datos de las estaciones, estructuras, funciones y menú principal de la aplicación.

---

## 🚉 Líneas disponibles

La aplicación contiene información organizada para las siguientes líneas:

| Línea   | Información                                      |
| ------- | ------------------------------------------------ |
| Línea 1 | Estaciones desde Villa El Salvador hasta Bayóvar |
| Línea 2 | Estaciones desde Ate hacia el Callao             |
| Línea 3 | Estaciones incluidas en el modelo académico      |
| Línea 4 | Estaciones incluidas en el modelo académico      |
| Línea 5 | Estaciones incluidas en el modelo académico      |
| Línea 6 | Estaciones incluidas en el modelo académico      |

Los datos de las estaciones se almacenan mediante la estructura `Estacion`, que contiene el nombre, distrito y líneas asociadas.

---

## 📋 Funcionalidades

### 1. Listar estaciones

Permite seleccionar una línea específica del **1 al 6** o visualizar todas las líneas.

```text
1. Línea 1
2. Línea 2
3. Línea 3
4. Línea 4
5. Línea 5
6. Línea 6
7. Todas las líneas
```

Al seleccionar una opción, se muestran las estaciones correspondientes junto con su distrito.

---

### 2. Buscar estación por nombre

El usuario puede ingresar el nombre completo o una parte del nombre de una estación.

Por ejemplo:

```text
Ingrese el nombre de la estación:
Gamarra
```

La aplicación muestra:

* Nombre de la estación.
* Distrito.
* Líneas disponibles.

La búsqueda utiliza una función de normalización para facilitar la búsqueda incluso cuando existen diferencias de mayúsculas, minúsculas o tildes.

---

### 3. Buscar estaciones por distrito o lugar

Permite ingresar un distrito o el nombre de una estación para encontrar coincidencias.

Ejemplo:

```text
Ingrese un distrito o lugar:
Cercado de Lima
```

La aplicación muestra las estaciones encontradas y las líneas a las que pertenecen.

---

### 4. ¿Qué línea debo tomar según mi ubicación?

Esta opción permite indicar:

1. La ubicación actual o distrito.
2. La línea que se desea tomar.

Ejemplo:

```text
¿Dónde te encuentras?
Centro de Lima

¿Qué línea quieres tomar? (1-6)
1
```

El programa busca estaciones de la línea seleccionada y muestra información sobre la distancia aproximada y el tiempo estimado caminando.

Las distancias se calculan utilizando coordenadas aproximadas de los distritos y la fórmula de Haversine.

> **Nota:** las distancias son aproximadas y representan una estimación en línea recta entre centros de distrito. No corresponden a una ruta real por calles.

---

### 5. Estaciones de transferencia

Esta función permite identificar estaciones que pertenecen a más de una línea.

El programa busca las estaciones cuyo arreglo de líneas contiene más de una línea y muestra las líneas asociadas.

---

### 6. Calcular ruta entre estaciones

Permite ingresar:

* Estación de origen.
* Estación de destino.

El programa verifica si ambas estaciones comparten una línea y, si existe una ruta directa, muestra las estaciones que se deben recorrer y el número de paradas.

Ejemplo:

```text
Ingrese estación de origen:
Gamarra

Ingrese estación de destino:
Bayóvar
```

La aplicación muestra la ruta correspondiente y calcula el número de paradas entre ambas estaciones.

Si las estaciones no comparten una línea directamente, el programa informa que se requiere una transferencia.

---

## 🧩 Estructuras principales

### `Estacion`

Representa una estación del sistema:

```swift
struct Estacion {
    let nombre: String
    let distrito: String
    let lineas: [Int]
}
```

### `Coordenada`

Permite representar las coordenadas aproximadas de un distrito:

```swift
struct Coordenada {
    let lat: Double
    let lon: Double
}
```

Estas estructuras permiten organizar la información de manera clara y facilitar su consulta.

---

## 🔎 Normalización de datos

La aplicación utiliza la función `normalizar()` para realizar búsquedas de manera más flexible.

Esta función permite ignorar diferencias de:

* Mayúsculas y minúsculas.
* Tildes.
* Espacios al inicio y al final.

Además, `leerEntrada()` elimina espacios innecesarios de las entradas ingresadas por el usuario.

---

## 📐 Cálculo de distancia

Para estimar la distancia entre una ubicación y una estación se utiliza la fórmula de **Haversine**.

El programa utiliza un radio terrestre de aproximadamente:

```text
6 371 000 metros
```

Posteriormente, la distancia estimada se utiliza para calcular un tiempo aproximado caminando considerando un ritmo de aproximadamente **5 km/h**.

---

## ▶️ Ejecución del proyecto

### Opción 1: Xcode

1. Abrir el archivo:

```text
MetroLimaApp.xcodeproj
```

2. Seleccionar el proyecto.
3. Ejecutar con el botón **▶ Run**.
4. Interactuar con el menú desde la consola.

### Opción 2: Terminal

Ingresar a la carpeta donde se encuentra el proyecto y ejecutar:

```bash
swift main.swift
```

También puede ejecutarse mediante:

```bash
swift run
```

---

## 🖥️ Menú principal

Al iniciar la aplicación se muestra el siguiente menú:

```text
=====================================================
                 METRO LIMA APP
=====================================================

1. Listar estaciones
2. Buscar estación por nombre
3. Buscar estaciones por distrito/lugar
4. ¿Qué línea debo tomar según mi ubicación?
5. Ver estaciones de transferencia
6. Calcular ruta entre estaciones
7. Salir

Seleccione una opción:
```

El menú principal permite acceder a todas las funcionalidades de la aplicación.

---

## 📚 Conceptos de Swift aplicados

Durante el desarrollo del proyecto se aplicaron diferentes conceptos de programación en Swift:

* `struct`
* `Array`
* `Dictionary`
* Funciones
* `filter`
* `map`
* `joined`
* `first`
* `firstIndex`
* `guard`
* `if / else`
* `switch`
* Ciclos `for`
* Ciclo `while`
* Opcionales (`?`)
* Manejo de entrada mediante `readLine()`
* Normalización de cadenas
* Cálculos matemáticos
* Organización de datos

---

## 👩‍💻 Autora

**Sarai Sthefanie Soto Lopez**

**Curso:** Programación en Móviles Avanzado

**Proyecto:** Metro Lima App

---

## ✅ Conclusión

El proyecto **Metro Lima App** permite aplicar conceptos fundamentales de programación en Swift mediante el desarrollo de una aplicación interactiva para consultar información de estaciones y líneas de transporte.

La aplicación integra estructuras de datos, funciones, búsquedas, filtros, cálculos de distancia y navegación mediante un menú de opciones, proporcionando una solución organizada para realizar consultas relacionadas con las estaciones del modelo utilizado en el proyecto.
