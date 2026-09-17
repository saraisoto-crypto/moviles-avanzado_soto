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

struct Coordenada {
    let lat: Double
    let lon: Double
}

// =====================================================================
// DATOS DE ESTACIONES (duplicados de transferencia eliminados)
// =====================================================================

let estaciones: [Estacion] = [

    // ---------- LÍNEA 1 ----------
    Estacion(nombre: "Villa El Salvador", distrito: "Villa El Salvador", lineas: [1, 5]),
    Estacion(nombre: "Parque Industrial", distrito: "Villa El Salvador", lineas: [1]),
    Estacion(nombre: "Pumacahua", distrito: "Villa María del Triunfo", lineas: [1]),
    Estacion(nombre: "Villa María", distrito: "Villa María del Triunfo", lineas: [1]),
    Estacion(nombre: "María Auxiliadora", distrito: "San Juan de Miraflores", lineas: [1]),
    Estacion(nombre: "San Juan", distrito: "San Juan de Miraflores", lineas: [1]),
    Estacion(nombre: "Atocongo", distrito: "San Juan de Miraflores", lineas: [1]),
    Estacion(nombre: "Jorge Chávez", distrito: "Santiago de Surco", lineas: [1]),
    Estacion(nombre: "Ayacucho", distrito: "Santiago de Surco", lineas: [1]),
    Estacion(nombre: "Cabitos", distrito: "Santiago de Surco", lineas: [1]),
    Estacion(nombre: "Angamos", distrito: "San Borja", lineas: [1]),
    Estacion(nombre: "San Borja Sur", distrito: "San Borja", lineas: [1]),
    Estacion(nombre: "La Cultura", distrito: "San Borja", lineas: [1]),
    Estacion(nombre: "Nicolás Arriola", distrito: "La Victoria", lineas: [1]),
    Estacion(nombre: "Gamarra", distrito: "La Victoria", lineas: [1]),
    Estacion(nombre: "Miguel Grau", distrito: "Cercado de Lima", lineas: [1]),
    Estacion(nombre: "El Ángel", distrito: "Cercado de Lima", lineas: [1]),
    Estacion(nombre: "Presbítero Maestro", distrito: "Cercado de Lima", lineas: [1]),
    Estacion(nombre: "Caja de Agua", distrito: "San Juan de Lurigancho", lineas: [1]),
    Estacion(nombre: "Pirámide del Sol", distrito: "San Juan de Lurigancho", lineas: [1]),
    Estacion(nombre: "Los Jardines", distrito: "San Juan de Lurigancho", lineas: [1]),
    Estacion(nombre: "Los Postes", distrito: "San Juan de Lurigancho", lineas: [1]),
    Estacion(nombre: "San Carlos", distrito: "San Juan de Lurigancho", lineas: [1]),
    Estacion(nombre: "San Martín", distrito: "San Juan de Lurigancho", lineas: [1]),
    Estacion(nombre: "Santa Rosa", distrito: "San Juan de Lurigancho", lineas: [1]),
    Estacion(nombre: "Bayóvar", distrito: "San Juan de Lurigancho", lineas: [1]),

    // ---------- LÍNEA 2 ----------
    Estacion(nombre: "Municipalidad de Ate", distrito: "Ate", lineas: [2]),
    Estacion(nombre: "Vista Alegre", distrito: "Ate", lineas: [2, 5]),
    Estacion(nombre: "Prolongación Javier Prado", distrito: "Ate", lineas: [2]),
    Estacion(nombre: "Ingeniería", distrito: "San Martín de Porres", lineas: [2]),
    Estacion(nombre: "San Marcos", distrito: "Cercado de Lima", lineas: [2]),
    Estacion(nombre: "Elio", distrito: "Cercado de Lima", lineas: [2]),
    Estacion(nombre: "La Alborada", distrito: "Cercado de Lima", lineas: [2]),
    Estacion(nombre: "Juan Pablo II", distrito: "Bellavista", lineas: [2]),
    Estacion(nombre: "Buenos Aires", distrito: "Bellavista", lineas: [2]),
    Estacion(nombre: "Puerto del Callao", distrito: "Callao", lineas: [2]),
    Estacion(nombre: "Insurgentes", distrito: "Callao", lineas: [2]),
    Estacion(nombre: "Carmen de la Legua", distrito: "Carmen de la Legua", lineas: [2, 4]),
    Estacion(nombre: "Óvalo 200 Millas", distrito: "Callao", lineas: [2]),
    Estacion(nombre: "Aeropuerto", distrito: "Callao", lineas: [2]),

    // ---------- LÍNEA 3 ----------
    Estacion(nombre: "Naranjal", distrito: "Independencia", lineas: [3]),
    Estacion(nombre: "Túpac Amaru", distrito: "Independencia", lineas: [3]),
    Estacion(nombre: "Universitaria", distrito: "Los Olivos", lineas: [3, 6]),
    Estacion(nombre: "Centro de Lima", distrito: "Cercado de Lima", lineas: [3]),
    Estacion(nombre: "Tacna", distrito: "Cercado de Lima", lineas: [3]),
    Estacion(nombre: "Avenida Arequipa", distrito: "Cercado de Lima", lineas: [3]),
    Estacion(nombre: "Miraflores", distrito: "Miraflores", lineas: [3, 6]),
    Estacion(nombre: "Surco", distrito: "Santiago de Surco", lineas: [3]),
    Estacion(nombre: "Chorrillos", distrito: "Chorrillos", lineas: [3]),

    // ---------- LÍNEA 4 ----------
    Estacion(nombre: "Gambetta", distrito: "Callao", lineas: [4]),
    Estacion(nombre: "Canta Callao", distrito: "Callao", lineas: [4]),
    Estacion(nombre: "Bocanegra", distrito: "Callao", lineas: [4]),
    Estacion(nombre: "Elmer Faucett", distrito: "Callao", lineas: [4]),
    Estacion(nombre: "Jorge Chávez", distrito: "Callao", lineas: [4]),

    // ---------- LÍNEA 5 ----------
    Estacion(nombre: "Mateo Pumacahua", distrito: "Villa María del Triunfo", lineas: [5]),
    Estacion(nombre: "Las Delicias", distrito: "Villa María del Triunfo", lineas: [5]),
    Estacion(nombre: "Estadio", distrito: "Villa El Salvador", lineas: [5]),

    // ---------- LÍNEA 6 ----------
    Estacion(nombre: "Independencia", distrito: "Independencia", lineas: [6]),
    Estacion(nombre: "Los Olivos", distrito: "Los Olivos", lineas: [6]),
    Estacion(nombre: "San Miguel", distrito: "San Miguel", lineas: [6]),
    Estacion(nombre: "Magdalena", distrito: "Magdalena", lineas: [6])
]

