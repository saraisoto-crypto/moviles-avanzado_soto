import SwiftUI

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
            VStack(alignment: .leading, spacing: 12) {
                Text("Boleta de ejemplo")
                    .font(.title)
                    .bold()

                Text("Sueldo básico (S/)")
                TextField("Ej: 2500.00", text: $sueldoTexto)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)

                Text("Días laborados (1 a 30)")
                TextField("Ej: 30", text: $diasTexto)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)

                Text("¿Tiene hijos?")
                Picker("¿Tiene hijos?", selection: $hijosIndex) {
                    Text("No").tag(0)
                    Text("Sí").tag(1)
                }
                .pickerStyle(.segmented)

                Text("Sistema de pensiones")
                Picker("Sistema de pensiones", selection: $sistema) {
                    ForEach(SistemaPension.allCases, id: \.self) { s in
                        Text(s.rawValue).tag(s)
                    }
                }
                .pickerStyle(.segmented)

                if sistema == .afp {
                    Text("AFP")
                    Picker("AFP", selection: $nombreAFP) {
                        ForEach(listaAFP, id: \.self) { nombre in
                            Text(nombre).tag(nombre)
                        }
                    }
                    .pickerStyle(.menu)
                }

                Text("Horas extras al 25%")
                TextField("0", text: $horas25Texto)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)

                Text("Horas extras al 35%")
                TextField("0", text: $horas35Texto)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)

                Text("Adelantos (S/)")
                TextField("0.00", text: $adelantosTexto)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)

                Button("Calcular") {
                    calcular()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

                if !mensajeError.isEmpty {
                    Text(mensajeError)
                        .foregroundColor(.red)
                }

                // Resultado temporal (en el Commit 3 lo cambiamos por la boleta completa)
                if let b = boleta {
                    Text("Neto a pagar: S/ \(b.neto.soles())")
                        .font(.headline)
                }
            }
            .padding()
        }
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

#Preview {
    ContentView()
}
