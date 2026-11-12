//
//  MisVentasViewController.swift
//  apple_lab11_03_UIKit_CoreData_Ventas
//
//  Pantalla A6: "Mis ventas" (solo para el Vendedor).
//  - Muestra SOLO las ventas del vendedor logueado (predicate "vendedor == %@")
//  - Indicadores de lo vendido HOY y en el MES (sin contar anuladas)
//  - Filtro con segmented: Todas / Hoy / Mes
//  - Búsqueda por nombre de cliente
//  - Las anuladas se ven tachadas y con etiqueta, SIN opción de anular
//

import UIKit
import CoreData

class MisVentasViewController: UIViewController,
                               UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    // MARK: - Componentes de la interfaz

    // Tarjetas con los indicadores de hoy y del mes
    private let etiquetaHoy = UILabel()
    private let etiquetaMes = UILabel()

    private let segmento: UISegmentedControl = {
        let segmento = UISegmentedControl(items: ["Todas", "Hoy", "Mes"])
        segmento.selectedSegmentIndex = 0
        return segmento
    }()

    private let buscador: UISearchBar = {
        let buscador = UISearchBar()
        buscador.placeholder = "Buscar por cliente"
        buscador.searchBarStyle = .minimal
        return buscador
    }()

    private let tabla = UITableView()

    // MARK: - Datos

    private var misVentas: [Venta] = []   // todas las ventas del vendedor
    private var filtradas: [Venta] = []   // resultado de aplicar segmento + búsqueda

    private let formateadorFecha: DateFormatter = {
        let formateador = DateFormatter()
        formateador.dateFormat = "dd/MM/yyyy HH:mm"
        return formateador
    }()

    // MARK: - Ciclo de vida

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mis Ventas"
        view.backgroundColor = .systemBackground

        configurarInterfaz()

        tabla.dataSource = self
        tabla.delegate = self
        buscador.delegate = self
        segmento.addTarget(self, action: #selector(aplicarFiltros), for: .valueChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Se recarga al entrar a la pestaña (por si se registró una venta nueva)
        cargarMisVentas()
    }

    // MARK: - Auto Layout por código

    private func configurarInterfaz() {
        // Las dos tarjetas de indicadores comparten estilo
        [etiquetaHoy, etiquetaMes].forEach { etiqueta in
            etiqueta.numberOfLines = 2
            etiqueta.textAlignment = .center
            etiqueta.font = .systemFont(ofSize: 15, weight: .semibold)
            etiqueta.layer.cornerRadius = 10
            etiqueta.clipsToBounds = true
        }
        // Tarjetas con color: verde para hoy, azul para el mes
        etiquetaHoy.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.15)
        etiquetaHoy.textColor = .systemGreen
        etiquetaMes.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        etiquetaMes.textColor = .systemBlue

        let pilaIndicadores = UIStackView(arrangedSubviews: [etiquetaHoy, etiquetaMes])
        pilaIndicadores.axis = .horizontal
        pilaIndicadores.distribution = .fillEqually // mitad y mitad
        pilaIndicadores.spacing = 12

        let pilaSuperior = UIStackView(arrangedSubviews: [pilaIndicadores, segmento, buscador])
        pilaSuperior.axis = .vertical
        pilaSuperior.spacing = 8
        pilaSuperior.translatesAutoresizingMaskIntoConstraints = false
        tabla.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pilaSuperior)
        view.addSubview(tabla)

        NSLayoutConstraint.activate([
            pilaSuperior.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            pilaSuperior.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            pilaSuperior.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            pilaIndicadores.heightAnchor.constraint(equalToConstant: 56),
            // La tabla ocupa el resto de la pantalla
            tabla.topAnchor.constraint(equalTo: pilaSuperior.bottomAnchor, constant: 4),
            tabla.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabla.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabla.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - Carga de datos (solo las ventas del vendedor logueado)

    private func cargarMisVentas() {
        guard let vendedor = Sesion.compartida.usuarioActual else { return }

        // Predicate por relación: solo las ventas cuyo vendedor es el usuario actual
        let solicitud: NSFetchRequest<Venta> = Venta.fetchRequest()
        solicitud.predicate = NSPredicate(format: "vendedor == %@", vendedor)
        solicitud.sortDescriptors = [NSSortDescriptor(key: "fecha", ascending: false)]

        misVentas = (try? CoreDataManager.shared.context.fetch(solicitud)) ?? []
        actualizarIndicadores()
        aplicarFiltros()
    }

    // Calcula los totales de HOY y del MES (las anuladas NO cuentan)
    private func actualizarIndicadores() {
        let calendario = Calendar.current
        let activas = misVentas.filter { !$0.anulada }

        let deHoy = activas.filter { venta in
            guard let fecha = venta.fecha else { return false }
            return calendario.isDateInToday(fecha)
        }
        let delMes = activas.filter { venta in
            guard let fecha = venta.fecha else { return false }
            return calendario.isDate(fecha, equalTo: Date(), toGranularity: .month)
        }

        let totalHoy = deHoy.reduce(0) { $0 + $1.total }
        let totalMes = delMes.reduce(0) { $0 + $1.total }
        etiquetaHoy.text = String(format: "Hoy\nS/ %.2f (%d)", totalHoy, deHoy.count)
        etiquetaMes.text = String(format: "Este mes\nS/ %.2f (%d)", totalMes, delMes.count)
    }

    // MARK: - Filtros (segmented + búsqueda por cliente)

    @objc private func aplicarFiltros() {
        let calendario = Calendar.current
        var resultado = misVentas

        // 1) Filtro por periodo según el segmento seleccionado
        switch segmento.selectedSegmentIndex {
        case 1: // Hoy
            resultado = resultado.filter { $0.fecha.map { calendario.isDateInToday($0) } ?? false }
        case 2: // Mes actual
            resultado = resultado.filter {
                $0.fecha.map { calendario.isDate($0, equalTo: Date(), toGranularity: .month) } ?? false
            }
        default: // Todas
            break
        }

        // 2) Filtro por texto: nombre del cliente (sin distinguir mayúsculas)
        let texto = (buscador.text ?? "").trimmingCharacters(in: .whitespaces)
        if !texto.isEmpty {
            resultado = resultado.filter {
                ($0.cliente?.nombre ?? "").localizedCaseInsensitiveContains(texto)
            }
        }

        filtradas = resultado
        tabla.reloadData()
    }

    // Cada vez que cambia el texto de búsqueda se vuelve a filtrar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        aplicarFiltros()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // cierra el teclado
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtradas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaMiVenta")
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: "celdaMiVenta")
        let venta = filtradas[indexPath.row]

        let titulo = String(format: "%@ x%d — S/ %.2f",
                            venta.producto?.nombre ?? "(producto)", venta.cantidad, venta.total)
        let fecha = venta.fecha.map { formateadorFecha.string(from: $0) } ?? "—"

        // Ícono según el estado de la venta
        celda.imageView?.image = UIImage(systemName: venta.anulada ? "xmark.circle.fill" : "cart.circle.fill")
        celda.imageView?.tintColor = venta.anulada ? .systemRed : .systemGreen

        if venta.anulada {
            // Venta anulada: texto TACHADO + etiqueta "ANULADA" en el detalle
            celda.textLabel?.attributedText = NSAttributedString(
                string: titulo,
                attributes: [
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .foregroundColor: UIColor.secondaryLabel
                ])
            celda.detailTextLabel?.text = "⛔️ ANULADA | \(fecha) | Cliente: \(venta.cliente?.nombre ?? "—")"
            celda.detailTextLabel?.textColor = .systemRed
        } else {
            // Importante: al reutilizar celdas hay que restablecer el estilo normal
            celda.textLabel?.attributedText = nil
            celda.textLabel?.text = titulo
            celda.textLabel?.textColor = .label
            celda.detailTextLabel?.text = "\(fecha) | Cliente: \(venta.cliente?.nombre ?? "—")"
            celda.detailTextLabel?.textColor = .secondaryLabel
        }
        // Sin opción de anular: la celda no es accionable
        celda.selectionStyle = .none
        return celda
    }
}