// =====================================================================
// COORDENADAS APROXIMADAS POR DISTRITO (centroide, uso académico)
// Se usan solo para estimar distancia en línea recta, no una ruta real.
// =====================================================================

let coordenadasDistrito: [String: Coordenada] = [
    "villa el salvador": Coordenada(lat: -12.2153, lon: -76.9438),
    "villa maria del triunfo": Coordenada(lat: -12.1622, lon: -76.9350),
    "san juan de miraflores": Coordenada(lat: -12.1547, lon: -76.9722),
    "santiago de surco": Coordenada(lat: -12.1352, lon: -76.9908),
    "san borja": Coordenada(lat: -12.1019, lon: -76.9975),
    "la victoria": Coordenada(lat: -12.0693, lon: -77.0198),
    "cercado de lima": Coordenada(lat: -12.0464, lon: -77.0428),
    "san juan de lurigancho": Coordenada(lat: -11.9971, lon: -77.0058),
    "ate": Coordenada(lat: -12.0333, lon: -76.9167),
    "san martin de porres": Coordenada(lat: -12.0000, lon: -77.0833),
    "bellavista": Coordenada(lat: -12.0578, lon: -77.1128),
    "callao": Coordenada(lat: -12.0566, lon: -77.1181),
    "carmen de la legua": Coordenada(lat: -12.0392, lon: -77.0942),
    "independencia": Coordenada(lat: -11.9903, lon: -77.0508),
    "los olivos": Coordenada(lat: -11.9800, lon: -77.0700),
    "miraflores": Coordenada(lat: -12.1211, lon: -77.0295),
    "chorrillos": Coordenada(lat: -12.1725, lon: -77.0181),
    "magdalena": Coordenada(lat: -12.0928, lon: -77.0742),
    "san miguel": Coordenada(lat: -12.0775, lon: -77.0928)
]

// =====================================================================
// FUNCIONES AUXILIARES
// =====================================================================

func normalizar(_ texto: String) -> String {
    return texto
        .folding(
            options: [.diacriticInsensitive, .caseInsensitive],
            locale: .current
        )
        .trimmingCharacters(in: .whitespacesAndNewlines)
}

