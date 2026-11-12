//
//  CuentaViewController.swift
//  apple_lab11_03_UIKit_CoreData_Ventas
//
//  Pestaña "Cuenta": perfil del usuario logueado.
//  - Avatar circular con las INICIALES del nombre
//  - Insignia de rol con color (Supervisor morado, Vendedor azul)
//  - Tarjeta de información: usuario, rol y clave con botón 👁 para verla
//  - Estadísticas personales desde Core Data (sin contar anuladas)
//  - Botón de cerrar sesión (limpia Sesion y vuelve al login)
//

import UIKit
import CoreData

class CuentaViewController: UIViewController {

    // Scroll + pila: el perfil se reconstruye al entrar para tener datos frescos
    private let scroll = UIScrollView()
    private let pila = UIStackView()

    // Referencias para el mostrar/ocultar de la clave en la tarjeta
    private let etiquetaClave = UILabel()
    private var claveVisible = false

    // MARK: - Ciclo de vida

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mi Cuenta"
        view.backgroundColor = .systemBackground
        configurarLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        claveVisible = false // por seguridad, la clave siempre vuelve a ocultarse
        construirPerfil()
    }

    // MARK: - Layout base

    private func configurarLayout() {
        scroll.translatesAutoresizingMaskIntoConstraints = false
        pila.translatesAutoresizingMaskIntoConstraints = false
        pila.axis = .vertical
        pila.spacing = 16
        pila.alignment = .fill
        view.addSubview(scroll)
        scroll.addSubview(pila)

        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pila.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor, constant: 24),
            pila.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor, constant: -24),
            pila.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor, constant: 20),
            pila.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor, constant: -20),
            pila.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor, constant: -40)
        ])
    }

    // MARK: - Construcción del perfil

    private func construirPerfil() {
        pila.arrangedSubviews.forEach { $0.removeFromSuperview() }
        guard let usuario = Sesion.compartida.usuarioActual else { return }
        let esSupervisor = (usuario.rol == "Supervisor")

        // ---- 1) Avatar circular con iniciales ----
        let avatar = crearAvatar(nombre: usuario.nombre ?? "?", esSupervisor: esSupervisor)
        // Contenedor para centrar el avatar dentro de la pila
        let contenedorAvatar = UIStackView(arrangedSubviews: [avatar])
        contenedorAvatar.axis = .vertical
        contenedorAvatar.alignment = .center
        pila.addArrangedSubview(contenedorAvatar)

        // ---- 2) Nombre y usuario ----
        let etiquetaNombre = UILabel()
        etiquetaNombre.text = usuario.nombre
        etiquetaNombre.font = .systemFont(ofSize: 26, weight: .bold)
        etiquetaNombre.textAlignment = .center
        pila.addArrangedSubview(etiquetaNombre)

        let etiquetaUsuario = UILabel()
        etiquetaUsuario.text = "@\(usuario.usuario ?? "—")"
        etiquetaUsuario.font = .systemFont(ofSize: 16)
        etiquetaUsuario.textColor = .secondaryLabel
        etiquetaUsuario.textAlignment = .center
        pila.addArrangedSubview(etiquetaUsuario)

        // ---- 3) Insignia del rol (cápsula con color) ----
        var configuracionInsignia = UIButton.Configuration.filled()
        configuracionInsignia.title = esSupervisor ? "⭐️ Supervisor" : "🛒 Vendedor"
        configuracionInsignia.cornerStyle = .capsule
        configuracionInsignia.buttonSize = .small
        configuracionInsignia.baseBackgroundColor = esSupervisor ? .systemPurple : .systemBlue
        let insignia = UIButton(configuration: configuracionInsignia)
        insignia.isUserInteractionEnabled = false // es decorativa, no es un botón real
        let contenedorInsignia = UIStackView(arrangedSubviews: [insignia])
        contenedorInsignia.axis = .vertical
        contenedorInsignia.alignment = .center
        pila.addArrangedSubview(contenedorInsignia)

        // ---- 4) Tarjeta de información de la cuenta ----
        let tarjeta = crearTarjetaInformacion(usuario: usuario)
        pila.addArrangedSubview(tarjeta)

        // ---- 5) Estadísticas personales desde Core Data ----
        pila.addArrangedSubview(crearEstadisticas(usuario: usuario, esSupervisor: esSupervisor))

        // ---- 6) Botón de cerrar sesión ----
        var configuracionCerrar = UIButton.Configuration.filled()
        configuracionCerrar.title = "Cerrar sesión"
        configuracionCerrar.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        configuracionCerrar.imagePadding = 8
        configuracionCerrar.baseBackgroundColor = .systemRed
        configuracionCerrar.cornerStyle = .medium
        let botonCerrar = UIButton(configuration: configuracionCerrar)
        botonCerrar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        botonCerrar.addTarget(self, action: #selector(cerrarSesion), for: .touchUpInside)
        pila.setCustomSpacing(28, after: pila.arrangedSubviews.last!)
        pila.addArrangedSubview(botonCerrar)
    }

    // Avatar: círculo de color con las iniciales del nombre (ej. "Juan Pérez" → "JP")
    private func crearAvatar(nombre: String, esSupervisor: Bool) -> UIView {
        let iniciales = nombre
            .split(separator: " ")
            .prefix(2)                       // primeras dos palabras
            .compactMap { $0.first }         // primera letra de cada una
            .map(String.init)
            .joined()
            .uppercased()

        let etiqueta = UILabel()
        etiqueta.text = iniciales.isEmpty ? "?" : iniciales
        etiqueta.font = .systemFont(ofSize: 38, weight: .bold)
        etiqueta.textColor = .white
        etiqueta.textAlignment = .center
        etiqueta.backgroundColor = esSupervisor ? .systemPurple : .systemBlue
        etiqueta.layer.cornerRadius = 50     // la mitad del ancho = círculo perfecto
        etiqueta.clipsToBounds = true
        NSLayoutConstraint.activate([
            etiqueta.widthAnchor.constraint(equalToConstant: 100),
            etiqueta.heightAnchor.constraint(equalToConstant: 100)
        ])
        return etiqueta
    }

    // Tarjeta gris con filas: usuario, rol y clave (con botón 👁)
    private func crearTarjetaInformacion(usuario: Usuario) -> UIView {
        let tarjeta = UIStackView()
        tarjeta.axis = .vertical
        tarjeta.spacing = 14
        tarjeta.backgroundColor = .secondarySystemBackground
        tarjeta.layer.cornerRadius = 12
        // Margen interno de la tarjeta
        tarjeta.isLayoutMarginsRelativeArrangement = true
        tarjeta.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        tarjeta.addArrangedSubview(crearFila(icono: "person.fill", titulo: "Usuario",
                                             valor: usuario.usuario ?? "—"))
        tarjeta.addArrangedSubview(crearFila(icono: "briefcase.fill", titulo: "Rol",
                                             valor: usuario.rol ?? "—"))

        // Fila especial de la clave: inicia oculta (puntos) con botón de ojo
        etiquetaClave.text = String(repeating: "•", count: usuario.clave?.count ?? 6)
        etiquetaClave.font = .systemFont(ofSize: 16, weight: .medium)
        etiquetaClave.textAlignment = .right

        let botonOjo = UIButton(type: .system)
        botonOjo.setImage(UIImage(systemName: "eye"), for: .normal)
        botonOjo.tintColor = .secondaryLabel
        botonOjo.addAction(UIAction { [weak self, weak botonOjo] _ in
            guard let self else { return }
            // Alterna entre los puntos y la clave real
            self.claveVisible.toggle()
            let clave = Sesion.compartida.usuarioActual?.clave ?? ""
            self.etiquetaClave.text = self.claveVisible
                ? clave
                : String(repeating: "•", count: clave.count)
            botonOjo?.setImage(UIImage(systemName: self.claveVisible ? "eye.slash" : "eye"), for: .normal)
        }, for: .touchUpInside)

        let filaClave = crearFila(icono: "lock.fill", titulo: "Clave", valor: nil)
        filaClave.addArrangedSubview(etiquetaClave)
        filaClave.addArrangedSubview(botonOjo)
        tarjeta.addArrangedSubview(filaClave)

        return tarjeta
    }

    // Fila de la tarjeta: ícono + título a la izquierda, valor a la derecha
    private func crearFila(icono: String, titulo: String, valor: String?) -> UIStackView {
        let imagen = UIImageView(image: UIImage(systemName: icono))
        imagen.tintColor = .systemBlue
        imagen.contentMode = .scaleAspectFit
        imagen.widthAnchor.constraint(equalToConstant: 24).isActive = true

        let etiquetaTitulo = UILabel()
        etiquetaTitulo.text = titulo
        etiquetaTitulo.font = .systemFont(ofSize: 16)
        etiquetaTitulo.textColor = .secondaryLabel

        let fila = UIStackView(arrangedSubviews: [imagen, etiquetaTitulo])
        fila.axis = .horizontal
        fila.spacing = 10

        // Si hay valor fijo se agrega a la derecha (la fila de clave agrega el suyo)
        if let valor {
            let etiquetaValor = UILabel()
            etiquetaValor.text = valor
            etiquetaValor.font = .systemFont(ofSize: 16, weight: .medium)
            etiquetaValor.textAlignment = .right
            fila.addArrangedSubview(etiquetaValor)
        }
        return fila
    }

    // Estadísticas desde Core Data: el vendedor ve SUS ventas,
    // el supervisor ve las del sistema (las anuladas no cuentan)
    private func crearEstadisticas(usuario: Usuario, esSupervisor: Bool) -> UIView {
        let solicitud: NSFetchRequest<Venta> = Venta.fetchRequest()
        if !esSupervisor {
            // Solo las ventas de este vendedor
            solicitud.predicate = NSPredicate(format: "vendedor == %@", usuario)
        }
        let ventas = ((try? CoreDataManager.shared.context.fetch(solicitud)) ?? [])
            .filter { !$0.anulada }
        let total = ventas.reduce(0) { $0 + $1.total }

        let calendario = Calendar.current
        let delMes = ventas.filter {
            $0.fecha.map { calendario.isDate($0, equalTo: Date(), toGranularity: .month) } ?? false
        }
        let totalMes = delMes.reduce(0) { $0 + $1.total }

        let titulo = esSupervisor ? "Ventas del sistema" : "Mis ventas"
        let tarjetaVentas = crearTarjetaEstadistica(
            texto: String(format: "%@\n%d por S/ %.2f", titulo, ventas.count, total))
        let tarjetaMes = crearTarjetaEstadistica(
            texto: String(format: "Este mes\n%d por S/ %.2f", delMes.count, totalMes))

        let pilaEstadisticas = UIStackView(arrangedSubviews: [tarjetaVentas, tarjetaMes])
        pilaEstadisticas.axis = .horizontal
        pilaEstadisticas.distribution = .fillEqually
        pilaEstadisticas.spacing = 12
        pilaEstadisticas.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return pilaEstadisticas
    }

    private func crearTarjetaEstadistica(texto: String) -> UILabel {
        let etiqueta = UILabel()
        etiqueta.text = texto
        etiqueta.numberOfLines = 2
        etiqueta.textAlignment = .center
        etiqueta.font = .systemFont(ofSize: 14, weight: .semibold)
        etiqueta.backgroundColor = .secondarySystemBackground
        etiqueta.layer.cornerRadius = 10
        etiqueta.clipsToBounds = true
        return etiqueta
    }

    // MARK: - Cerrar sesión

    @objc private func cerrarSesion() {
        // 1) Se limpia la sesión (ya no hay usuario actual)
        Sesion.compartida.usuarioActual = nil

        // 2) Se vuelve al login reemplazando la raíz de la ventana
        guard let ventana = view.window else { return }
        ventana.rootViewController = UINavigationController(rootViewController: LoginViewController())
        UIView.transition(with: ventana, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
    }
}
