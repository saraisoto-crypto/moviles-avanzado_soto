//
//  VentasViewController.swift
//  apple_lab11_03_UIKit_CoreData_Ventas
//
//  Pantallas A7/A8: todas las ventas del sistema (pestaña del Supervisor).
//  - Cada fila muestra el nombre del VENDEDOR
//  - "Chips" (botones) arriba para filtrar por vendedor
//  - Deslizar una fila muestra "Anular" (solo Supervisor):
//      alerta con el resumen de la venta, aviso de devolución de stock
//      y motivo OBLIGATORIO (el botón se habilita solo si hay texto)
//  - Al anular: anulada = true, se guarda el motivo y se DEVUELVE el stock
//

import UIKit
import CoreData

class VentasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Componentes de la interfaz

    // Scroll horizontal con los chips de filtro por vendedor
    private let scrollChips = UIScrollView()
    private let pilaChips = UIStackView()
    private let tabla = UITableView()

    // MARK: - Datos

    private var ventas: [Venta] = []        // todas las ventas
    private var filtradas: [Venta] = []     // ventas visibles según el chip activo
    private var vendedores: [Usuario] = []  // vendedores que tienen ventas (para los chips)
    private var filtroVendedor: Usuario?    // nil = chip "Todos"

    // Referencia a la acción "Confirmar" de la alerta de anulación,
    // para habilitarla/deshabilitarla según el campo de motivo
    private var accionConfirmarAnulacion: UIAlertAction?

    private let formateadorFecha: DateFormatter = {
        let formateador = DateFormatter()
        formateador.dateFormat = "dd/MM/yyyy HH:mm"
        return formateador
    }()

    // MARK: - Ciclo de vida

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ventas"
        view.backgroundColor = .systemBackground
        configurarInterfaz()
        tabla.dataSource = self
        tabla.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cargarVentas() // datos frescos cada vez que se entra a la pestaña
    }

    // MARK: - Auto Layout por código

    private func configurarInterfaz() {
        scrollChips.showsHorizontalScrollIndicator = false
        pilaChips.axis = .horizontal
        pilaChips.spacing = 8

        scrollChips.translatesAutoresizingMaskIntoConstraints = false
        pilaChips.translatesAutoresizingMaskIntoConstraints = false
        tabla.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollChips)
        scrollChips.addSubview(pilaChips)
        view.addSubview(tabla)

        NSLayoutConstraint.activate([
            // Franja de chips arriba, desplazable horizontalmente
            scrollChips.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            scrollChips.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollChips.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollChips.heightAnchor.constraint(equalToConstant: 40),
            pilaChips.topAnchor.constraint(equalTo: scrollChips.contentLayoutGuide.topAnchor),
            pilaChips.bottomAnchor.constraint(equalTo: scrollChips.contentLayoutGuide.bottomAnchor),
            pilaChips.leadingAnchor.constraint(equalTo: scrollChips.contentLayoutGuide.leadingAnchor, constant: 16),
            pilaChips.trailingAnchor.constraint(equalTo: scrollChips.contentLayoutGuide.trailingAnchor, constant: -16),
            pilaChips.heightAnchor.constraint(equalTo: scrollChips.frameLayoutGuide.heightAnchor),
            // La tabla ocupa el resto
            tabla.topAnchor.constraint(equalTo: scrollChips.bottomAnchor, constant: 4),
            tabla.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabla.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabla.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - Carga de datos

    private func cargarVentas() {
        let solicitud: NSFetchRequest<Venta> = Venta.fetchRequest()
        solicitud.sortDescriptors = [NSSortDescriptor(key: "fecha", ascending: false)]
        ventas = (try? CoreDataManager.shared.context.fetch(solicitud)) ?? []

        // Vendedores ÚNICOS que tienen ventas (para armar los chips)
        var vistos = Set<Usuario>()
        vendedores = ventas
            .compactMap { $0.vendedor }
            .filter { vistos.insert($0).inserted } // descarta repetidos conservando orden
            .sorted { ($0.nombre ?? "") < ($1.nombre ?? "") }

        // Si el vendedor filtrado ya no tiene ventas, volvemos a "Todos"
        if let filtro = filtroVendedor, !vendedores.contains(filtro) {
            filtroVendedor = nil
        }

        reconstruirChips()
        aplicarFiltro()
    }

    // MARK: - Chips de filtro por vendedor

    private func reconstruirChips() {
        // Se eliminan los chips anteriores y se vuelven a crear
        pilaChips.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // Chip "Todos" (tag 0) + un chip por vendedor (tag = índice + 1)
        pilaChips.addArrangedSubview(crearChip(titulo: "Todos", tag: 0, activo: filtroVendedor == nil))
        for (indice, vendedor) in vendedores.enumerated() {
            pilaChips.addArrangedSubview(crearChip(
                titulo: vendedor.nombre ?? "—",
                tag: indice + 1,
                activo: filtroVendedor == vendedor))
        }
    }

    private func crearChip(titulo: String, tag: Int, activo: Bool) -> UIButton {
        // El chip activo se pinta relleno; los demás en gris
        var configuracion = activo ? UIButton.Configuration.filled() : UIButton.Configuration.gray()
        configuracion.title = titulo
        configuracion.cornerStyle = .capsule
        configuracion.buttonSize = .small
        let boton = UIButton(configuration: configuracion)
        boton.tag = tag
        boton.addTarget(self, action: #selector(chipTocado(_:)), for: .touchUpInside)
        return boton
    }

    @objc private func chipTocado(_ boton: UIButton) {
        // tag 0 = "Todos"; tag n = vendedores[n - 1]
        filtroVendedor = boton.tag == 0 ? nil : vendedores[boton.tag - 1]
        reconstruirChips() // repinta los chips con la nueva selección
        aplicarFiltro()
    }

    private func aplicarFiltro() {
        if let vendedor = filtroVendedor {
            filtradas = ventas.filter { $0.vendedor == vendedor }
        } else {
            filtradas = ventas
        }
        tabla.reloadData()
        title = "Ventas (\(filtradas.count))"
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtradas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaVenta")
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: "celdaVenta")
        let venta = filtradas[indexPath.row]

        let titulo = String(format: "%@ x%d — S/ %.2f",
                            venta.producto?.nombre ?? "(producto)", venta.cantidad, venta.total)
        let fecha = venta.fecha.map { formateadorFecha.string(from: $0) } ?? "—"
        // El subtítulo siempre muestra el NOMBRE DEL VENDEDOR
        let subtitulo = "\(fecha) | Vendedor: \(venta.vendedor?.nombre ?? "—") | Cliente: \(venta.cliente?.nombre ?? "—")"

        if venta.anulada {
            // Anulada: título tachado y etiqueta en rojo
            celda.textLabel?.attributedText = NSAttributedString(
                string: titulo,
                attributes: [
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .foregroundColor: UIColor.secondaryLabel
                ])
            celda.detailTextLabel?.text = "⛔️ ANULADA | " + subtitulo
            celda.detailTextLabel?.textColor = .systemRed
        } else {
            // Restablecemos el estilo normal (las celdas se reutilizan)
            celda.textLabel?.attributedText = nil
            celda.textLabel?.text = titulo
            celda.textLabel?.textColor = .label
            celda.detailTextLabel?.text = subtitulo
            celda.detailTextLabel?.textColor = .secondaryLabel
        }
        return celda
    }

    // MARK: - Detalle al tocar una fila

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let venta = filtradas[indexPath.row]

        var detalle = String(
            format: """
            Fecha: %@
            Producto: %@
            Cliente: %@
            Vendedor: %@
            Cantidad: %d
            Precio unitario: S/ %.2f
            Descuento: S/ %.2f
            IGV: S/ %.2f
            TOTAL: S/ %.2f
            """,
            venta.fecha.map { formateadorFecha.string(from: $0) } ?? "—",
            venta.producto?.nombre ?? "—",
            venta.cliente?.nombre ?? "—",
            venta.vendedor?.nombre ?? "—",
            venta.cantidad, venta.precioUnitario,
            venta.descuento, venta.igv, venta.total)

        if venta.anulada {
            detalle += "\n\n⛔️ ANULADA\nMotivo: \(venta.motivoAnulacion ?? "—")"
        }

        let alerta = UIAlertController(title: "Detalle de Venta", message: detalle, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Cerrar", style: .cancel))
        present(alerta, animated: true)
    }

    // MARK: - Anular deslizando (solo Supervisor)

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let venta = filtradas[indexPath.row]

        // La acción "Anular" solo existe para el Supervisor y si no está anulada
        guard Sesion.compartida.usuarioActual?.rol == "Supervisor", !venta.anulada else {
            return nil
        }

        let accion = UIContextualAction(style: .destructive, title: "Anular") { [weak self] _, _, completado in
            self?.mostrarAlertaAnulacion(venta: venta)
            completado(true)
        }
        accion.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [accion])
    }

    /// Alerta de confirmación: resumen de la venta + aviso de devolución de
    /// stock + campo de motivo OBLIGATORIO (Confirmar deshabilitado si está vacío)
    private func mostrarAlertaAnulacion(venta: Venta) {
        let resumen = String(
            format: """
            Producto: %@
            Cantidad: %d
            Cliente: %@
            Total: S/ %.2f

            Se devolverán %d unidades al stock de "%@".

            Escribe el motivo para confirmar:
            """,
            venta.producto?.nombre ?? "—", venta.cantidad,
            venta.cliente?.nombre ?? "—", venta.total,
            venta.cantidad, venta.producto?.nombre ?? "—")

        let alerta = UIAlertController(title: "Anular Venta", message: resumen, preferredStyle: .alert)
        alerta.addTextField { [weak self] campo in
            campo.placeholder = "Motivo de anulación (obligatorio)"
            // Cada vez que cambia el texto se revisa si se habilita Confirmar
            campo.addTarget(self, action: #selector(self?.motivoCambiado(_:)), for: .editingChanged)
        }

        let confirmar = UIAlertAction(title: "Confirmar anulación", style: .destructive) { [weak self] _ in
            let motivo = (alerta.textFields?.first?.text ?? "").trimmingCharacters(in: .whitespaces)
            self?.anular(venta: venta, motivo: motivo)
        }
        confirmar.isEnabled = false // deshabilitado hasta que haya motivo
        accionConfirmarAnulacion = confirmar

        alerta.addAction(confirmar)
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alerta, animated: true)
    }

    // Habilita "Confirmar" solo cuando el motivo tiene texto
    @objc private func motivoCambiado(_ campo: UITextField) {
        let texto = (campo.text ?? "").trimmingCharacters(in: .whitespaces)
        accionConfirmarAnulacion?.isEnabled = !texto.isEmpty
    }

    /// Anula la venta: NO se elimina (queda en el historial),
    /// se marca anulada = true, se guarda el motivo y se DEVUELVE el stock.
    private func anular(venta: Venta, motivo: String) {
        venta.anulada = true
        venta.motivoAnulacion = motivo
        venta.producto?.stock += venta.cantidad // devolución del stock

        if CoreDataManager.shared.guardar() {
            cargarVentas() // refresca tabla e indicador del título
        } else {
            let alerta = UIAlertController(title: "Atención", message: "No se pudo anular la venta.", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default))
            present(alerta, animated: true)
        }
    }
}