func leerEntrada() -> String? {
    return readLine()?.trimmingCharacters(in: .whitespacesAndNewlines)
}

func nombreLinea(_ linea: Int) -> String {
    return "Línea \(linea)"
}

func estacionesDeLinea(_ linea: Int) -> [Estacion] {
    return estaciones.filter {
        $0.lineas.contains(linea)
    }
}

func distanciaHaversine(_ c1: Coordenada, _ c2: Coordenada) -> Double {
    let radioTierra = 6371000.0 // metros

    let lat1 = c1.lat * .pi / 180
    let lat2 = c2.lat * .pi / 180
    let deltaLat = (c2.lat - c1.lat) * .pi / 180
    let deltaLon = (c2.lon - c1.lon) * .pi / 180

    let a = sin(deltaLat / 2) * sin(deltaLat / 2) +
            cos(lat1) * cos(lat2) *
            sin(deltaLon / 2) * sin(deltaLon / 2)
    let c = 2 * atan2(sqrt(a), sqrt(1 - a))

    return radioTierra * c
}

// Busca la coordenada de un distrito de forma flexible (contiene / está contenido)
func coordenadaDeUbicacion(_ ubicacion: String) -> Coordenada? {
    let texto = normalizar(ubicacion)
    return coordenadasDistrito.first(where: {
        texto.contains($0.key) || $0.key.contains(texto)
    })?.value
}

// Imprime la distancia aproximada y el tiempo caminando entre una ubicación y una estación
func imprimirDistancia(desde coordUbicacion: Coordenada?, hasta estacion: Estacion) {
    guard let origen = coordUbicacion,
          let destino = coordenadasDistrito[normalizar(estacion.distrito)] else {
        return
    }

    let metros = distanciaHaversine(origen, destino)
    let minutos = metros / 83.3 // ritmo promedio de caminata: ~5 km/h

    print("   Distancia aproximada: \(Int(metros)) m (≈ \(Int(minutos.rounded())) min caminando)")
}

// =====================================================================
// PLANIFICACIÓN DE VIAJE (ruta directa, transbordo y simulación)
// =====================================================================

// Devuelve el tramo de estaciones entre "desde" y "hasta" dentro de UNA sola línea.
// Se usa tanto para rutas directas como para cada mitad de una ruta con transbordo.
func tramoEnLinea(_ linea: Int, desde: Estacion, hasta: Estacion) -> [Estacion]? {

    let lista = estacionesDeLinea(linea)

    guard let inicio = lista.firstIndex(where: { $0.nombre == desde.nombre }),
          let fin = lista.firstIndex(where: { $0.nombre == hasta.nombre }) else {
        return nil
    }

    return inicio <= fin
        ? Array(lista[inicio...fin])
        : Array(lista[fin...inicio].reversed())
}

// Si origen y destino NO comparten línea directa, busca una estación de transferencia
// (una estación con más de una línea) que conecte alguna línea del origen con alguna del destino.
func buscarEstacionTransferencia(origen: Estacion, destino: Estacion) -> Estacion? {
    return estaciones.first(where: { estacion in
        estacion.lineas.count > 1 &&
        !Set(estacion.lineas).isDisjoint(with: Set(origen.lineas)) &&
        !Set(estacion.lineas).isDisjoint(with: Set(destino.lineas))
    })
}

// Recorre la ruta estación por estación simulando el viaje.
// En cada parada muestra cuántas estaciones faltan para llegar al destino final.
func simularViaje(ruta: [Estacion], destinoFinal: String) {

    print("\n🚇 SIMULACIÓN DEL VIAJE:")

    for (indice, estacion) in ruta.enumerated() {

        let paradasRestantes = ruta.count - 1 - indice

        if estacion.nombre == destinoFinal {
            print("🏁 Llegaste a \(estacion.nombre) (\(estacion.distrito)). ¡Fin del viaje!")
        } else {
            print("📍 Llegando a \(estacion.nombre) (\(estacion.distrito)) — te faltan \(paradasRestantes) parada(s) para llegar a \(destinoFinal).")
        }
    }
}
// Cuando no se encuentra una estación por nombre, intenta sugerir estaciones
// cercanas por distrito; si no hay relación alguna, informa que esa zona no tiene Metro.
func manejarEstacionNoEncontrada(_ texto: String, tipo: String) {

    let normalizado = normalizar(texto)

    let sugerenciasPorDistrito = estaciones.filter {
        normalizar($0.distrito).contains(normalizado) ||
        normalizado.contains(normalizar($0.distrito))
    }

    print("\n⚠️ No se encontró ninguna estación de \(tipo) que coincida con \"\(texto)\".")

    if !sugerenciasPorDistrito.isEmpty {

        print("¿Quisiste decir alguna de estas estaciones cercanas a esa zona?")
        for estacion in sugerenciasPorDistrito {
            print("→ \(estacion.nombre) (\(estacion.distrito))")
        }

    } else {

        print("Es posible que ese lugar no tenga estaciones de Metro de Lima, o que el nombre esté mal escrito.")
        print("Prueba con la opción 2 (buscar por nombre) o 3 (buscar por distrito) para ver las estaciones disponibles.")
    }
}

