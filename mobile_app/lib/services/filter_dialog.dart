import 'package:flutter/material.dart';

class FilterDialog {
  static Future<void> showFilterDialog(
      BuildContext context,
      String? selectedDonationTypeId,
      Function(String) onFilterSelected,
      ) {
    // Exemplo de tipos de doação. Substitua pelos IDs reais
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
                  value: type['id'], // Aqui você deve usar o ID real do tipo de doação
                  groupValue: selectedDonationTypeId, // Mantém o valor selecionado
                  onChanged: (value) {
                    onFilterSelected(value.toString()); // Chama a função de filtro
                    Navigator.of(context).pop(); // Fecha o diálogo
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
  }
}