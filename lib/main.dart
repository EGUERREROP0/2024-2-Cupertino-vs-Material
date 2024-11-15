import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cupertino vs Material',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _selectedCupertinoDate = DateTime.now();
  DateTime _selectedMaterialDate = DateTime.now();

  String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: Colors.white,
        child: CupertinoDatePicker(
          initialDateTime: _selectedCupertinoDate,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (DateTime newDate) {
            setState(() {
              _selectedCupertinoDate = newDate;
            });
          },
        ),
      ),
    );
  }

  Future<void> _showMaterialDatePicker(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedMaterialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedMaterialDate) {
      setState(() {
        _selectedMaterialDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cupertino vs Material Widgets'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                color: const Color.fromARGB(255, 226, 207, 37),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.calendar, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Fecha (Cupertino)',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onPressed: () => _showCupertinoDatePicker(context),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showMaterialDatePicker(context),
                icon: Icon(Icons.calendar_today),
                label: Text('Fecha (Material)'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                color: const Color.fromARGB(255, 112, 231, 83),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.bell, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Mostrar Alerta (Cupertino)',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                      title: Text('Alerta Cupertino'),
                      content: Text('Este es un alerta al estilo iOS.'),
                      actions: [
                        CupertinoDialogAction(
                          child: Text('Cancelar'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        CupertinoDialogAction(
                          child: Text('Aceptar'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Alerta Material'),
                      content:
                          Text('Este es un alerta al estilo Material Design.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Aceptar'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.notification_important),
                label: Text('Mostrar Alerta (Material)'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            SizedBox(height: 20),
            CupertinoContextMenu(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                color: const Color.fromARGB(255, 216, 105, 105),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.text_cursor),
                    SizedBox(width: 8),
                    Text(
                      'Cupertino: Mantener presionado',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              actions: <CupertinoContextMenuAction>[
                CupertinoContextMenuAction(
                  child: Text('Pegar'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoContextMenuAction(
                  child: Text('Seleccionar todo'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            PopupMenuButton<String>(
              onSelected: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Seleccionaste: $value')),
                );
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'paste',
                    child: Text('Pegar'),
                  ),
                  PopupMenuItem<String>(
                    value: 'selectAll',
                    child: Text('Seleccionar todo'),
                  ),
                ];
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                color: Colors.grey[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.text_snippet),
                    SizedBox(width: 8),
                    Text('Material: Presionar para opciones'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