// =====================================================================
// 1. LISTAR ESTACIONES
// =====================================================================

func listarEstaciones() {

    print("\n=====================================================")
    print("                 LISTAR ESTACIONES")
    print("=====================================================")

    print("""
    1. Línea 1
    2. Línea 2
    3. Línea 3
    4. Línea 4
    5. Línea 5
    6. Línea 6
    7. Todas las líneas
    """)

    print("Seleccione una opción:")

    guard let opcion = leerEntrada(), let numero = Int(opcion) else {
        print("Opción inválida.")
        return
    }

    if numero == 7 {

        for linea in 1...6 {
            let lista = estacionesDeLinea(linea)
            print("\nESTACIONES DE LA \(nombreLinea(linea).uppercased()):")
            for (indice, estacion) in lista.enumerated() {
                print("\(indice + 1). \(estacion.nombre) — \(estacion.distrito)")
            }
        }

    } else if (1...6).contains(numero) {

        let lista = estacionesDeLinea(numero)
        print("\nESTACIONES DE LA \(nombreLinea(numero).uppercased()):")
        for (indice, estacion) in lista.enumerated() {
            print("\(indice + 1). \(estacion.nombre) — \(estacion.distrito)")
        }

    } else {
        print("Opción inválida.")
    }
}

// =====================================================================
// 2. BUSCAR ESTACIÓN POR NOMBRE
// =====================================================================

func buscarPorNombre() {

    print("\n=====================================================")
    print("              BUSCAR ESTACIÓN POR NOMBRE")
    print("=====================================================")

    print("Ingrese el nombre de la estación:")

    guard let entrada = leerEntrada(),
          !entrada.isEmpty else {
        print("Debe ingresar un nombre.")
        return
    }

    let texto = normalizar(entrada)

    let resultados = estaciones.filter {
        normalizar($0.nombre).contains(texto)
    }

    if resultados.isEmpty {

        print("\nNo se encontró ninguna estación.")

    } else {

        print("\nESTACIONES ENCONTRADAS:")

        for estacion in resultados {

            let lineasTexto = estacion.lineas
                .map { nombreLinea($0) }
                .joined(separator: ", ")

            print("→ \(estacion.nombre)")
            print("   Distrito: \(estacion.distrito)")
            print("   Líneas: \(lineasTexto)")
        }
    }
}

// =====================================================================
// 3. BUSCAR POR DISTRITO / LUGAR
// =====================================================================

func buscarPorDistrito() {

    print("\n=====================================================")
    print("          BUSCAR ESTACIONES POR DISTRITO")
    print("=====================================================")

    print("Ingrese un distrito o lugar:")

    guard let entrada = leerEntrada(),
          !entrada.isEmpty else {
        print("Debe ingresar un lugar.")
        return
    }

    let texto = normalizar(entrada)

    let resultados = estaciones.filter {

        normalizar($0.distrito).contains(texto) ||
        normalizar($0.nombre).contains(texto)
    }

    if resultados.isEmpty {

        print("\nNo se encontraron estaciones.")

    } else {

        print("\nESTACIONES ENCONTRADAS:")

        for estacion in resultados {

            let lineasTexto = estacion.lineas
                .map { nombreLinea($0) }
                .joined(separator: ", ")

            print("→ \(estacion.nombre)")
            print("   Distrito: \(estacion.distrito)")
            print("   Líneas: \(lineasTexto)")
        }
    }
}

// =====================================================================
// 4. ¿QUÉ LÍNEA DEBO TOMAR? (con distancia y tiempo estimado)
// =====================================================================

