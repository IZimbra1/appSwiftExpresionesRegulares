import SwiftUI

struct ContentView: View {
    
    @State var textFieldInfo = ""
    @State private var showAlert = false
    @State private var selectedRegexIndex = 0
    
    // Lista de expresiones regulares para diferentes tipos de validación
    let regexOptions = [
        ("Correo", "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"),
        ("Telefono", "^[0-9]{3}-[0-9]{3}-[0-9]{4}$"),
        ("Direccion IP", "^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
    ]
    
    // Expresión regular que corresponde a la opción seleccionada
    var selectedRegex: String {
        regexOptions[selectedRegexIndex].1
    }
    
    var body: some View {
        VStack {
            // Picker para seleccionar la expresión regular
            Picker("Select validation type", selection: $selectedRegexIndex) {
                ForEach(0..<regexOptions.count, id: \.self) { index in
                    Text(regexOptions[index].0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // Campo de texto
            TextField("Enter text", text: $textFieldInfo)
                .frame(width: 259, height: 40)
                .multilineTextAlignment(.center)
                .padding()
            
            // Botón para validar el texto
            Button("Validate") {
                if textFieldInfo.range(of: selectedRegex, options: .regularExpression) == nil {
                    showAlert = true
                } else {
                    print("Valid \(regexOptions[selectedRegexIndex].0)")
                }
            }
            .alert("Invalid input", isPresented: $showAlert) {
                Button("Ok", role: .cancel) {
                    showAlert = false
                }
            }
            .padding()
        }
        .padding()
    }
}

