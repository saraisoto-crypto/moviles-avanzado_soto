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
// DATOS DE ESTACIONES
// =====================================================================

var estaciones: [Estacion] = [

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

    // ---------- LÍNEA 2 (27 estaciones oficiales según metrolima2.com) ----------
    // Tramo Este (Ate / Santa Anita)
    Estacion(nombre: "Municipalidad de Ate", distrito: "Ate", lineas: [2]),
    Estacion(nombre: "Prolongación Javier Prado", distrito: "Ate", lineas: [2]),
    Estacion(nombre: "Vista Alegre", distrito: "Ate", lineas: [2, 5]),
    Estacion(nombre: "Mercado Santa Anita", distrito: "Santa Anita", lineas: [2]),
    Estacion(nombre: "Hermilio Valdizán", distrito: "Santa Anita", lineas: [2]),
    Estacion(nombre: "Colectora Industrial", distrito: "Santa Anita", lineas: [2]),
    Estacion(nombre: "Óvalo Santa Anita", distrito: "Santa Anita", lineas: [2]),
    Estacion(nombre: "Evitamiento", distrito: "Santa Anita", lineas: [2]),
    // Tramo Centro (La Victoria / Cercado de Lima)
    Estacion(nombre: "San Juan de Dios", distrito: "La Victoria", lineas: [2]),
    Estacion(nombre: "Circunvalación", distrito: "La Victoria", lineas: [2]),
    Estacion(nombre: "Nicolás Ayllón", distrito: "La Victoria", lineas: [2]),
    Estacion(nombre: "28 de Julio", distrito: "La Victoria", lineas: [2]),
    Estacion(nombre: "Cangallo", distrito: "La Victoria", lineas: [2]),
    Estacion(nombre: "Manco Cápac", distrito: "La Victoria", lineas: [2]),
    Estacion(nombre: "Estación Central", distrito: "Cercado de Lima", lineas: [2]),
    Estacion(nombre: "Plaza Bolognesi", distrito: "Cercado de Lima", lineas: [2]),
    Estacion(nombre: "Parque Murillo", distrito: "Cercado de Lima", lineas: [2]),
    Estacion(nombre: "Tingo María", distrito: "Cercado de Lima", lineas: [2]),
    Estacion(nombre: "La Alborada", distrito: "Cercado de Lima", lineas: [2]),
    Estacion(nombre: "Elio", distrito: "Cercado de Lima", lineas: [2]),
    Estacion(nombre: "San Marcos", distrito: "Cercado de Lima", lineas: [2]),
    // Tramo Oeste (Bellavista / Callao)
    Estacion(nombre: "Óscar R. Benavides", distrito: "Bellavista", lineas: [2]),
    Estacion(nombre: "Carmen de la Legua", distrito: "Carmen de la Legua", lineas: [2, 4]),
    Estacion(nombre: "Insurgentes", distrito: "Callao", lineas: [2]),
    Estacion(nombre: "Juan Pablo II", distrito: "Bellavista", lineas: [2]),
    Estacion(nombre: "Buenos Aires", distrito: "Bellavista", lineas: [2]),
    Estacion(nombre: "Puerto del Callao", distrito: "Callao", lineas: [2]),

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
// COORDENADAS APROXIMADAS POR DISTRITO
// =====================================================================

var coordenadasDistrito: [String: Coordenada] = [
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
    "san miguel": Coordenada(lat: -12.0775, lon: -77.0928),
    "santa anita": Coordenada(lat: -12.0436, lon: -76.9703)
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
    let radioTierra = 6371000.0

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

func coordenadaDeUbicacion(_ ubicacion: String) -> Coordenada? {
    let texto = normalizar(ubicacion)

    if let exacta = coordenadasDistrito.first(where: {
        texto == $0.key || texto.contains($0.key) || $0.key.contains(texto)
    }) {
        return exacta.value
    }

    if let est = estaciones.first(where: {
        normalizar($0.nombre).contains(texto) || texto.contains(normalizar($0.nombre))
    }) {
        return coordenadasDistrito[normalizar(est.distrito)]
    }

    return nil
}

func imprimirDistancia(desde coordUbicacion: Coordenada?, hasta estacion: Estacion) {
    guard let origen = coordUbicacion,
          let destino = coordenadasDistrito[normalizar(estacion.distrito)] else {
        return
    }

    let metros = distanciaHaversine(origen, destino)
    let minutos = metros / 83.3

    print("   📏 Distancia: \(Int(metros)) m  |  ⏱️  Caminando: ≈ \(Int(minutos.rounded())) min")
}

// =====================================================================
// SUGERIR ESTACIÓN (cuando el usuario escribe un distrito o algo ambiguo)
// =====================================================================

// Busca estaciones por nombre o distrito. Si hay varias, deja al usuario elegir.
func sugerirEstacion(_ texto: String, tipo: String, coordUsuario: Coordenada? = nil) -> Estacion? {

    let normalizado = normalizar(texto)

    // 1) Coincidencias por nombre de estación
    let porNombre = estaciones.filter {
        normalizar($0.nombre).contains(normalizado)
    }

    // 2) Coincidencias por distrito
    let porDistrito = estaciones.filter {
        normalizar($0.distrito).contains(normalizado) ||
        normalizado.contains(normalizar($0.distrito))
    }

    let candidatas = !porNombre.isEmpty ? porNombre : porDistrito

    guard !candidatas.isEmpty else {
        print("\n⚠️ No se encontró ninguna estación de \(tipo) que coincida con \"\(texto)\".")
        print("Tampoco hay estaciones registradas en ese distrito.")
        print("Prueba con la opción 3 para ver todas las estaciones disponibles.")
        return nil
    }

    if candidatas.count == 1 {
        print("\nℹ️ Interpretamos \"\(texto)\" como la estación \(candidatas[0].nombre) (\(candidatas[0].distrito)).")
        return candidatas[0]
    }

    print("\n🎯 Encontramos varias estaciones que coinciden con \"\(texto)\".")
    print("Elige una como \(tipo):\n")

    for (i, est) in candidatas.enumerated() {
        let lineasTexto = est.lineas.map { nombreLinea($0) }.joined(separator: ", ")
        print("\(i + 1). \(est.nombre) — \(est.distrito) [\(lineasTexto)]")
        imprimirDistancia(desde: coordUsuario, hasta: est)
    }

    print("\nIngresa el número de tu elección (o 0 para cancelar):")

    guard let entrada = leerEntrada(),
          let indice = Int(entrada),
          indice >= 1 && indice <= candidatas.count else {
        print("❌ Cancelado.")
        return nil
    }

    return candidatas[indice - 1]
}

// Wrapper por compatibilidad
func manejarEstacionNoEncontrada(_ texto: String, tipo: String) {
    _ = sugerirEstacion(texto, tipo: tipo)
}

// =====================================================================
// HELPERS DE RUTA
// =====================================================================

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

func buscarEstacionTransferencia(origen: Estacion, destino: Estacion) -> Estacion? {
    return estaciones.first(where: { estacion in
        estacion.lineas.count > 1 &&
        !Set(estacion.lineas).isDisjoint(with: Set(origen.lineas)) &&
        !Set(estacion.lineas).isDisjoint(with: Set(destino.lineas))
    })
}

func simularViaje(ruta: [Estacion], destinoFinal: String) {

    print("\n🚇 SIMULACIÓN DEL VIAJE:")

    for (indice, estacion) in ruta.enumerated() {

        let paradasRestantes = ruta.count - 1 - indice

        if estacion.nombre == destinoFinal {
            print("🏁 Llegaste a \(estacion.nombre) (\(estacion.distrito)). ¡Fin del viaje!")
        } else {
            print("📍 \(estacion.nombre) (\(estacion.distrito)) — faltan \(paradasRestantes) parada(s)")
        }
    }
}

// =====================================================================
// TARJETA DE TRANSPORTE
// =====================================================================

struct TarjetaTransporte {
    var saldo: Double
    var historial: [String]
}

let tarifaPasaje = 2.50

var miTarjeta = TarjetaTransporte(saldo: 5.00, historial: ["Saldo inicial: S/ 5.00"])

func consultarSaldo() {
    print("\n=====================================================")
    print("             SALDO DE TU TARJETA")
    print("=====================================================")
    print(String(format: "💳 Saldo actual: S/ %.2f", miTarjeta.saldo))
}

func recargarTarjeta() {
    print("\n=====================================================")
    print("           RECARGAR TARJETA")
    print("=====================================================")
    print("Ingrese el monto a recargar (S/):")

    guard let entrada = leerEntrada(),
          let monto = Double(entrada),
          monto > 0 else {
        print("Monto inválido. Debe ser un número mayor a 0.")
        return
    }

    miTarjeta.saldo += monto
    miTarjeta.historial.append(String(format: "Recarga: +S/ %.2f", monto))

    print(String(format: "\n✅ Recarga exitosa. Nuevo saldo: S/ %.2f", miTarjeta.saldo))
}

@discardableResult
func cobrarPasaje() -> Bool {
    if miTarjeta.saldo < tarifaPasaje {
        print(String(format: "\n❌ Saldo insuficiente (S/ %.2f). Necesitas recargar.", miTarjeta.saldo))
        return false
    }

    miTarjeta.saldo -= tarifaPasaje
    miTarjeta.historial.append(String(format: "Pasaje pagado: -S/ %.2f", tarifaPasaje))

    print(String(format: "\n💳 Pasaje cobrado: S/ %.2f | Saldo restante: S/ %.2f", tarifaPasaje, miTarjeta.saldo))
    return true
}

func verHistorialTarjeta() {
    print("\n=====================================================")
    print("           HISTORIAL DE MOVIMIENTOS")
    print("=====================================================")

    if miTarjeta.historial.isEmpty {
        print("No hay movimientos registrados.")
    } else {
        for movimiento in miTarjeta.historial {
            print("→ \(movimiento)")
        }
    }
}

func preguntarInicioViaje() {
    print("\n¿Deseas iniciar el viaje y cobrar el pasaje? (s/n)")
    if let respuesta = leerEntrada(), normalizar(respuesta) == "s" {
        cobrarPasaje()
    }
}

func menuTarjeta() {
    var enMenuTarjeta = true

    while enMenuTarjeta {
        print("\n=====================================================")
        print("             TARJETA DE TRANSPORTE")
        print("=====================================================")
        print("""
        1. Consultar saldo
        2. Recargar tarjeta
        3. Ver historial de movimientos
        4. Volver al menú principal
        """)
        print("Seleccione una opción:")

        guard let opcion = leerEntrada() else { continue }

        switch opcion {
        case "1": consultarSaldo()
        case "2": recargarTarjeta()
        case "3": verHistorialTarjeta()
        case "4": enMenuTarjeta = false
        default: print("Opción inválida.")
        }
    }
}

// =====================================================================
// MODO ADMINISTRADOR
// =====================================================================

let claveAdmin = "admin123"

func lineasExistentes() -> [Int] {
    var lineas: Set<Int> = []
    for estacion in estaciones {
        lineas.formUnion(estacion.lineas)
    }
    return lineas.sorted()
}

func asegurarCoordenadas(distrito: String) -> Bool {
    if coordenadasDistrito[normalizar(distrito)] != nil {
        return true
    }
    print("⚠️ No tenemos coordenadas para \"\(distrito)\". Ingresa latitud:")
    guard let latTexto = leerEntrada(), let lat = Double(latTexto) else {
        print("Latitud inválida.")
        return false
    }
    print("Ingresa longitud:")
    guard let lonTexto = leerEntrada(), let lon = Double(lonTexto) else {
        print("Longitud inválida.")
        return false
    }
    coordenadasDistrito[normalizar(distrito)] = Coordenada(lat: lat, lon: lon)
    return true
}

func agregarEstacionesALineaExistente() {

    print("\n=====================================================")
    print("      AGREGAR ESTACIONES A LÍNEA EXISTENTE")
    print("=====================================================")

    let lineas = lineasExistentes()
    print("Líneas existentes: \(lineas.map { String($0) }.joined(separator: ", "))")
    print("¿A qué línea quieres agregar estaciones?")

    guard let lineaTexto = leerEntrada(),
          let linea = Int(lineaTexto),
          lineas.contains(linea) else {
        print("Línea inválida o no existe.")
        return
    }

    print("¿Cuántas estaciones quieres agregar?")
    guard let cantidadTexto = leerEntrada(),
          let cantidad = Int(cantidadTexto),
          cantidad > 0 else {
        print("Cantidad inválida.")
        return
    }

    var agregadas = 0

    for i in 1...cantidad {
        print("\n--- Estación \(i) de \(cantidad) ---")

        print("Nombre de la estación:")
        guard let nombre = leerEntrada(), !nombre.isEmpty else {
            print("Nombre inválido. Se omite esta estación.")
            continue
        }

        if estaciones.contains(where: { normalizar($0.nombre) == normalizar(nombre) }) {
            print("Ya existe una estación con ese nombre. Se omite.")
            continue
        }

        print("Distrito de la estación:")
        guard let distrito = leerEntrada(), !distrito.isEmpty else {
            print("Distrito inválido. Se omite.")
            continue
        }

        if !asegurarCoordenadas(distrito: distrito) {
            print("No se pudo registrar el distrito. Se omite la estación.")
            continue
        }

        let nuevaEstacion = Estacion(nombre: nombre, distrito: distrito, lineas: [linea])
        estaciones.append(nuevaEstacion)
        agregadas += 1
        print("✅ \"\(nombre)\" agregada a \(nombreLinea(linea)).")
    }

    print("\n🎉 Total agregadas: \(agregadas) de \(cantidad).")
}

func agregarEstacionesNuevas() {

    print("\n=====================================================")
    print("           AGREGAR ESTACIONES NUEVAS")
    print("=====================================================")

    print("¿Cuántas estaciones quieres agregar?")
    guard let cantidadTexto = leerEntrada(),
          let cantidad = Int(cantidadTexto),
          cantidad > 0 else {
        print("Cantidad inválida.")
        return
    }

    var agregadas = 0

    for i in 1...cantidad {
        print("\n--- Estación \(i) de \(cantidad) ---")

        print("Nombre de la estación:")
        guard let nombre = leerEntrada(), !nombre.isEmpty else {
            print("Nombre inválido. Se omite.")
            continue
        }

        if estaciones.contains(where: { normalizar($0.nombre) == normalizar(nombre) }) {
            print("Ya existe una estación con ese nombre. Se omite.")
            continue
        }

        print("Distrito:")
        guard let distrito = leerEntrada(), !distrito.isEmpty else {
            print("Distrito inválido. Se omite.")
            continue
        }

        if !asegurarCoordenadas(distrito: distrito) {
            print("No se pudo registrar el distrito. Se omite.")
            continue
        }

        print("Líneas a las que pertenece (separadas por coma, ej: 1,5):")
        guard let lineasTexto = leerEntrada(), !lineasTexto.isEmpty else {
            print("Debes ingresar al menos una línea. Se omite.")
            continue
        }

        let lineas = lineasTexto
            .split(separator: ",")
            .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }

        if lineas.isEmpty {
            print("No se reconoció ninguna línea válida. Se omite.")
            continue
        }

        let nuevaEstacion = Estacion(nombre: nombre, distrito: distrito, lineas: lineas)
        estaciones.append(nuevaEstacion)
        agregadas += 1

        let lineasTextoFinal = lineas.map { nombreLinea($0) }.joined(separator: ", ")
        print("✅ \"\(nombre)\" agregada en \(distrito), líneas: \(lineasTextoFinal).")
    }

    print("\n🎉 Total agregadas: \(agregadas) de \(cantidad).")
}

func agregarLineaNueva() {

    print("\n=====================================================")
    print("              AGREGAR LÍNEA NUEVA")
    print("=====================================================")

    let lineas = lineasExistentes()
    print("Líneas existentes: \(lineas.map { String($0) }.joined(separator: ", "))")
    print("Número de la nueva línea:")

    guard let numeroTexto = leerEntrada(),
          let numero = Int(numeroTexto),
          !lineas.contains(numero) else {
        print("Número de línea inválido o ya existe.")
        return
    }

    print("¿Cuántas estaciones tendrá la \(nombreLinea(numero))?")
    guard let cantidadTexto = leerEntrada(),
          let cantidad = Int(cantidadTexto),
          cantidad > 0 else {
        print("Cantidad inválida.")
        return
    }

    var agregadas = 0

    for i in 1...cantidad {
        print("\n--- Estación \(i) de \(cantidad) de \(nombreLinea(numero)) ---")

        print("Nombre de la estación:")
        guard let nombre = leerEntrada(), !nombre.isEmpty else {
            print("Nombre inválido. Se omite.")
            continue
        }

        if estaciones.contains(where: { normalizar($0.nombre) == normalizar(nombre) }) {
            print("Ya existe una estación con ese nombre. Se omite.")
            continue
        }

        print("Distrito:")
        guard let distrito = leerEntrada(), !distrito.isEmpty else {
            print("Distrito inválido. Se omite.")
            continue
        }

        if !asegurarCoordenadas(distrito: distrito) {
            print("No se pudo registrar el distrito. Se omite.")
            continue
        }

        let nuevaEstacion = Estacion(nombre: nombre, distrito: distrito, lineas: [numero])
        estaciones.append(nuevaEstacion)
        agregadas += 1
        print("✅ \"\(nombre)\" agregada.")
    }

    print("\n🎉 \(nombreLinea(numero)) creada con \(agregadas) de \(cantidad) estaciones.")
}

func menuAdministrador() {

    print("\n=====================================================")
    print("             MODO ADMINISTRADOR")
    print("=====================================================")
    print("Ingrese la clave de acceso:")

    guard let clave = leerEntrada(), clave == claveAdmin else {
        print("❌ Clave incorrecta. Acceso denegado.")
        return
    }

    var enMenuAdmin = true

    while enMenuAdmin {
        print("\n=====================================================")
        print("             PANEL DE ADMINISTRADOR")
        print("=====================================================")
        print("""
        1. Agregar estaciones a línea existente
        2. Agregar estaciones nuevas (con sus líneas)
        3. Agregar línea nueva (con varias estaciones)
        4. Volver al menú principal
        """)
        print("Seleccione una opción:")

        guard let opcion = leerEntrada() else { continue }

        switch opcion {
        case "1": agregarEstacionesALineaExistente()
        case "2": agregarEstacionesNuevas()
        case "3": agregarLineaNueva()
        case "4": enMenuAdmin = false
        default: print("Opción inválida.")
        }
    }
}

// =====================================================================
// 1. LISTAR ESTACIONES
// =====================================================================

func listarEstaciones() {

    print("\n=====================================================")
    print("                 LISTAR ESTACIONES")
    print("=====================================================")

    let lineas = lineasExistentes()
    for (indice, linea) in lineas.enumerated() {
        print("\(indice + 1). \(nombreLinea(linea))")
    }
    print("\(lineas.count + 1). Todas las líneas")

    print("Seleccione una opción:")

    guard let opcion = leerEntrada(), let numero = Int(opcion) else {
        print("Opción inválida.")
        return
    }

    if numero == lineas.count + 1 {
        for linea in lineas {
            let lista = estacionesDeLinea(linea)
            print("\nESTACIONES DE LA \(nombreLinea(linea).uppercased()):")
            for (indice, estacion) in lista.enumerated() {
                print("\(indice + 1). \(estacion.nombre) — \(estacion.distrito)")
            }
        }
    } else if numero >= 1 && numero <= lineas.count {
        let linea = lineas[numero - 1]
        let lista = estacionesDeLinea(linea)
        print("\nESTACIONES DE LA \(nombreLinea(linea).uppercased()):")
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

    guard let entrada = leerEntrada(), !entrada.isEmpty else {
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
            let lineasTexto = estacion.lineas.map { nombreLinea($0) }.joined(separator: ", ")
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

    guard let entrada = leerEntrada(), !entrada.isEmpty else {
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
            let lineasTexto = estacion.lineas.map { nombreLinea($0) }.joined(separator: ", ")
            print("→ \(estacion.nombre)")
            print("   Distrito: \(estacion.distrito)")
            print("   Líneas: \(lineasTexto)")
        }
    }
}

// =====================================================================
// 4. ¿QUÉ LÍNEA DEBO TOMAR?
// =====================================================================

func queLineaTomar() {

    print("\n=====================================================")
    print("             ¿QUÉ LÍNEA DEBO TOMAR?")
    print("=====================================================")

    print("\n¿Dónde te encuentras? (distrito o lugar)")
    print("Ejemplo: Centro de Lima, San Borja, Santa Anita")

    guard let ubicacion = leerEntrada(), !ubicacion.isEmpty else {
        print("Debes escribir una ubicación.")
        return
    }

    let ubicacionNormalizada = normalizar(ubicacion)

    let esCentroDeLima =
        ubicacionNormalizada.contains("centro de lima") ||
        ubicacionNormalizada.contains("cercado de lima")

    var coordUbicacion: Coordenada? = esCentroDeLima
        ? coordenadasDistrito["cercado de lima"]
        : coordenadaDeUbicacion(ubicacion)

    if coordUbicacion == nil {
        coordUbicacion = coordenadasDistrito.first(where: {
            $0.key.contains(ubicacionNormalizada) ||
            ubicacionNormalizada.contains($0.key)
        })?.value
    }

    var estacionesCercanas: [Estacion] = []

    if esCentroDeLima {
        estacionesCercanas = estaciones.filter {
            normalizar($0.distrito).contains("cercado de lima")
        }
    } else {
        estacionesCercanas = estaciones.filter {
            normalizar($0.distrito).contains(ubicacionNormalizada) ||
            ubicacionNormalizada.contains(normalizar($0.distrito))
        }
    }

    if estacionesCercanas.isEmpty, let origenCoord = coordUbicacion {

        print("\nℹ️ No hay estaciones registradas en \"\(ubicacion)\".")
        print("🔎 Buscando las estaciones más cercanas por distancia...\n")

        let estacionesConDistancia = estaciones.compactMap { est -> (Estacion, Double)? in
            guard let coordEst = coordenadasDistrito[normalizar(est.distrito)] else { return nil }
            let metros = distanciaHaversine(origenCoord, coordEst)
            return (est, metros)
        }
        .sorted { $0.1 < $1.1 }

        estacionesCercanas = estacionesConDistancia.prefix(5).map { $0.0 }

        if estacionesCercanas.isEmpty {
            print("⚠️ No se pudo calcular cercanía (faltan coordenadas).")
            return
        }
    }

    print("\n=====================================================")
    print("                 RESULTADO")
    print("=====================================================")
    print("📍 Tu ubicación: \(ubicacion)")

    if estacionesCercanas.isEmpty {
        print("\n⚠️ No encontramos estaciones registradas cerca de \"\(ubicacion)\".")
        print("Prueba con la opción 3 para ver todos los distritos con estaciones.")
        return
    }

    print("\n¿Quieres filtrar por alguna línea específica? (s/n)")
    var lineaFiltro: Int? = nil

    if let resp = leerEntrada(), normalizar(resp) == "s" {
        let lineas = lineasExistentes()
        print("Líneas disponibles: \(lineas.map { String($0) }.joined(separator: ", "))")
        print("Ingresa el número de línea:")
        if let lineaTexto = leerEntrada(), let l = Int(lineaTexto), lineas.contains(l) {
            lineaFiltro = l
        } else {
            print("Línea inválida. Se mostrarán todas.")
        }
    }

    let filtradas = lineaFiltro == nil
        ? estacionesCercanas
        : estacionesCercanas.filter { $0.lineas.contains(lineaFiltro!) }

    if filtradas.isEmpty {
        print("\nNo hay estaciones de \(nombreLinea(lineaFiltro!)) en \(ubicacion).")
        print("\nEstaciones disponibles en \(ubicacion):")
        for est in estacionesCercanas {
            let lineasTexto = est.lineas.map { nombreLinea($0) }.joined(separator: ", ")
            print("→ \(est.nombre) — \(lineasTexto)")
        }
        return
    }

    print("\n🚉 Estaciones cercanas a ti:")

    var mejorEstacion: Estacion? = nil
    var mejorDistancia: Double = .infinity

    for estacion in filtradas {
        let lineasTexto = estacion.lineas.map { nombreLinea($0) }.joined(separator: ", ")
        print("\n→ \(estacion.nombre)")
        print("   Distrito: \(estacion.distrito)")
        print("   Líneas: \(lineasTexto)")

        if let origen = coordUbicacion,
           let destino = coordenadasDistrito[normalizar(estacion.distrito)] {
            let metros = distanciaHaversine(origen, destino)
            let minutos = metros / 83.3
            print("   📏 Distancia: \(Int(metros)) m  |  ⏱️  Caminando: ≈ \(Int(minutos.rounded())) min")

            if metros < mejorDistancia {
                mejorDistancia = metros
                mejorEstacion = estacion
            }
        } else {
            print("   ⚠️ No se pudo calcular la distancia (distrito sin coordenadas).")
        }
    }

    print("\n=====================================================")
    print("                 RECOMENDACIÓN")
    print("=====================================================")

    if let mejor = mejorEstacion {
        print("✅ La estación más cercana para ti es: \(mejor.nombre)")
        print("   📍 Distrito: \(mejor.distrito)")
        print("   🚇 Líneas: \(mejor.lineas.map { nombreLinea($0) }.joined(separator: ", "))")
        print("   📏 Distancia: \(Int(mejorDistancia)) m")
        print("   ⏱️  Tiempo caminando: ≈ \(Int((mejorDistancia / 83.3).rounded())) min")

        print("\n📌 Instrucciones:")
        print("1. Camina desde \(ubicacion) hasta \(mejor.nombre).")
        print("2. Toma la \(mejor.lineas.map { nombreLinea($0) }.joined(separator: " o ")).")
        print("\nℹ️ Las distancias son aproximadas (línea recta entre centroides de distrito).")

    } else {
        print("No se pudo determinar la estación más cercana.")
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
            let lineasTexto = estacion.lineas.map { nombreLinea($0) }.joined(separator: " y ")
            print("→ \(estacion.nombre)")
            print("   Distrito: \(estacion.distrito)")
            print("   Líneas: \(lineasTexto)")
        }
    }
}

// =====================================================================
// 6. CALCULAR RUTA ENTRE ESTACIONES
// =====================================================================

func calcularRuta() {

    print("\n=====================================================")
    print("             CALCULAR RUTA")
    print("=====================================================")

    print("Ingrese estación de origen:")
    guard let origenTexto = leerEntrada(), !origenTexto.isEmpty else {
        print("Origen inválido.")
        return
    }

    print("Ingrese estación de destino:")
    guard let destinoTexto = leerEntrada(), !destinoTexto.isEmpty else {
        print("Destino inválido.")
        return
    }

    let origenNormalizado = normalizar(origenTexto)
    let destinoNormalizado = normalizar(destinoTexto)

    // Intento 1: coincidencia por nombre de estación
    var origen = estaciones.first(where: {
        normalizar($0.nombre).contains(origenNormalizado)
    })

    // Fallback: sugerir estación (por distrito o lista)
    if origen == nil {
        origen = sugerirEstacion(origenTexto, tipo: "origen")
    }

    guard let origenEst = origen else { return }

    var destino = estaciones.first(where: {
        normalizar($0.nombre).contains(destinoNormalizado)
    })

    if destino == nil {
        destino = sugerirEstacion(destinoTexto, tipo: "destino")
    }

    guard let destinoEst = destino else { return }

    print("\n=====================================================")
    print("                  RESULTADO")
    print("=====================================================")
    print("🟢 Origen:  \(origenEst.nombre) (\(origenEst.distrito))")
    print("🔴 Destino: \(destinoEst.nombre) (\(destinoEst.distrito))")

    let lineasComunes = origenEst.lineas.filter { destinoEst.lineas.contains($0) }

    if let linea = lineasComunes.first,
       let rango = tramoEnLinea(linea, desde: origenEst, hasta: destinoEst) {

        print("Línea recomendada: \(nombreLinea(linea))")
        print("Número de paradas: \(rango.count - 1)")

        print("\n📋 Ruta detallada:")
        for (i, estacion) in rango.enumerated() {
            let prefijo = i == 0 ? "🟢" : (i == rango.count - 1 ? "🔴" : "⚪️")
            print("\(prefijo) \(estacion.nombre) — \(estacion.distrito)")
        }

        simularViaje(ruta: rango, destinoFinal: destinoEst.nombre)
        preguntarInicioViaje()

    } else if let transferencia = buscarEstacionTransferencia(origen: origenEst, destino: destinoEst),
              let lineaOrigen = origenEst.lineas.first(where: { transferencia.lineas.contains($0) }),
              let lineaDestino = destinoEst.lineas.first(where: { transferencia.lineas.contains($0) }),
              let tramo1 = tramoEnLinea(lineaOrigen, desde: origenEst, hasta: transferencia),
              let tramo2 = tramoEnLinea(lineaDestino, desde: transferencia, hasta: destinoEst) {

        let rutaCompleta = tramo1 + tramo2.dropFirst()

        print("Línea recomendada: \(nombreLinea(lineaOrigen)) → transbordo en \(transferencia.nombre) → \(nombreLinea(lineaDestino))")
        print("Número de paradas total: \(rutaCompleta.count - 1)")

        print("\n📋 Ruta detallada:")
        print("Tramo 1 — \(nombreLinea(lineaOrigen)):")
        for (i, estacion) in tramo1.enumerated() {
            let prefijo = i == 0 ? "🟢" : "⚪️"
            print("\(prefijo) \(estacion.nombre) — \(estacion.distrito)")
        }
        print("🔄 Transbordo en \(transferencia.nombre) hacia \(nombreLinea(lineaDestino))")
        print("Tramo 2 — \(nombreLinea(lineaDestino)):")
        for (i, estacion) in tramo2.enumerated() {
            let prefijo = i == tramo2.count - 1 ? "🔴" : "⚪️"
            print("\(prefijo) \(estacion.nombre) — \(estacion.distrito)")
        }

        simularViaje(ruta: Array(rutaCompleta), destinoFinal: destinoEst.nombre)
        preguntarInicioViaje()

    } else {
        print("\n❌ No existe una ruta disponible entre estas estaciones.")
        print("(no comparten línea ni se encontró estación de transbordo)")
    }
}

// =====================================================================
// 7. PLANIFICAR VIAJE
// =====================================================================

func planificarViaje() {

    print("\n=====================================================")
    print("             PLANIFICAR VIAJE")
    print("=====================================================")
    print("Este modo te guía paso a paso durante todo el recorrido.")
    print("Al final podrás cobrar el pasaje desde tu tarjeta.\n")

    print("Ingrese estación de origen:")
    guard let origenTexto = leerEntrada(), !origenTexto.isEmpty else {
        print("Origen inválido.")
        return
    }

    print("Ingrese estación de destino:")
    guard let destinoTexto = leerEntrada(), !destinoTexto.isEmpty else {
        print("Destino inválido.")
        return
    }

    let origenNormalizado = normalizar(origenTexto)
    let destinoNormalizado = normalizar(destinoTexto)

    var origen = estaciones.first(where: {
        normalizar($0.nombre).contains(origenNormalizado)
    })

    if origen == nil {
        origen = sugerirEstacion(origenTexto, tipo: "origen")
    }

    guard let origenEst = origen else { return }

    var destino = estaciones.first(where: {
        normalizar($0.nombre).contains(destinoNormalizado)
    })

    if destino == nil {
        destino = sugerirEstacion(destinoTexto, tipo: "destino")
    }

    guard let destinoEst = destino else { return }

    print("\n=====================================================")
    print("            PLAN DE VIAJE")
    print("=====================================================")
    print("🟢 Origen:  \(origenEst.nombre) (\(origenEst.distrito))")
    print("🔴 Destino: \(destinoEst.nombre) (\(destinoEst.distrito))")
    print(String(format: "💳 Saldo actual: S/ %.2f  |  Tarifa: S/ %.2f", miTarjeta.saldo, tarifaPasaje))

    let lineasComunes = origenEst.lineas.filter { destinoEst.lineas.contains($0) }

    if let linea = lineasComunes.first,
       let rango = tramoEnLinea(linea, desde: origenEst, hasta: destinoEst) {

        print("\n🚇 Ruta directa por \(nombreLinea(linea))")
        print("📊 Total de paradas: \(rango.count - 1)")
        print("⏱️  Duración aproximada: \(max(rango.count - 1, 0) * 3) min (3 min por parada)")

        print("\n¿Deseas ver la simulación paso a paso? (s/n)")
        if let resp = leerEntrada(), normalizar(resp) == "s" {
            simularViaje(ruta: rango, destinoFinal: destinoEst.nombre)
        } else {
            print("\n📋 Ruta:")
            for estacion in rango {
                print("→ \(estacion.nombre)")
            }
        }

        preguntarInicioViaje()

    } else if let transferencia = buscarEstacionTransferencia(origen: origenEst, destino: destinoEst),
              let lineaOrigen = origenEst.lineas.first(where: { transferencia.lineas.contains($0) }),
              let lineaDestino = destinoEst.lineas.first(where: { transferencia.lineas.contains($0) }),
              let tramo1 = tramoEnLinea(lineaOrigen, desde: origenEst, hasta: transferencia),
              let tramo2 = tramoEnLinea(lineaDestino, desde: transferencia, hasta: destinoEst) {

        let rutaCompleta = tramo1 + tramo2.dropFirst()

        print("\n🔄 Se requiere transbordo en: \(transferencia.nombre)")
        print("   Tramo 1: \(nombreLinea(lineaOrigen)) (\(tramo1.count - 1) paradas)")
        print("   Tramo 2: \(nombreLinea(lineaDestino)) (\(tramo2.count - 1) paradas)")
        print("📊 Total de paradas: \(rutaCompleta.count - 1)")
        print("⏱️  Duración aproximada: \(max(rutaCompleta.count - 1, 0) * 3) min (3 min por parada)")

        print("\n¿Deseas ver la simulación paso a paso? (s/n)")
        if let resp = leerEntrada(), normalizar(resp) == "s" {

            print("\n🚇 SIMULACIÓN DEL VIAJE:")
            print("\n--- Tramo 1: \(nombreLinea(lineaOrigen)) ---")

            for (indice, estacion) in tramo1.enumerated() {

                if estacion.nombre == transferencia.nombre {
                    print("🔄 Llegaste a \(estacion.nombre). ¡Transborda a \(nombreLinea(lineaDestino))!")
                } else {
                    let restantes = tramo1.count - 1 - indice
                    print("📍 \(estacion.nombre) (\(estacion.distrito)) — faltan \(restantes) parada(s) para el transbordo")
                }
            }

            print("\n--- Tramo 2: \(nombreLinea(lineaDestino)) ---")
            for (indice, estacion) in tramo2.enumerated() {
                let restantes = tramo2.count - 1 - indice
                if estacion.nombre == destinoEst.nombre {
                    print("🏁 Llegaste a \(estacion.nombre) (\(estacion.distrito)). ¡Fin del viaje!")
                } else {
                    print("📍 \(estacion.nombre) (\(estacion.distrito)) — faltan \(restantes) parada(s) para \(destinoEst.nombre)")
                }
            }
        } else {
            print("\n📋 Ruta completa:")
            for estacion in rutaCompleta {
                print("→ \(estacion.nombre)")
            }
        }

        preguntarInicioViaje()

    } else {
        print("\n❌ No existe una ruta disponible entre estas estaciones.")
        print("(no comparten línea ni se encontró estación de transbordo)")
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
    7. Planificar viaje (guiado paso a paso)
    8. Gestionar tarjeta de transporte
    9. Modo administrador
    0. Salir
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
        planificarViaje()

    case "8":
        menuTarjeta()

    case "9":
        menuAdministrador()

    case "0":
        continuar = false
        print("\nGracias por usar Metro Lima App.")

    default:
        print("\nOpción inválida. Seleccione del 0 al 9.")
    }
}