func queLineaTomar() {

    print("\n=====================================================")
    print("             ¿QUÉ LÍNEA DEBO TOMAR?")
    print("=====================================================")

    print("\n¿Dónde te encuentras?")
    print("Ejemplo: Centro de Lima, Cercado de Lima, San Borja")

    guard let ubicacion = leerEntrada(),
          !ubicacion.isEmpty else {
        print("Debes escribir una ubicación.")
        return
    }

    print("\n¿Qué línea quieres tomar? (1-6)")

    guard let lineaTexto = leerEntrada(),
          let linea = Int(lineaTexto),
          (1...6).contains(linea) else {
        print("Línea inválida. Debes elegir una línea del 1 al 6.")
        return
    }

    let ubicacionNormalizada = normalizar(ubicacion)

    let esCentroDeLima =
        ubicacionNormalizada.contains("centro de lima") ||
        ubicacionNormalizada.contains("cercado de lima")

    // Coordenada aproximada de la ubicación del usuario (para calcular distancia)
    let coordUbicacion: Coordenada? = esCentroDeLima
        ? coordenadasDistrito["cercado de lima"]
        : coordenadaDeUbicacion(ubicacion)

    var estacionesEncontradas: [Estacion] = []

    if esCentroDeLima {

        estacionesEncontradas = estaciones.filter {
            normalizar($0.distrito).contains("cercado de lima") &&
            $0.lineas.contains(linea)
        }

    } else {

        estacionesEncontradas = estaciones.filter {
            normalizar($0.distrito).contains(ubicacionNormalizada) &&
            $0.lineas.contains(linea)
        }
    }

    print("\n=====================================================")
    print("                 RUTA HACIA LA LÍNEA")
    print("=====================================================")

    print("Tu ubicación: \(ubicacion)")
    print("Línea que quieres tomar: \(nombreLinea(linea))")

    if !estacionesEncontradas.isEmpty {

        print("\nEncontramos estas estaciones de \(nombreLinea(linea)):")

        for estacion in estacionesEncontradas {
            print("→ \(estacion.nombre)")
            imprimirDistancia(desde: coordUbicacion, hasta: estacion)
        }

        print("\nPara tomar \(nombreLinea(linea)), debes dirigirte a una de estas estaciones.")

        if estacionesEncontradas.count == 1 {

            print("\n📍 Dirección:")
            print("Desde \(ubicacion), debes dirigirte hacia:")
            print("→ \(estacionesEncontradas[0].nombre)")

        } else {

            print("\n📍 Puedes dirigirte hacia cualquiera de estas estaciones (elige la más cercana según la distancia mostrada arriba):")

            for estacion in estacionesEncontradas {
                print("→ \(estacion.nombre)")
            }
        }

        if coordUbicacion == nil {
            print("\n⚠️ No se pudo calcular la distancia porque no reconocemos ese distrito.")
        } else {
            print("\nℹ️ Las distancias son aproximadas: se calculan en línea recta entre el centro de tu distrito y el de la estación, no siguen calles reales.")
        }

    } else {

        print("\nNo encontramos una estación de \(nombreLinea(linea))")
        print("directamente en \(ubicacion).")

        print("\nDebes dirigirte a una estación de \(nombreLinea(linea)).")

        let estacionesLinea = estacionesDeLinea(linea)

        print("\nEstaciones disponibles:")

        for estacion in estacionesLinea {
            print("→ \(estacion.nombre) — \(estacion.distrito)")
            imprimirDistancia(desde: coordUbicacion, hasta: estacion)
        }

        if coordUbicacion == nil {
            print("\n⚠️ No se pudo calcular la distancia porque no reconocemos ese distrito.")
        } else {
            print("\nℹ️ Las distancias son aproximadas: se calculan en línea recta entre el centro de tu distrito y el de la estación, no siguen calles reales.")
        }
    }
}

// =====================================================================
// 5. ESTACIONES DE TRANSFERENCIA
// =====================================================================

func estacionesTransferencia() {

    print("\n=====================================================")
    print("            ESTACIONES DE TRANSFERENCIA")
    print("=====================================================")

    let transferencias = estaciones.filter { $0.lineas.count > 1 }

    if transferencias.isEmpty {

        print("No se encontraron estaciones de transferencia.")

    } else {

        for estacion in transferencias {

            let lineasTexto = estacion.lineas
                .map { nombreLinea($0) }
                .joined(separator: " y ")

            print("→ \(estacion.nombre)")
            print("   Distrito: \(estacion.distrito)")
            print("   Líneas: \(lineasTexto)")
        }
    }
}

