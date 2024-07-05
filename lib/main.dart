import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConversionApp());
}

class TemperatureConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Conversion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureConversionScreen(),
    );
  }
}

class TemperatureConversionScreen extends StatefulWidget {
  @override
  _TemperatureConversionScreenState createState() =>
      _TemperatureConversionScreenState();
}

class _TemperatureConversionScreenState
    extends State<TemperatureConversionScreen> {
  String _conversionType = 'F to C';
  final TextEditingController _inputController = TextEditingController();
  String _result = '';
  List<String> _history = [];

  void _convertTemperature() {
    setState(() {
      double input = double.tryParse(_inputController.text) ?? 0.0;
      double output;

      if (_conversionType == 'F to C') {
        output = (input - 32) * 5 / 9;
        _result =
            '${input.toStringAsFixed(2)} °F = ${output.toStringAsFixed(2)} °C';
      } else {
        output = input * 9 / 5 + 32;
        _result =
            '${input.toStringAsFixed(2)} °C = ${output.toStringAsFixed(2)} °F';
      }

      _history.add(_result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convert'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                'Select Conversion Type:',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 58, 0, 0)),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Radio<String>(
                                    value: 'F to C',
                                    groupValue: _conversionType,
                                    onChanged: (value) {
                                      setState(() {
                                        _conversionType = value!;
                                      });
                                    },
                                  ),
                                  Text('Fahrenheit to Celsius',
                                      style: TextStyle(color: Colors.black)),
                                  SizedBox(width: 16),
                                  Radio<String>(
                                    value: 'C to F',
                                    groupValue: _conversionType,
                                    onChanged: (value) {
                                      setState(() {
                                        _conversionType = value!;
                                      });
                                    },
                                  ),
                                  Text('Celsius to Fahrenheit',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                              SizedBox(height: 16),
                              TextField(
                                controller: _inputController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Enter Temperature',
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _convertTemperature,
                                child: Text('Convert'),
                              ),
                              SizedBox(height: 16),
                              Text(
                                _result,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(height: 16),
                              Divider(color: Colors.black),
                              Text(
                                'Conversion History:',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              SizedBox(height: 8),
                              Container(
                                height: 200,
                                child: ListView.builder(
                                  itemCount: _history.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        _history[index],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
