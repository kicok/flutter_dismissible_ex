import 'package:flutter/material.dart';

class SavedItems extends StatelessWidget {
  final List<String> savedItems;
  const SavedItems({Key? key, required this.savedItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${savedItems.length} items saved'),
        ),
        body: savedItems.isEmpty
            ? const Center(
                child: Text(
                'No Itemns',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ))
            : ListView.builder(
                itemCount: savedItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(8),
                    elevation: 8,
                    child: ListTile(
                      title: Text(savedItems[index]),
                    ),
                  );
                }));
  }
}
