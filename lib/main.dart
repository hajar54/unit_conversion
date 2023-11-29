import 'package:flutter/material.dart';

void main() {
  runApp(UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UnitConverterScreen(),
    );
  }
}

class UnitConverterScreen extends StatefulWidget {
  @override
  _UnitConverterScreenState createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  double inputValue = 0.0;
  double convertedValue = 0.0;
  String selectedInputUnit = 'Meters';
  String selectedOutputUnit = 'Feet';

  final List<String> lengthUnits = ['Meters', 'Feet'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Value'),
              onChanged: (value) {
                setState(() {
                  inputValue = double.tryParse(value) ?? 0.0;
                  _convert();
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDropdown(lengthUnits, selectedInputUnit, (value) {
                  setState(() {
                    selectedInputUnit = value;
                    _convert();
                  });
                }),
                Text('to'),
                _buildDropdown(lengthUnits, selectedOutputUnit, (value) {
                  setState(() {
                    selectedOutputUnit = value;
                    _convert();
                  });
                }),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Result: ${_formattedResult()}'),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(List<String> units, String selectedUnit, ValueChanged<String> onChanged) {
    return DropdownButton<String>(
      value: selectedUnit,
      items: units.map((unit) {
        return DropdownMenuItem<String>(
          value: unit,
          child: Text(unit),
        );
      }).toList(),
      onChanged: (String? value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }

  String _formattedResult() {
    return convertedValue.toStringAsFixed(2);
  }

  void _convert() {
    if (selectedInputUnit == 'Meters' && selectedOutputUnit == 'Feet') {
      convertedValue = inputValue * 3.28084;
    } else if (selectedInputUnit == 'Feet' && selectedOutputUnit == 'Meters') {
      convertedValue = inputValue / 3.28084;
    } else {
      // Handle other conversions as needed
      convertedValue = 0.0;
    }
  }
}
