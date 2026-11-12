//
//  ClientesViewController.swift
//  apple_lab11_03_UIKit_CoreData_Ventas
//
//  Pantalla A4: directorio de clientes con celda personalizada:
//  - Círculo con las INICIALES del cliente
//  - Nombre, documento y TOTAL COMPRADO (solo ventas NO anuladas)
//  - Categoría calculada: Regular < 1000 | Frecuente ≥ 1000 | VIP ≥ 5000
//  - "+" crea cliente, tocar una fila lo edita
//  - Solo el SUPERVISOR puede borrar; si tiene ventas, la regla Deny
//    lo impide y se muestra una alerta
//

import UIKit
import CoreData

// MARK: - Celda personalizada del cliente (hecha por código)

final class ClienteCelda: UITableViewCell {

    static let identificador = "ClienteCelda"

    // Círculo con las iniciales (ej. "María López" → "ML")
    private let avatar: UILabel = {
        let etiqueta = UILabel()
        etiqueta.font = .systemFont(ofSize: 17, weight: .bold)
        etiqueta.textColor = .white
        etiqueta.textAlignment = .center
        etiqueta.layer.cornerRadius = 23 // mitad de 46 = círculo
        etiqueta.clipsToBounds = true
        return etiqueta
    }()

    private let etiquetaNombre: UILabel = {
        let etiqueta = UILabel()
        etiqueta.font = .systemFont(ofSize: 17, weight: .semibold)
        return etiqueta
    }()

    private let etiquetaDetalle: UILabel = {
        let etiqueta = UILabel()
        etiqueta.font = .systemFont(ofSize: 13)
        etiqueta.textColor = .secondaryLabel
        etiqueta.numberOfLines = 2
        return etiqueta
    }()

    // Insignia de categoría (VIP / Frecuente / Regular)
    private let etiquetaCategoria: UILabel = {
        let etiqueta = UILabel()
        etiqueta.font = .systemFont(ofSize: 12, weight: .bold)
        etiqueta.textAlignment = .center
        etiqueta.layer.cornerRadius = 11
        etiqueta.clipsToBounds = true
        return etiqueta
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configurarVistas()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) no implementado: la interfaz es por código")
    }

    private func configurarVistas() {
        // Pila vertical con el nombre y el detalle
        let pilaTextos = UIStackView(arrangedSubviews: [etiquetaNombre, etiquetaDetalle])
        pilaTextos.axis = .vertical
        pilaTextos.spacing = 2

        [avatar, pilaTextos, etiquetaCategoria].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            // Avatar circular a la izquierda
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatar.widthAnchor.constraint(equalToConstant: 46),
            avatar.heightAnchor.constraint(equalToConstant: 46),

            // Textos al centro; top/bottom definen la ALTURA de la celda (self-sizing)
            pilaTextos.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 12),
            pilaTextos.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            pilaTextos.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            pilaTextos.trailingAnchor.constraint(lessThanOrEqualTo: etiquetaCategoria.leadingAnchor, constant: -8),

            // Insignia de categoría a la derecha
            etiquetaCategoria.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            etiquetaCategoria.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            etiquetaCategoria.widthAnchor.constraint(equalToConstant: 82),
            etiquetaCategoria.heightAnchor.constraint(equalToConstant: 22)
        ])
    }

    /// Llena la celda con los datos ya calculados por el controlador
    func configurar(cliente: Cliente, total: Double, categoria: String, color: UIColor) {
        avatar.text = ClienteCelda.iniciales(de: cliente.nombre ?? "?")
        avatar.backgroundColor = color
        etiquetaNombre.text = cliente.nombre
        etiquetaDetalle.text = String(
            format: "Doc: %@\nTotal comprado: S/ %.2f", cliente.documento ?? "—", total)
        etiquetaCategoria.text = categoria
        etiquetaCategoria.textColor = color
        etiquetaCategoria.backgroundColor = color.withAlphaComponent(0.15)
    }

    // "María López" → "ML" (primeras letras de las dos primeras palabras)
    private static func iniciales(de nombre: String) -> String {
        let letras = nombre.split(separator: " ").prefix(2).compactMap { $0.first }
        return letras.isEmpty ? "?" : String(letras).uppercased()
    }
}

// MARK: - Controlador

class ClientesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let tabla = UITableView()
    private var clientes: [Cliente] = []

    // Control por rol: solo el Supervisor puede borrar clientes
    private var esSupervisor: Bool {
        Sesion.compartida.usuarioActual?.rol == "Supervisor"
    }

    // MARK: - Ciclo de vida

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Clientes"
        view.backgroundColor = .systemBackground

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(agregarCliente))

        configurarTabla()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Se recarga al entrar (el total comprado cambia con cada venta)
        cargarClientes()
    }

    private func configurarTabla() {
        tabla.dataSource = self
        tabla.delegate = self
        // Registramos la celda personalizada y activamos el alto automático
        tabla.register(ClienteCelda.self, forCellReuseIdentifier: ClienteCelda.identificador)
        tabla.rowHeight = UITableView.automaticDimension
        tabla.estimatedRowHeight = 70
        tabla.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabla)

        NSLayoutConstraint.activate([
            tabla.topAnchor.constraint(equalTo: view.topAnchor),
            tabla.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabla.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabla.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - LEER

    private func cargarClientes() {
        let solicitud: NSFetchRequest<Cliente> = Cliente.fetchRequest()
        solicitud.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        clientes = (try? CoreDataManager.shared.context.fetch(solicitud)) ?? []
        tabla.reloadData()
        actualizarEstadoVacio()
    }

    // MARK: - Reglas de negocio: total comprado y categoría

    /// Suma el historial del cliente SIN contar las ventas anuladas
    private func totalComprado(de cliente: Cliente) -> Double {
        let ventasCliente = (cliente.ventas as? Set<Venta>) ?? []
        return ventasCliente.filter { !$0.anulada }.reduce(0) { $0 + $1.total }
    }

    /// Regular < 1000 | Frecuente ≥ 1000 | VIP ≥ 5000 (cada una con su color)
    private func categoria(paraTotal total: Double) -> (nombre: String, color: UIColor) {
        if total >= 5000 { return ("VIP", .systemPurple) }
        if total >= 1000 { return ("Frecuente", .systemBlue) }
        return ("Regular", .systemGray)
    }

    // MARK: - CREAR / ACTUALIZAR (formulario en alerta)

    @objc private func agregarCliente() {
        mostrarFormulario(cliente: nil) // nil = modo "crear"
    }

    private func mostrarFormulario(cliente: Cliente?) {
        let esNuevo = (cliente == nil)
        let alerta = UIAlertController(
            title: esNuevo ? "Nuevo Cliente" : "Editar Cliente",
            message: nil, preferredStyle: .alert)

        alerta.addTextField { campo in
            campo.placeholder = "Nombre completo"
            campo.text = cliente?.nombre
        }
        alerta.addTextField { campo in
            campo.placeholder = "Documento (DNI/RUC)"
            campo.keyboardType = .numberPad
            campo.text = cliente?.documento
        }

        alerta.addAction(UIAlertAction(title: "Guardar", style: .default) { [weak self] _ in
            guard let self else { return }
            let nombre = alerta.textFields?[0].text ?? ""
            let documento = alerta.textFields?[1].text ?? ""

            guard !nombre.isEmpty, !documento.isEmpty else {
                self.mostrarAlerta(mensaje: "El nombre y el documento son obligatorios.")
                return
            }

            let objetivo = cliente ?? Cliente(context: CoreDataManager.shared.context)
            objetivo.nombre = nombre
            objetivo.documento = documento

            CoreDataManager.shared.guardar()
            self.cargarClientes()
        })
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alerta, animated: true)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(
            withIdentifier: ClienteCelda.identificador, for: indexPath) as! ClienteCelda
        let cliente = clientes[indexPath.row]

        // El controlador calcula los datos; la celda solo los muestra
        let total = totalComprado(de: cliente)
        let infoCategoria = categoria(paraTotal: total)
        celda.configurar(cliente: cliente, total: total,
                         categoria: infoCategoria.nombre, color: infoCategoria.color)
        return celda
    }

    // MARK: - UITableViewDelegate

    // Tocar una fila abre el formulario en modo edición
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        mostrarFormulario(cliente: clientes[indexPath.row])
    }

    // El deslizar-para-borrar SOLO existe para el Supervisor
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return esSupervisor
    }

    // MARK: - ELIMINAR (protegido por la regla Deny)

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        let cliente = clientes[indexPath.row]
        CoreDataManager.shared.context.delete(cliente)

        // Si el cliente tiene ventas, la regla Deny hace fallar el save()
        if CoreDataManager.shared.guardar() {
            clientes.remove(at: indexPath.row)
            tabla.deleteRows(at: [indexPath], with: .automatic)
            actualizarEstadoVacio()
        } else {
            mostrarAlerta(mensaje: "No se puede eliminar a \"\(cliente.nombre ?? "")\": tiene ventas registradas (regla Deny).")
        }
    }

    // MARK: - Utilitarios

    private func actualizarEstadoVacio() {
        if clientes.isEmpty {
            let etiqueta = UILabel()
            etiqueta.text = "👥\n\nNo hay clientes.\nToca + para agregar uno."
            etiqueta.numberOfLines = 0
            etiqueta.textAlignment = .center
            etiqueta.textColor = .secondaryLabel
            etiqueta.font = .systemFont(ofSize: 17)
            tabla.backgroundView = etiqueta
        } else {
            tabla.backgroundView = nil
        }
    }

    private func mostrarAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Atención", message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        present(alerta, animated: true)
    }
}