// =====================================================================
// 6. CALCULAR RUTA ENTRE ESTACIONES (ahora con transbordo automático
//    y simulación de paradas restantes)
// =====================================================================

func calcularRuta() {

    print("\n=====================================================")
    print("             CALCULAR RUTA")
    print("=====================================================")

    print("Ingrese estación de origen:")

    guard let origenTexto = leerEntrada(),
          !origenTexto.isEmpty else {
        print("Origen inválido.")
        return
    }

    print("Ingrese estación de destino:")

    guard let destinoTexto = leerEntrada(),
          !destinoTexto.isEmpty else {
        print("Destino inválido.")
        return
    }

    let origenNormalizado = normalizar(origenTexto)
    let destinoNormalizado = normalizar(destinoTexto)

    guard let origen = estaciones.first(where: {
        normalizar($0.nombre).contains(origenNormalizado)
    }) else {

        manejarEstacionNoEncontrada(origenTexto, tipo: "origen")
        return
    }

    guard let destino = estaciones.first(where: {
        normalizar($0.nombre).contains(destinoNormalizado)
    }) else {

        manejarEstacionNoEncontrada(destinoTexto, tipo: "destino")
        return
    }

    print("\nORIGEN: \(origen.nombre)")
    print("DESTINO: \(destino.nombre)")

    // --- CASO 1: origen y destino comparten al menos una línea → ruta directa ---
    let lineasComunes = origen.lineas.filter { destino.lineas.contains($0) }

    if let linea = lineasComunes.first,
       let rango = tramoEnLinea(linea, desde: origen, hasta: destino) {

        print("\nRuta directa por \(nombreLinea(linea)):")

        for estacion in rango {
            print("→ \(estacion.nombre)")
        }

        print("\nNúmero de paradas: \(max(rango.count - 1, 0))")

        simularViaje(ruta: rango, destinoFinal: destino.nombre)

    } else if let transferencia = buscarEstacionTransferencia(origen: origen, destino: destino),
              let lineaOrigen = origen.lineas.first(where: { transferencia.lineas.contains($0) }),
              let lineaDestino = destino.lineas.first(where: { transferencia.lineas.contains($0) }),
              let tramo1 = tramoEnLinea(lineaOrigen, desde: origen, hasta: transferencia),
              let tramo2 = tramoEnLinea(lineaDestino, desde: transferencia, hasta: destino) {

        // --- CASO 2: no hay línea directa → se arma la ruta con transbordo ---
        let rutaCompleta = tramo1 + tramo2.dropFirst() // evita repetir la estación de transbordo

        print("\nNo hay línea directa. Se requiere transbordo en: \(transferencia.nombre)")
        print("\nRuta:")
        print("Tramo 1 — \(nombreLinea(lineaOrigen)):")
        for estacion in tramo1 {
            print("→ \(estacion.nombre)")
        }
        print("🔄 Transbordo en \(transferencia.nombre) hacia \(nombreLinea(lineaDestino))")
        print("Tramo 2 — \(nombreLinea(lineaDestino)):")
        for estacion in tramo2 {
            print("→ \(estacion.nombre)")
        }

        print("\nNúmero de paradas total: \(max(rutaCompleta.count - 1, 0))")

        simularViaje(ruta: Array(rutaCompleta), destinoFinal: destino.nombre)

    } else {

        print("\nNo existe una ruta disponible entre estas estaciones")
        print("(no comparten línea ni se encontró una estación de transbordo).")
    }
}

// =====================================================================
// MENÚ PRINCIPAL
// =====================================================================

var continuar = true

while continuar {

    print("\n=====================================================")
    print("                 METRO LIMA APP")
    print("=====================================================")

    print("""
    1. Listar estaciones
    2. Buscar estación por nombre
    3. Buscar estaciones por distrito/lugar
    4. ¿Qué línea debo tomar según mi ubicación?
    5. Ver estaciones de transferencia
    6. Calcular ruta entre estaciones
    7. Salir
    """)

    print("Seleccione una opción:")

    guard let opcion = leerEntrada() else {
        print("Opción inválida.")
        continue
    }

    switch opcion {

    case "1":
        listarEstaciones()

    case "2":
        buscarPorNombre()

    case "3":
        buscarPorDistrito()

    case "4":
        queLineaTomar()

    case "5":
        estacionesTransferencia()

    case "6":
        calcularRuta()

    case "7":
        continuar = false
        print("\nGracias por usar Metro Lima App.")

    default:
        print("\nOpción inválida. Seleccione del 1 al 7.")
    }
}
