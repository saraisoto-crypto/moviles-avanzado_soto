import Foundation

// =====================================================================
// APP: METRO LIMA APP
// Curso: Programación en Móviles Avanzado
// =====================================================================

// =====================================================================
// MODELO
// =====================================================================

struct Estacion {
    let nombre: String
    let distrito: String
    var lineas: [Int]
    let lugares: [String]
}

// =====================================================================
// DATOS DE ESTACIONES
// =====================================================================

var estaciones: [Estacion] = [

    // ==================== LÍNEA 1 ====================

    Estacion(
        nombre: "Villa El Salvador",
        distrito: "Villa El Salvador",
        lineas: [1],
        lugares: [
            "Accesos de entrada y salida",
            "Comercios y servicios cercanos",
            "Paraderos de transporte público"
        ]
    ),

    Estacion(
        nombre: "Parque Industrial",
        distrito: "Villa El Salvador",
        lineas: [1],
        lugares: [
            "Zona industrial",
            "Comercios cercanos",
            "Paraderos de transporte público"
        ]
    ),

    Estacion(
        nombre: "Pumacahua",
        distrito: "Villa El Salvador",
        lineas: [1],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Villa María",
        distrito: "Villa María del Triunfo",
        lineas: [1],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "María Auxiliadora",
        distrito: "San Juan de Miraflores",
        lineas: [1],
        lugares: [
            "Hospital María Auxiliadora",
            "Comercios cercanos",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "San Juan",
        distrito: "San Juan de Miraflores",
        lineas: [1],
        lugares: [
            "Comercios y servicios",
            "Paraderos de transporte",
            "Zona comercial"
        ]
    ),

    Estacion(
        nombre: "Atocongo",
        distrito: "San Juan de Miraflores",
        lineas: [1],
        lugares: [
            "Centro Comercial Mall del Sur",
            "Comercios cercanos",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Jorge Chávez",
        distrito: "Santiago de Surco",
        lineas: [1],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Ayacucho",
        distrito: "Santiago de Surco",
        lineas: [1],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Cabitos",
        distrito: "Santiago de Surco",
        lineas: [1],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Angamos",
        distrito: "Surquillo",
        lineas: [1],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "San Borja Sur",
        distrito: "San Borja",
        lineas: [1],
        lugares: [
            "Parque de la Felicidad",
            "Comercios cercanos",
            "Servicios locales"
        ]
    ),

    Estacion(
        nombre: "La Cultura",
        distrito: "San Borja",
        lineas: [1],
        lugares: [
            "Museo de la Nación",
            "Biblioteca Nacional del Perú",
            "Gran Teatro Nacional"
        ]
    ),

    Estacion(
        nombre: "Nicolás Arriola",
        distrito: "La Victoria",
        lineas: [1],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Gamarra",
        distrito: "La Victoria",
        lineas: [1],
        lugares: [
            "Emporio Comercial de Gamarra",
            "Tiendas de ropa",
            "Comercios y servicios"
        ]
    ),

    Estacion(
        nombre: "Grau",
        distrito: "Cercado de Lima",
        lineas: [1],
        lugares: [
            "Hospital Nacional Dos de Mayo",
            "Centro Histórico cercano",
            "Comercios y servicios"
        ]
    ),

    Estacion(
        nombre: "Presbítero Maestro",
        distrito: "Cercado de Lima",
        lineas: [1],
        lugares: [
            "Cementerio Presbítero Matías Maestro",
            "Comercios cercanos",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Caja de Agua",
        distrito: "San Juan de Lurigancho",
        lineas: [1],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Pirámide del Sol",
        distrito: "San Juan de Lurigancho",
        lineas: [1],
        lugares: [
            "Zona comercial",
            "Comercios cercanos",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Los Jardines",
        distrito: "San Juan de Lurigancho",
        lineas: [1],
        lugares: [
            "Comercios y servicios",
            "Paraderos de transporte",
            "Zona residencial"
        ]
    ),

    Estacion(
        nombre: "Los Postes",
        distrito: "San Juan de Lurigancho",
        lineas: [1],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "San Carlos",
        distrito: "San Juan de Lurigancho",
        lineas: [1],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "San Martín",
        distrito: "San Juan de Lurigancho",
        lineas: [1],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Santa Rosa",
        distrito: "San Juan de Lurigancho",
        lineas: [1],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Bayóvar",
        distrito: "San Juan de Lurigancho",
        lineas: [1],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    // ==================== LÍNEA 2 ====================

    Estacion(
        nombre: "Municipalidad de Ate",
        distrito: "Ate",
        lineas: [2],
        lugares: [
            "Municipalidad de Ate",
            "Comercios cercanos",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Vista Alegre",
        distrito: "Ate",
        lineas: [2],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Prolongación Javier Prado",
        distrito: "Ate",
        lineas: [2],
        lugares: [
            "Avenida Javier Prado",
            "Comercios cercanos",
            "Servicios locales"
        ]
    ),

    Estacion(
        nombre: "Mercado Santa Anita",
        distrito: "Santa Anita",
        lineas: [2],
        lugares: [
            "Mercado de Productores de Santa Anita",
            "Comercios y restaurantes",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Hermilio Valdizán",
        distrito: "Santa Anita",
        lineas: [2],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Colectora Industrial",
        distrito: "Santa Anita",
        lineas: [2],
        lugares: [
            "Zona industrial",
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Óvalo Santa Anita",
        distrito: "Santa Anita",
        lineas: [2],
        lugares: [
            "Óvalo Santa Anita",
            "Comercios cercanos",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Evitamiento",
        distrito: "El Agustino",
        lineas: [2],
        lugares: [
            "Avenida Evitamiento",
            "Comercios cercanos",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "San Juan de Lurigancho",
        distrito: "San Juan de Lurigancho",
        lineas: [2],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    // ==================== LÍNEA 3 ====================

    Estacion(
        nombre: "Callao",
        distrito: "Callao",
        lineas: [3],
        lugares: [
            "Puerto del Callao",
            "Comercios cercanos",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Bellavista",
        distrito: "Bellavista",
        lineas: [3],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Carmen de la Legua",
        distrito: "Carmen de la Legua",
        lineas: [3],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "San Miguel",
        distrito: "San Miguel",
        lineas: [3],
        lugares: [
            "Parque de las Leyendas",
            "Comercios cercanos",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Magdalena",
        distrito: "Magdalena del Mar",
        lineas: [3],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Jesús María",
        distrito: "Jesús María",
        lineas: [3],
        lugares: [
            "Campo de Marte",
            "Comercios cercanos",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Lince",
        distrito: "Lince",
        lineas: [3],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Arequipa",
        distrito: "Lince",
        lineas: [3],
        lugares: [
            "Avenida Arequipa",
            "Comercios cercanos",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Miraflores",
        distrito: "Miraflores",
        lineas: [3],
        lugares: [
            "Parque Kennedy",
            "Comercios cercanos",
            "Paraderos de transporte"
        ]
    ),

    // ==================== LÍNEA 4 ====================

    Estacion(
        nombre: "Faustino Sánchez Carrión",
        distrito: "San Juan de Lurigancho",
        lineas: [4],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Santa Rosa",
        distrito: "San Juan de Lurigancho",
        lineas: [4],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "El Agustino",
        distrito: "El Agustino",
        lineas: [4],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "La Victoria",
        distrito: "La Victoria",
        lineas: [4],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Lince",
        distrito: "Lince",
        lineas: [4],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    // ==================== LÍNEA 5 ====================

    Estacion(
        nombre: "Villa El Salvador",
        distrito: "Villa El Salvador",
        lineas: [5],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "San Juan de Miraflores",
        distrito: "San Juan de Miraflores",
        lineas: [5],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Surco",
        distrito: "Santiago de Surco",
        lineas: [5],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "La Molina",
        distrito: "La Molina",
        lineas: [5],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    // ==================== LÍNEA 6 ====================

    Estacion(
        nombre: "Ate",
        distrito: "Ate",
        lineas: [6],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Santa Anita",
        distrito: "Santa Anita",
        lineas: [6],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "San Luis",
        distrito: "San Luis",
        lineas: [6],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "San Borja",
        distrito: "San Borja",
        lineas: [6],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Surquillo",
        distrito: "Surquillo",
        lineas: [6],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    ),

    Estacion(
        nombre: "Miraflores",
        distrito: "Miraflores",
        lineas: [6],
        lugares: [
            "Comercios cercanos",
            "Servicios locales",
            "Paraderos de transporte"
        ]
    )
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

func buscarEstacion(_ nombre: String) -> Estacion? {

    let buscada = normalizar(nombre)

    return estaciones.first {
        normalizar($0.nombre) == buscada
    }
}

// =====================================================================
// FUNCIÓN PARA OBTENER LÍNEAS DISPONIBLES
// =====================================================================

func obtenerLineasDisponibles() -> [Int] {

    var lineas: Set<Int> = []

    for estacion in estaciones {
        for linea in estacion.lineas {
            lineas.insert(linea)
        }
    }

    return lineas.sorted()
}

// =====================================================================
// 1. LISTAR ESTACIONES
// =====================================================================

func listarEstaciones() {

    print("\n=====================================================")
    print("              LISTAR ESTACIONES")
    print("=====================================================")

    let lineasDisponibles = obtenerLineasDisponibles()

    print("\nLíneas disponibles:")

    for (indice, linea) in lineasDisponibles.enumerated() {
        print("\(indice + 1). Línea \(linea)")
    }

    print("\(lineasDisponibles.count + 1). Todas las líneas (agrupadas)")

    print("\nSeleccione una opción:")

    guard let opcion = leerEntrada() else {
        print("Entrada no válida.")
        return
    }

    guard let opcionNumero = Int(opcion),
          opcionNumero >= 1,
          opcionNumero <= lineasDisponibles.count + 1 else {

        print("Opción inválida.")
        return
    }

    if opcionNumero == lineasDisponibles.count + 1 {

        // ---------------------------------------------------------
        // MOSTRAR TODAS LAS LÍNEAS AGRUPADAS
        // ---------------------------------------------------------

        print("\n--- TODAS LAS ESTACIONES ---")

        for linea in lineasDisponibles {

            print("\n=== LÍNEA \(linea) ===")

            var contador = 1

            for estacion in estaciones {

                if estacion.lineas.contains(linea) {

                    print(
                        "\(contador). \(estacion.nombre) - \(estacion.distrito)"
                    )

                    contador += 1
                }
            }
        }

    } else {

        // ---------------------------------------------------------
        // MOSTRAR ESTACIONES DE UNA LÍNEA ESPECÍFICA
        // ---------------------------------------------------------

        let lineaSeleccionada = lineasDisponibles[opcionNumero - 1]

        print("\n--- ESTACIONES LÍNEA \(lineaSeleccionada) ---")

        var contador = 1

        for estacion in estaciones {

            if estacion.lineas.contains(lineaSeleccionada) {

                print(
                    "\(contador). \(estacion.nombre) - \(estacion.distrito)"
                )

                contador += 1
            }
        }
    }
}

// =====================================================================
// 2. BUSCAR ESTACIÓN
// =====================================================================

func buscarPorNombre() {

    print("\n=====================================================")
    print("               BUSCAR ESTACIÓN")
    print("=====================================================")

    print("\nIngrese el nombre de la estación:")

    guard let nombre = leerEntrada(), !nombre.isEmpty else {
        print("Nombre no válido.")
        return
    }

    if let estacion = buscarEstacion(nombre) {

        print("\nEstación encontrada:")
        print("Nombre: \(estacion.nombre)")
        print("Distrito: \(estacion.distrito)")
        print("Líneas: \(estacion.lineas)")

    } else {

        print("\nNo se encontró la estación.")
    }
}

// =====================================================================
// 3. BUSCAR LÍNEAS POR DISTRITO
// =====================================================================

func buscarPorDistrito() {

    print("\n=====================================================")
    print("          LÍNEAS POR DISTRITO O LUGAR")
    print("=====================================================")

    print("\nIngrese el distrito o lugar:")

    guard let lugar = leerEntrada(), !lugar.isEmpty else {
        print("Lugar no válido.")
        return
    }

    let buscado = normalizar(lugar)

    let resultados = estaciones.filter {
        normalizar($0.distrito).contains(buscado)
    }

    if resultados.isEmpty {

        print("\nNo se encontraron estaciones en ese lugar.")
        return
    }

    print("\nEstaciones encontradas:")

    for estacion in resultados {

        print(
            "- \(estacion.nombre) | Líneas: \(estacion.lineas)"
        )
    }
}

// =====================================================================
// 4. LÍNEA SEGÚN UBICACIÓN
// =====================================================================

func lineaSegunUbicacion() {

    print("\n=====================================================")
    print("            LÍNEA SEGÚN UBICACIÓN")
    print("=====================================================")

    print("\nIngrese su ubicación:")

    guard let ubicacion = leerEntrada(), !ubicacion.isEmpty else {
        print("Ubicación no válida.")
        return
    }

    let buscada = normalizar(ubicacion)

    // Primero se verifica si lo escrito es una estación.
    if let estacion = buscarEstacion(ubicacion) {

        print("\nLa estación encontrada es:")
        print(estacion.nombre)

        print("Distrito: \(estacion.distrito)")
        print("Líneas disponibles: \(estacion.lineas)")

        return
    }

    // Si no es estación, se busca por distrito.
    let resultados = estaciones.filter {
        normalizar($0.distrito).contains(buscada)
    }

    if resultados.isEmpty {

        if buscada.contains("centro de lima") ||
            buscada == "centro" {

            print("\nEstás en el Centro de Lima.")
            print("Puedes dirigirte hacia una estación cercana.")
            print("Una opción es dirigirte hacia Grau.")

        } else {

            print("\nNo se encontraron estaciones cercanas.")
        }

        return
    }

    print("\nEstaciones disponibles desde \(ubicacion):")

    for estacion in resultados {

        print(
            "- \(estacion.nombre) → Líneas \(estacion.lineas)"
        )
    }
}

// =====================================================================
// 5. ESTACIONES DE TRANSFERENCIA
// =====================================================================

func estacionesTransferencia() {

    print("\n=====================================================")
    print("          ESTACIONES DE TRANSFERENCIA")
    print("=====================================================")

    let transferencias = estaciones.filter {
        $0.lineas.count > 1
    }

    if transferencias.isEmpty {

        print("\nActualmente no hay estaciones registradas")
        print("como transferencia entre líneas.")

    } else {

        for estacion in transferencias {

            print("- \(estacion.nombre)")
            print("  Líneas: \(estacion.lineas)")
        }
    }
}

// =====================================================================
// 6. CALCULAR RUTA
// =====================================================================

func calcularRuta() {

    print("\n=====================================================")
    print("                CALCULAR RUTA")
    print("=====================================================")

    print("\nIngrese la estación de origen:")

    guard let origen = leerEntrada(), !origen.isEmpty else {
        print("Origen no válido.")
        return
    }

    print("\nIngrese la estación de destino:")

    guard let destino = leerEntrada(), !destino.isEmpty else {
        print("Destino no válido.")
        return
    }

    guard let estacionOrigen = buscarEstacion(origen) else {

        print("\nNo se encontró la estación de origen.")
        return
    }

    guard let estacionDestino = buscarEstacion(destino) else {

        print("\nNo se encontró la estación de destino.")
        return
    }

    print("\n=====================================================")
    print("                  RESULTADO")
    print("=====================================================")

    print("Origen: \(estacionOrigen.nombre)")
    print("Destino: \(estacionDestino.nombre)")

    let lineasComunes = estacionOrigen.lineas.filter {
        estacionDestino.lineas.contains($0)
    }

    if let linea = lineasComunes.first {

        let estacionesLinea = estaciones.filter {
            $0.lineas.contains(linea)
        }

        guard let indiceOrigen = estacionesLinea.firstIndex(where: {
            normalizar($0.nombre) ==
            normalizar(estacionOrigen.nombre)
        }) else {
            return
        }

        guard let indiceDestino = estacionesLinea.firstIndex(where: {
            normalizar($0.nombre) ==
            normalizar(estacionDestino.nombre)
        }) else {
            return
        }

        let cantidadParadas = abs(
            indiceDestino - indiceOrigen
        )

        print("Línea recomendada: Línea \(linea)")
        print("Número de paradas: \(cantidadParadas)")

    } else {

        print("El viaje requiere realizar una transferencia.")
        print("Línea de origen: \(estacionOrigen.lineas)")
        print("Línea de destino: \(estacionDestino.lineas)")
    }
}

// =====================================================================
// 7. AGREGAR ESTACIÓN
// =====================================================================

func agregarEstacion() {

    print("\n=====================================================")
    print("       AGREGAR ESTACIÓN A LÍNEA EXISTENTE")
    print("=====================================================")

    let lineasDisponibles = obtenerLineasDisponibles()

    print("\nSeleccione la línea:")

    for (indice, linea) in lineasDisponibles.enumerated() {
        print("\(indice + 1). Línea \(linea)")
    }

    guard let opcion = leerEntrada() else {
        print("Entrada no válida.")
        return
    }

    guard let opcionNumero = Int(opcion),
          opcionNumero >= 1,
          opcionNumero <= lineasDisponibles.count else {

        print("Línea inválida.")
        return
    }

    let linea = lineasDisponibles[opcionNumero - 1]

    print("\nIngrese el nombre de la estación:")

    guard let nombre = leerEntrada(),
          !nombre.isEmpty else {

        print("Nombre inválido.")
        return
    }

    print("\nIngrese el distrito:")

    guard let distrito = leerEntrada(),
          !distrito.isEmpty else {

        print("Distrito inválido.")
        return
    }

    print("\nIngrese lugares o servicios separados por coma:")

    guard let entradaLugares = leerEntrada(),
          !entradaLugares.isEmpty else {

        let nuevaEstacion = Estacion(
            nombre: nombre,
            distrito: distrito,
            lineas: [linea],
            lugares: [
                "Comercios cercanos",
                "Servicios locales",
                "Paraderos de transporte"
            ]
        )

        estaciones.append(nuevaEstacion)

        print("\nEstación agregada correctamente.")
        return
    }

    let lugares = entradaLugares
        .split(separator: ",")
        .map {
            $0.trimmingCharacters(
                in: .whitespacesAndNewlines
            )
        }

    let nuevaEstacion = Estacion(
        nombre: nombre,
        distrito: distrito,
        lineas: [linea],
        lugares: lugares
    )

    estaciones.append(nuevaEstacion)

    print("\n=====================================================")
    print("             ESTACIÓN AGREGADA")
    print("=====================================================")

    print("Nombre: \(nombre)")
    print("Distrito: \(distrito)")
    print("Línea: \(linea)")

    print("\nLugares registrados:")

    for lugar in lugares {
        print("- \(lugar)")
    }
}

// =====================================================================
// FUNCIÓN PARA BUSCAR ESTACIÓN DE PARTIDA
// =====================================================================

func obtenerEstacionDePartida(
    ubicacion: String,
    lineaDestino: Int
) -> Estacion? {

    let ubicacionNormalizada = normalizar(ubicacion)

    // -------------------------------------------------------------
    // PRIMERO: comprobar si escribió directamente una estación
    // -------------------------------------------------------------

    if let estacion = estaciones.first(where: {

        normalizar($0.nombre) == ubicacionNormalizada

    }) {

        // Comprobar que la estación pertenece a la línea del destino.
        if estacion.lineas.contains(lineaDestino) {
            return estacion
        }
    }

    // -------------------------------------------------------------
    // SEGUNDO: buscar por distrito
    // -------------------------------------------------------------

    let estacionesDelDistrito = estaciones.filter {

        normalizar($0.distrito) == ubicacionNormalizada &&
        $0.lineas.contains(lineaDestino)
    }

    if let primeraEstacion = estacionesDelDistrito.first {
        return primeraEstacion
    }

    // -------------------------------------------------------------
    // TERCERO: coincidencia parcial
    // -------------------------------------------------------------

    if let estacion = estaciones.first(where: {

        normalizar($0.distrito).contains(ubicacionNormalizada) &&
        $0.lineas.contains(lineaDestino)

    }) {

        return estacion
    }

    return nil
}

// =====================================================================
// 8. PLANIFICAR VIAJE
// =====================================================================

func planificarViaje() {

    print("\n=====================================================")
    print("                PLANIFICAR VIAJE")
    print("=====================================================")

    print("\nIngrese su ubicación actual:")

    guard let ubicacion = leerEntrada(),
          !ubicacion.isEmpty else {

        print("Ubicación no válida.")
        return
    }

    print("\nIngrese la estación de destino:")

    guard let destino = leerEntrada(),
          !destino.isEmpty else {

        print("Destino no válido.")
        return
    }

    // -------------------------------------------------------------
    // BUSCAR DESTINO
    // -------------------------------------------------------------

    guard let estacionDestino = buscarEstacion(destino) else {

        print("\nNo se encontró la estación '\(destino)'.")
        return
    }

    let lineaDestino = estacionDestino.lineas.first ?? 0

    // -------------------------------------------------------------
    // BUSCAR ORIGEN
    // -------------------------------------------------------------

    guard let estacionOrigen = obtenerEstacionDePartida(
        ubicacion: ubicacion,
        lineaDestino: lineaDestino
    ) else {

        print("\nNo se encontró una estación de partida")
        print("compatible con la Línea \(lineaDestino).")

        print("\nPuedes ingresar directamente")
        print("el nombre de una estación.")

        return
    }

    // -------------------------------------------------------------
    // OBTENER ESTACIONES DE LA LÍNEA
    // -------------------------------------------------------------

    let estacionesLinea = estaciones.filter {

        $0.lineas.contains(lineaDestino)
    }

    guard let indiceOrigen = estacionesLinea.firstIndex(where: {

        normalizar($0.nombre) ==
        normalizar(estacionOrigen.nombre)

    }) else {

        print("\nNo se pudo determinar la estación de origen.")
        return
    }

    guard let indiceDestino = estacionesLinea.firstIndex(where: {

        normalizar($0.nombre) ==
        normalizar(estacionDestino.nombre)

    }) else {

        print("\nNo se pudo determinar la estación de destino.")
        return
    }

    // -------------------------------------------------------------
    // CALCULAR PARADAS
    // -------------------------------------------------------------

    let cantidadParadas = abs(
        indiceDestino - indiceOrigen
    )

    // -------------------------------------------------------------
    // MOSTRAR PLAN
    // -------------------------------------------------------------

    print("\n=====================================================")
    print("                  PLAN DE VIAJE")
    print("=====================================================")

    print("Ubicación actual: \(ubicacion)")
    print("Estación de partida: \(estacionOrigen.nombre)")
    print("Destino: \(estacionDestino.nombre)")
    print("Distrito destino: \(estacionDestino.distrito)")

    print("\n-----------------------------------------------------")
    print("INDICACIONES")
    print("-----------------------------------------------------")

    if normalizar(ubicacion) ==
        normalizar(estacionOrigen.nombre) {

        print("Ya te encuentras en la estación")
        print("\(estacionOrigen.nombre).")

    } else {

        print("Dirígete hacia la estación:")
        print("\(estacionOrigen.nombre)")
    }

    print("\nToma la Línea \(lineaDestino).")
    print("Continúa hasta \(estacionDestino.nombre).")

    // -------------------------------------------------------------
    // RECORRIDO
    // -------------------------------------------------------------

    print("\n-----------------------------------------------------")
    print("                    RECORRIDO")
    print("-----------------------------------------------------")

    if indiceOrigen < indiceDestino {

        for indice in indiceOrigen...indiceDestino {

            if indice == indiceOrigen {

                print(
                    "Inicio → \(estacionesLinea[indice].nombre)"
                )

            } else {

                let parada = indice - indiceOrigen

                print(
                    "\(parada). \(estacionesLinea[indice].nombre)"
                )
            }
        }

    } else if indiceOrigen > indiceDestino {

        for indice in stride(
            from: indiceOrigen,
            through: indiceDestino,
            by: -1
        ) {

            if indice == indiceOrigen {

                print(
                    "Inicio → \(estacionesLinea[indice].nombre)"
                )

            } else {

                let parada = indiceOrigen - indice

                print(
                    "\(parada). \(estacionesLinea[indice].nombre)"
                )
            }
        }

    } else {

        print("Ya te encuentras en la estación de destino.")
    }

    // -------------------------------------------------------------
    // RESUMEN
    // -------------------------------------------------------------

    print("\n-----------------------------------------------------")
    print("              RESUMEN DEL VIAJE")
    print("-----------------------------------------------------")

    print("Estación de partida: \(estacionOrigen.nombre)")
    print("Estación de destino: \(estacionDestino.nombre)")
    print("Línea: \(lineaDestino)")
    print("Número de paradas: \(cantidadParadas)")

    // -------------------------------------------------------------
    // QUÉ ENCONTRARÁS
    // -------------------------------------------------------------

    print("\n-----------------------------------------------------")
    print("        ¿QUÉ ENCONTRARÁS AL LLEGAR?")
    print("-----------------------------------------------------")

    print(
        "En \(estacionDestino.nombre) puedes encontrar:"
    )

    for lugar in estacionDestino.lugares {

        print("- \(lugar)")
    }

    // -------------------------------------------------------------
    // COBRO
    // -------------------------------------------------------------

    let tarifa = 1.50

    print("\n-----------------------------------------------------")
    print("              COBRO DE TARJETA")
    print("-----------------------------------------------------")

    print(
        String(
            format: "Tarifa del viaje: S/ %.2f",
            tarifa
        )
    )

    print(
        String(
            format:
                "Se descontará S/ %.2f del saldo de la tarjeta.",
            tarifa
        )
    )

    print("\n=====================================================")
    print("          VIAJE PLANIFICADO CORRECTAMENTE")
    print("=====================================================")
}

// =====================================================================
// MENÚ PRINCIPAL
// =====================================================================

func mostrarMenu() {

    var continuar = true

    while continuar {

        print("\n")
        print("=====================================================")
        print("                 METRO LIMA APP")
        print("=====================================================")

        print("1. Listar estaciones")
        print("2. Buscar estación")
        print("3. Buscar líneas por distrito o lugar")
        print("4. Línea según ubicación")
        print("5. Estaciones de transferencia")
        print("6. Calcular ruta")
        print("7. Agregar estación a línea existente")
        print("8. Planificar viaje")
        print("0. Salir")

        print("\nSeleccione una opción:")

        guard let opcion = leerEntrada() else {

            print("Entrada no válida.")
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
            lineaSegunUbicacion()

        case "5":
            estacionesTransferencia()

        case "6":
            calcularRuta()

        case "7":
            agregarEstacion()

        case "8":
            planificarViaje()

        case "0":

            continuar = false

            print("\nGracias por utilizar Metro Lima App.")

        default:

            print("\nOpción inválida.")
        }
    }
}

// =====================================================================
// INICIO DEL PROGRAMA
// =====================================================================

mostrarMenu()
