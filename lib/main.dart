// ignore_for_file: list_remove_unrelated_type

import 'package:dismissible_ex/saved_items.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dissmissible Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> items = List.generate(30, (i) => 'Item ${i + 1}');
  final List<String> savedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dissmissible Demo'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return SavedItems(savedItems: savedItems);
                }));
              },
              icon: const Icon(Icons.verified))
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(items[index]),
            background: Container(
              color: Colors.green,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: const Icon(Icons.save, size: 36, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerRight,
              child: const Icon(Icons.delete, size: 36, color: Colors.white),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                print('Delete');
                setState(() {
                  items.removeAt(index);
                });
              } else if (direction == DismissDirection.startToEnd) {
                print('save');
                setState(() {
                  savedItems.add(items[index]);
                  items.removeAt(index);
                });
              }
            },
            confirmDismiss: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                return showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text('Are you sure?'),
                      content: Text('Now I am Deleting ${items[index]}'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            return Navigator.of(context).pop(false);
                          },
                          child: const Text('CANCEL'),
                        ),
                        TextButton(
                          onPressed: () {
                            return Navigator.of(context).pop(true);
                          },
                          child: const Text('DELETE'),
                        ),
                      ],
                    );
                  },
                );
              } else if (direction == DismissDirection.startToEnd) {
                return showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text('Are you sure?'),
                      content: Text('Now saving ${items[index]}'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            return Navigator.of(context).pop(false);
                          },
                          child: const Text('CANCEL'),
                        ),
                        TextButton(
                          onPressed: () {
                            return Navigator.of(context).pop(true);
                          },
                          child: const Text('SAVE'),
                        ),
                      ],
                    );
                  },
                );
              }
              return Future.value(false);
            },
            child: Card(
              margin: const EdgeInsets.all(8),
              elevation: 8,
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(items[index].split(" ")[1]),
                ),
                title: Text(
                  items[index],
                  style: const TextStyle(fontSize: 16),
                ),
                subtitle: Text('${items[index]} draggable'),
                trailing: const Icon(Icons.more_vert),
              ),
            ),
          );
        },
      ),
    );
  }
}
