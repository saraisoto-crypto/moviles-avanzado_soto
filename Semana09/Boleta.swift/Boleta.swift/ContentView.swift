import SwiftUI
import UIKit

struct ContentView: View {
    // Datos del formulario
    @State private var sueldoTexto = ""
    @State private var diasTexto = ""
    @State private var hijosIndex = 0               // 0 = No, 1 = Sí
    @State private var sistema: SistemaPension = .onp
    @State private var nombreAFP = "AFP Ejemplo"
    @State private var horas25Texto = ""
    @State private var horas35Texto = ""
    @State private var adelantosTexto = ""

    // Resultado
    @State private var mensajeError = ""
    @State private var boleta: Boleta? = nil

    var listaAFP: [String] {
        Parametros.tasasAFP.keys.sorted()
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Boleta de ejemplo")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.blue)

                // ---------- Formulario ----------
                VStack(alignment: .leading, spacing: 12) {
                    campo("Sueldo básico (S/)", "Ej: 2500.00", $sueldoTexto, .decimalPad)

                    HStack(alignment: .top, spacing: 12) {
                        campo("Días laborados (1-30)", "Ej: 30", $diasTexto, .numberPad)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("¿Tiene hijos?")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Picker("¿Tiene hijos?", selection: $hijosIndex) {
                                Text("No").tag(0)
                                Text("Sí").tag(1)
                            }
                            .pickerStyle(.segmented)
                        }
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Sistema de pensiones")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Picker("Sistema de pensiones", selection: $sistema) {
                            ForEach(SistemaPension.allCases, id: \.self) { s in
                                Text(s.rawValue).tag(s)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    if sistema == .afp {
                        HStack {
                            Text("AFP")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Picker("AFP", selection: $nombreAFP) {
                                ForEach(listaAFP, id: \.self) { nombre in
                                    Text(nombre).tag(nombre)
                                }
                            }
                            .pickerStyle(.menu)
                            Spacer()
                        }
                    }

                    HStack(alignment: .top, spacing: 12) {
                        campo("Horas extras 25%", "0", $horas25Texto, .decimalPad)
                        campo("Horas extras 35%", "0", $horas35Texto, .decimalPad)
                    }

                    campo("Adelantos (S/)", "0.00", $adelantosTexto, .decimalPad)

                    Button("Calcular") {
                        ocultarTeclado()
                        calcular()
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    if !mensajeError.isEmpty {
                        Text(mensajeError)
                            .foregroundColor(.red)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.08))
                .cornerRadius(14)

                // ---------- Boleta ----------
                if let b = boleta {
                    VistaBoleta(boleta: b)
                }
            }
            .padding()
        }
        .scrollDismissesKeyboard(.interactively)
    }

    // MARK: - Campo de texto reutilizable

    func campo(_ titulo: String, _ placeholder: String,
               _ texto: Binding<String>, _ teclado: UIKeyboardType) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(titulo)
                .font(.subheadline)
                .foregroundColor(.gray)
            TextField(placeholder, text: texto)
                .keyboardType(teclado)
                .textFieldStyle(.roundedBorder)
        }
    }

    func ocultarTeclado() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil)
    }

    // MARK: - Lectura y validación

    /// Convierte texto a Decimal. Devuelve nil si no es un número válido.
    func leerDecimal(_ texto: String) -> Decimal? {
        let t = texto
            .trimmingCharacters(in: .whitespaces)
            .replacingOccurrences(of: ",", with: ".")
        if t.isEmpty { return nil }
        let soloNumeros = t.allSatisfy { $0.isNumber || $0 == "." }
        let puntos = t.filter { $0 == "." }.count
        if !soloNumeros || puntos > 1 { return nil }
        return Decimal(string: t, locale: Locale(identifier: "en_US_POSIX"))
    }

    /// Campo opcional: vacío = 0, inválido = nil
    func leerOpcional(_ texto: String) -> Decimal? {
        let t = texto.trimmingCharacters(in: .whitespaces)
        if t.isEmpty { return 0 }
        return leerDecimal(t)
    }

    func calcular() {
        boleta = nil
        mensajeError = ""

        guard let sueldo = leerDecimal(sueldoTexto), sueldo > 0 else {
            mensajeError = "El sueldo básico debe ser un número mayor que cero."
            return
        }
        guard let dias = Int(diasTexto.trimmingCharacters(in: .whitespaces)),
              dias >= 1, dias <= 30 else {
            mensajeError = "Los días laborados deben ser un número entero entre 1 y 30."
            return
        }
        guard let h25 = leerOpcional(horas25Texto), h25 >= 0 else {
            mensajeError = "Las horas extras al 25% deben ser un número mayor o igual a cero."
            return
        }
        guard let h35 = leerOpcional(horas35Texto), h35 >= 0 else {
            mensajeError = "Las horas extras al 35% deben ser un número mayor o igual a cero."
            return
        }
        guard let adelantos = leerOpcional(adelantosTexto), adelantos >= 0 else {
            mensajeError = "Los adelantos deben ser un número mayor o igual a cero."
            return
        }

        let datos = DatosBoleta(
            sueldoBasico: sueldo,
            diasLaborados: dias,
            tieneHijos: hijosIndex == 1,
            sistema: sistema,
            nombreAFP: nombreAFP,
            horasExtras25: h25,
            horasExtras35: h35,
            adelantos: adelantos
        )
        boleta = Boleta(datos: datos)
    }
}

// MARK: - Boleta (3 bloques, uno debajo del otro)

struct VistaBoleta: View {
    let boleta: Boleta

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("BOLETA DE PAGO (Boleta de ejemplo)")
                .font(.headline)

            bloque(titulo: "REMUNERACIONES",
                   color: .blue,
                   conceptos: boleta.remuneraciones,
                   nombreTotal: "Total remuneraciones",
                   total: boleta.totalRemuneraciones)

            bloque(titulo: "RETENCIONES / DESCUENTOS",
                   color: .orange,
                   conceptos: boleta.descuentos,
                   nombreTotal: "Total descuentos",
                   total: boleta.totalDescuentos)

            // Aportaciones del empleador (no se descuenta al trabajador)
            VStack(alignment: .leading, spacing: 8) {
                Text("APORTACIONES DEL EMPLEADOR")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.gray)
                fila(nombre: "EsSalud (9%)", monto: boleta.essalud)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.12))
            .cornerRadius(14)

            VStack(spacing: 4) {
                Text("NETO A PAGAR")
                    .font(.subheadline)
                    .bold()
                Text("S/ \(boleta.neto.soles())")
                    .font(.largeTitle)
                    .bold()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green.opacity(0.25))
            .cornerRadius(14)
        }
    }

    func bloque(titulo: String, color: Color, conceptos: [Concepto],
                nombreTotal: String, total: Decimal) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.caption)
                .bold()
                .foregroundColor(color)
            ForEach(conceptos) { c in
                fila(nombre: c.nombre, monto: c.monto)
            }
            Divider()
            HStack {
                Text(nombreTotal).bold()
                Spacer()
                Text(total.soles()).bold()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.opacity(0.10))
        .cornerRadius(14)
    }

    func fila(nombre: String, monto: Decimal) -> some View {
        HStack {
            Text(nombre)
            Spacer()
            Text(monto.soles())
        }
    }
}

#Preview {
    ContentView()
}
