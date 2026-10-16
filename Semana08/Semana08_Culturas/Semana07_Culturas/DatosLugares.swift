//
//  DatosLugares.swift
//  Semana07_Culturas
//
//  Created by Sarai Sthefanie Soto on 15/10/26.
//

import Foundation

struct DatosLugares {

    static func lugares(para nombreCultura: String) -> [Lugar] {
        let clave = nombreCultura.folding(options: .diacriticInsensitive, locale: .current).lowercased()

        if clave.contains("caral") {
            return [
                Lugar(nombre: "Pirámide Mayor", tipo: "Sitio arqueológico",
                      ubicacion: "Caral, valle de Supe, Barranca, Lima",
                      descripcion: "Es el edificio más grande de la ciudad sagrada de Caral. Tiene una gran escalinata y una plaza hundida al frente donde se hacían ceremonias.",
                      datoCurioso: "Caral tiene unos 5000 años y es Patrimonio Mundial de la UNESCO desde 2009.",
                      imagen: "caral_piramide_mayor"),
                Lugar(nombre: "Anfiteatro", tipo: "Edificio ceremonial",
                      ubicacion: "Caral, Barranca, Lima",
                      descripcion: "Edificio con una plaza circular hundida, usado para ceremonias y música.",
                      datoCurioso: "Ahí se encontraron 32 flautas hechas con huesos de aves.",
                      imagen: "caral_anfiteatro"),
                Lugar(nombre: "Pirámide de la Galería", tipo: "Edificio ceremonial",
                      ubicacion: "Caral, Barranca, Lima",
                      descripcion: "Edificio con galerías y cámaras, parte del centro religioso de la ciudad.",
                      datoCurioso: "Se encontró un quipu, un sistema de cuerdas con nudos para guardar información.",
                      imagen: "caral_piramide_galeria")
            ]
        }

        if clave.contains("chavin") {
            return [
                Lugar(nombre: "Templo Viejo", tipo: "Centro ceremonial",
                      ubicacion: "Chavín de Huántar, Huari, Áncash",
                      descripcion: "Es la parte más antigua del centro ceremonial. Tiene galerías subterráneas y canales de agua.",
                      datoCurioso: "Chavín de Huántar es Patrimonio Mundial de la UNESCO desde 1985.",
                      imagen: "chavin_templo_viejo"),
                Lugar(nombre: "Lanzón Monolítico", tipo: "Escultura",
                      ubicacion: "Chavín de Huántar, Huari, Áncash",
                      descripcion: "Escultura de granito que representa a una deidad con rasgos humanos y de felino.",
                      datoCurioso: "Está en el centro de una galería en forma de cruz y casi no recibe luz natural.",
                      imagen: "chavin_lanzon"),
                Lugar(nombre: "Plaza Circular", tipo: "Plaza ceremonial",
                      ubicacion: "Chavín de Huántar, Huari, Áncash",
                      descripcion: "Plaza hundida frente al templo, decorada con piedras talladas de felinos y personajes.",
                      datoCurioso: "Era un espacio donde se reunían las personas para los rituales.",
                      imagen: "chavin_plaza_circular")
            ]
        }

        if clave.contains("paracas") {
            return [
                Lugar(nombre: "Reserva Nacional de Paracas", tipo: "Área natural protegida",
                      ubicacion: "Paracas, Pisco, Ica",
                      descripcion: "Reserva en la costa con desierto, acantilados y playas. Viven aves marinas y lobos marinos.",
                      datoCurioso: "Es una de las áreas marinas protegidas más importantes del Perú.",
                      imagen: "paracas_reserva"),
                Lugar(nombre: "Candelabro de Paracas", tipo: "Geoglifo",
                      ubicacion: "Bahía de Paracas, Pisco, Ica",
                      descripcion: "Figura gigante dibujada en la ladera de un cerro frente al mar.",
                      datoCurioso: "Mide unos 180 metros de largo y se ve desde varios kilómetros mar adentro.",
                      imagen: "paracas_candelabro"),
                Lugar(nombre: "Museo Julio C. Tello", tipo: "Museo de sitio",
                      ubicacion: "Paracas, Pisco, Ica",
                      descripcion: "Muestra cerámica, textiles y cráneos de la cultura Paracas hallados en sus necrópolis.",
                      datoCurioso: "Lleva el nombre del arqueólogo que descubrió la necrópolis de Paracas en 1925.",
                      imagen: "paracas_museo")
            ]
        }

        if clave.contains("nazca") {
            return [
                Lugar(nombre: "Líneas de Nazca", tipo: "Geoglifos",
                      ubicacion: "Pampa de Nazca, Ica",
                      descripcion: "Dibujos gigantes sobre el desierto: colibrí, mono, araña, perro y más.",
                      datoCurioso: "Son Patrimonio Mundial de la UNESCO desde 1994 y se aprecian mejor desde el aire.",
                      imagen: "nazca_lineas"),
                Lugar(nombre: "Cahuachi", tipo: "Centro ceremonial",
                      ubicacion: "Valle del río Nazca, Ica",
                      descripcion: "Gran centro ceremonial de adobe con pirámides escalonadas.",
                      datoCurioso: "Era un lugar de peregrinación, no una ciudad donde vivía la gente.",
                      imagen: "nazca_cahuachi"),
                Lugar(nombre: "Acueductos de Cantalloc", tipo: "Obra hidráulica",
                      ubicacion: "Valle de Nazca, Ica",
                      descripcion: "Sistema de pozos en espiral que permitía llegar al agua subterránea.",
                      datoCurioso: "Todavía se usan hoy para llevar agua a los cultivos.",
                      imagen: "nazca_cantalloc")
            ]
        }

        if clave.contains("moche") {
            return [
                Lugar(nombre: "Huaca del Sol y de la Luna", tipo: "Templo de adobe",
                      ubicacion: "Moche, Trujillo, La Libertad",
                      descripcion: "Complejo de adobe moche. En la Huaca de la Luna hay murales con relieves de colores.",
                      datoCurioso: "Se construyó con millones de adobes y sus murales conservan mucho color.",
                      imagen: "moche_huaca_sol_luna"),
                Lugar(nombre: "Huaca Rajada - Sipán", tipo: "Tumbas reales",
                      ubicacion: "Zaña, Chiclayo, Lambayeque",
                      descripcion: "Pirámide de adobe donde se hallaron tumbas de gobernantes moche con joyas de oro y plata.",
                      datoCurioso: "Aquí se descubrió en 1987 la tumba del Señor de Sipán.",
                      imagen: "moche_sipan"),
                Lugar(nombre: "Complejo El Brujo", tipo: "Complejo arqueológico",
                      ubicacion: "Magdalena de Cao, Ascope, La Libertad",
                      descripcion: "Conjunto de huacas moche frente al mar, con templos y murales.",
                      datoCurioso: "Allí se encontró a la Señora de Cao, una gobernante moche con tatuajes en el cuerpo.",
                      imagen: "moche_el_brujo")
            ]
        }

        if clave.contains("inca") {
            return [
                Lugar(nombre: "Machu Picchu", tipo: "Ciudadela inca",
                      ubicacion: "Machu Picchu, Urubamba, Cusco",
                      descripcion: "Ciudadela en la cima de un cerro, con terrazas, templos y plazas.",
                      datoCurioso: "Es una de las 7 maravillas del mundo moderno desde 2007.",
                      imagen: "inca_machu_picchu"),
                Lugar(nombre: "Sacsayhuamán", tipo: "Fortaleza",
                      ubicacion: "Cusco",
                      descripcion: "Fortaleza con muros de piedras enormes encajadas sin mortero.",
                      datoCurioso: "Según la tradición, el Cusco tenía forma de puma y Sacsayhuamán era la cabeza.",
                      imagen: "inca_sacsayhuaman"),
                Lugar(nombre: "Ollantaytambo", tipo: "Centro inca",
                      ubicacion: "Valle Sagrado, Urubamba, Cusco",
                      descripcion: "Pueblo inca con terrazas, templos y calles originales todavía habitadas.",
                      datoCurioso: "En 1536 los incas resistieron aquí a los españoles.",
                      imagen: "inca_ollantaytambo")
            ]
        }

        return []
    }
}
