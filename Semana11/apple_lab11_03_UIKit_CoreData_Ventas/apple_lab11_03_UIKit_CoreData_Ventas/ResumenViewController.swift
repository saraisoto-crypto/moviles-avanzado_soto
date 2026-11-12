//
//  ResumenViewController.swift
//  apple_lab11_03_UIKit_CoreData_Ventas
//
//  Pantalla A9: Resumen gerencial (primera pestaña del Supervisor).
//  - Saludo con nombre y rol del usuario logueado
//  - Indicadores: ventas de HOY comparadas con el DÍA ANTERIOR
//  - Gráfico de barras de los últimos 7 días (dibujado con UIView, sin librerías)
//  - Ranking de vendedores del mes actual
//  - Alerta de productos con stock bajo (≤ 5)
//  REGLA: las ventas ANULADAS no cuentan en ningún indicador.
//

import UIKit
import CoreData

class ResumenViewController: UIViewController {

    // Scroll + pila vertical: el contenido puede ser más alto que la pantalla
    private let scroll = UIScrollView()
    private let pila = UIStackView()

    // MARK: - Ciclo de vida

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Resumen"
        view.backgroundColor = .systemBackground
        configurarLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // El resumen se reconstruye cada vez que se entra a la pestaña,
        // así siempre refleja las ventas y stocks actuales
        construirResumen()
    }

    // MARK: - Layout base (scroll con pila vertical)

    private func configurarLayout() {
        scroll.translatesAutoresizingMaskIntoConstraints = false
        pila.translatesAutoresizingMaskIntoConstraints = false
        pila.axis = .vertical
        pila.spacing = 18
        view.addSubview(scroll)
        scroll.addSubview(pila)

        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // La pila define el contenido desplazable del scroll
            pila.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor, constant: 16),
            pila.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor, constant: -24),
            pila.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor, constant: 20),
            pila.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor, constant: -20),
            // El ancho del contenido es el de la pantalla (solo scroll vertical)
            pila.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor, constant: -40)
        ])
    }

    // MARK: - Construcción del resumen con los datos de Core Data

    private func construirResumen() {
        // Limpiamos la pila para reconstruirla con datos frescos
        pila.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // ---- Datos base: todas las ventas NO anuladas ----
        let solicitud: NSFetchRequest<Venta> = Venta.fetchRequest()
        let todas = (try? CoreDataManager.shared.context.fetch(solicitud)) ?? []
        let activas = todas.filter { !$0.anulada } // las anuladas NO cuentan
        let calendario = Calendar.current

        // ---- 1) Saludo con nombre y rol ----
        let usuario = Sesion.compartida.usuarioActual
        let saludo = UILabel()
        saludo.text = "Hola, \(usuario?.nombre ?? "") 👋"
        saludo.font = .systemFont(ofSize: 26, weight: .bold)
        let rol = UILabel()
        rol.text = "Rol: \(usuario?.rol ?? "")"
        rol.font = .systemFont(ofSize: 15)
        rol.textColor = .secondaryLabel
        pila.addArrangedSubview(saludo)
        pila.addArrangedSubview(rol)

        // ---- 2) Indicadores: hoy vs día anterior ----
        let deHoy = activas.filter { $0.fecha.map { calendario.isDateInToday($0) } ?? false }
        let deAyer = activas.filter { $0.fecha.map { calendario.isDateInYesterday($0) } ?? false }
        let totalHoy = deHoy.reduce(0) { $0 + $1.total }
        let totalAyer = deAyer.reduce(0) { $0 + $1.total }

        let tarjetaHoy = crearTarjeta(texto: String(format: "Hoy\nS/ %.2f (%d ventas)", totalHoy, deHoy.count))
        let tarjetaAyer = crearTarjeta(texto: String(format: "Ayer\nS/ %.2f (%d ventas)", totalAyer, deAyer.count))
        let pilaTarjetas = UIStackView(arrangedSubviews: [tarjetaHoy, tarjetaAyer])
        pilaTarjetas.axis = .horizontal
        pilaTarjetas.distribution = .fillEqually
        pilaTarjetas.spacing = 12
        pilaTarjetas.heightAnchor.constraint(equalToConstant: 64).isActive = true
        pila.addArrangedSubview(pilaTarjetas)

        // Comparación con el día anterior (sube ▲, baja ▼ o igual =)
        let diferencia = totalHoy - totalAyer
        let comparacion = UILabel()
        comparacion.font = .systemFont(ofSize: 14, weight: .semibold)
        if diferencia > 0 {
            comparacion.text = String(format: "▲ S/ %.2f más que ayer", diferencia)
            comparacion.textColor = .systemGreen
        } else if diferencia < 0 {
            comparacion.text = String(format: "▼ S/ %.2f menos que ayer", abs(diferencia))
            comparacion.textColor = .systemRed
        } else {
            comparacion.text = "= Igual que ayer"
            comparacion.textColor = .secondaryLabel
        }
        pila.addArrangedSubview(comparacion)

        // ---- 3) Gráfico de barras: últimos 7 días ----
        pila.addArrangedSubview(crearTituloSeccion("Últimos 7 días"))

        // Calculamos el total vendido en cada uno de los últimos 7 días
        let formateadorDia = DateFormatter()
        formateadorDia.locale = Locale(identifier: "es_PE")
        formateadorDia.dateFormat = "EEE" // nombre corto del día (lun, mar...)

        var valores: [(dia: String, total: Double)] = []
        for desplazamiento in (0..<7).reversed() { // del más antiguo a hoy
            guard let dia = calendario.date(byAdding: .day, value: -desplazamiento, to: Date()) else { continue }
            let totalDia = activas
                .filter { $0.fecha.map { calendario.isDate($0, inSameDayAs: dia) } ?? false }
                .reduce(0) { $0 + $1.total }
            valores.append((formateadorDia.string(from: dia), totalDia))
        }
        pila.addArrangedSubview(crearGrafico(valores: valores))

        // ---- 4) Ranking de vendedores del mes ----
        pila.addArrangedSubview(crearTituloSeccion("Ranking de vendedores (mes)"))

        // Agrupamos los totales del mes actual por vendedor
        var totalesPorVendedor: [Usuario: Double] = [:]
        for venta in activas {
            guard let fecha = venta.fecha,
                  calendario.isDate(fecha, equalTo: Date(), toGranularity: .month),
                  let vendedor = venta.vendedor else { continue }
            totalesPorVendedor[vendedor, default: 0] += venta.total
        }
        let ranking = totalesPorVendedor.sorted { $0.value > $1.value } // mayor a menor

        if ranking.isEmpty {
            pila.addArrangedSubview(crearTextoSecundario("Aún no hay ventas este mes."))
        } else {
            let medallas = ["🥇", "🥈", "🥉"]
            for (indice, elemento) in ranking.enumerated() {
                let posicion = indice < medallas.count ? medallas[indice] : "\(indice + 1)."
                let fila = UILabel()
                fila.text = String(format: "%@ %@ — S/ %.2f",
                                   posicion, elemento.key.nombre ?? "—", elemento.value)
                fila.font = .systemFont(ofSize: 16)
                pila.addArrangedSubview(fila)
            }
        }

        // ---- 5) Productos con stock bajo (≤ 5) ----
        pila.addArrangedSubview(crearTituloSeccion("Stock bajo (≤ 5)"))

        let solicitudProductos: NSFetchRequest<Producto> = Producto.fetchRequest()
        solicitudProductos.predicate = NSPredicate(format: "stock <= 5")
        solicitudProductos.sortDescriptors = [NSSortDescriptor(key: "stock", ascending: true)]
        let productosBajos = (try? CoreDataManager.shared.context.fetch(solicitudProductos)) ?? []

        if productosBajos.isEmpty {
            pila.addArrangedSubview(crearTextoSecundario("Todo en orden: ningún producto con stock bajo."))
        } else {
            for producto in productosBajos {
                let fila = UILabel()
                fila.text = "⚠️ \(producto.nombre ?? "—") — quedan \(producto.stock)"
                fila.font = .systemFont(ofSize: 16)
                fila.textColor = .systemOrange
                pila.addArrangedSubview(fila)
            }
        }
    }

    // MARK: - Gráfico de barras hecho SOLO con UIView y Auto Layout

    private func crearGrafico(valores: [(dia: String, total: Double)]) -> UIView {
        let alturaMaxima: CGFloat = 120 // alto de la barra más grande
        // Evitamos dividir entre cero cuando no hay ventas
        let maximo = max(valores.map { $0.total }.max() ?? 0, 0.01)

        let pilaColumnas = UIStackView()
        pilaColumnas.axis = .horizontal
        pilaColumnas.distribution = .fillEqually // 7 columnas del mismo ancho
        pilaColumnas.spacing = 6

        for valor in valores {
            // La barra: un UIView azul cuya ALTURA es proporcional al total del día
            let barra = UIView()
            barra.backgroundColor = valor.total > 0 ? .systemBlue : .systemGray4
            barra.layer.cornerRadius = 4
            let altura = valor.total > 0
                ? max(alturaMaxima * CGFloat(valor.total / maximo), 6) // mínimo visible
                : 2
            barra.heightAnchor.constraint(equalToConstant: altura).isActive = true

            // Etiqueta con el día debajo de la barra
            let etiquetaDia = UILabel()
            etiquetaDia.text = valor.dia
            etiquetaDia.font = .systemFont(ofSize: 11)
            etiquetaDia.textAlignment = .center
            etiquetaDia.textColor = .secondaryLabel

            // El espaciador empuja la barra hacia abajo (las barras "crecen" desde la base)
            let espaciador = UIView()
            let columna = UIStackView(arrangedSubviews: [espaciador, barra, etiquetaDia])
            columna.axis = .vertical
            columna.spacing = 4
            pilaColumnas.addArrangedSubview(columna)
        }

        pilaColumnas.heightAnchor.constraint(equalToConstant: alturaMaxima + 24).isActive = true
        return pilaColumnas
    }

    // MARK: - Pequeñas fábricas de vistas reutilizables

    private func crearTarjeta(texto: String) -> UILabel {
        let etiqueta = UILabel()
        etiqueta.text = texto
        etiqueta.numberOfLines = 2
        etiqueta.textAlignment = .center
        etiqueta.font = .systemFont(ofSize: 15, weight: .semibold)
        etiqueta.backgroundColor = .secondarySystemBackground
        etiqueta.layer.cornerRadius = 10
        etiqueta.clipsToBounds = true
        return etiqueta
    }

    private func crearTituloSeccion(_ texto: String) -> UILabel {
        let etiqueta = UILabel()
        etiqueta.text = texto
        etiqueta.font = .systemFont(ofSize: 19, weight: .bold)
        return etiqueta
    }

    private func crearTextoSecundario(_ texto: String) -> UILabel {
        let etiqueta = UILabel()
        etiqueta.text = texto
        etiqueta.font = .systemFont(ofSize: 15)
        etiqueta.textColor = .secondaryLabel
        return etiqueta
    }
}
