import 'package:flutter/material.dart';

class FilterDialog {
  static Future<void> showFilterDialog(
      BuildContext context,
      String? selectedDonationTypeId,
      Function(String) onFilterSelected,
      ) {

    List<Map<String, String>> donationTypes = [
      {'id': 'alimento', 'name': 'Alimento'},
      {'id': 'racao', 'name': 'Ração'},
      {'id': 'roupa', 'name': 'Roupa'},
    ];

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filtrar por Tipo de Doação'),
          content: SingleChildScrollView(
            child: ListBody(
              children: donationTypes.map((type) {
                return RadioListTile(
                  title: Text(type['name']!),
                  value: type['id'],
                  groupValue: selectedDonationTypeId,
                  onChanged: (value) {
                    onFilterSelected(value.toString());
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}