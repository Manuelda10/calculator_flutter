import 'package:flutter/material.dart';
import 'utils/decimal_formatter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _firstNumberController = TextEditingController();
  final TextEditingController _secondNumberController = TextEditingController();
  String _result = '0.0';

  @override
  void initState() {
    super.initState();
  }

  void _calculateResult() {
    double firstNumber = double.tryParse(_firstNumberController.text) ?? 0.0;
    double secondNumberPorcent = double.tryParse(_secondNumberController.text) ?? 0.0;
    double secondNumber = firstNumber * (secondNumberPorcent / 100);
    double result = firstNumber + secondNumber;
    setState(() {
      _result = result.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _firstNumberController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                decoration: const InputDecoration(labelText: 'Valor inicial (S/.)'),
                
              ),
              TextFormField(
                controller: _secondNumberController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                decoration: const InputDecoration(labelText: 'Porcentaje adicional (%)'),
                
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0), // Añade margen solo en la parte inferior
                child: ElevatedButton(
                  onPressed: () {
                    _calculateResult();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    backgroundColor: Colors.white ,
                    foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
                  ), 
                  child: const Text('Calcular')
                ),
              ),
              
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10), // Espaciado interno
                margin: const EdgeInsets.symmetric(vertical: 20), // Margen externo
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white), // Borde de la caja
                  borderRadius: BorderRadius.circular(5), // Esquinas redondeadas
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Valor de venta (S/.)',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _result, 
                      textAlign: TextAlign.center,// Variable que contiene el resultado
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ), 
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    _firstNumberController.dispose();
    _secondNumberController.dispose();
    super.dispose();
  }
}
