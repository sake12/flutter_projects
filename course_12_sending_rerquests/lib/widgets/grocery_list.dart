import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() async {
    final url = Uri.https(
        'flutterudemytest-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list.json');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch. error: ${response.statusCode}';
        });
      }

      if (response.body == "null") {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final List<GroceryItem> loadedItems = [];
      for (var element in listData.entries) {
        final category = categories.entries
            .firstWhere((x) => x.value.title == element.value['category']);
        loadedItems.add(
          GroceryItem(
            id: element.key,
            name: element.value['name'],
            quantity: element.value['quantity'],
            category: category.value,
          ),
        );
      }

      setState(() {
        _groceryItems = loadedItems;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to fetch!';
      });
    }
  }

  void _addNewItem() async {
    final item = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (item == null) {
      return;
    }

    setState(() {
      _groceryItems.add(item);
    });
  }

  void _removeItem(GroceryItem groceryItem) async {
    var name = groceryItem.name;

    final url = Uri.https(
        'flutterudemytest-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list/${groceryItem.id}.json');

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      setState(() {
        _error = 'Failed to fetch. error: ${response.statusCode}';
      });
    }

    setState(() {
      _groceryItems.remove(groceryItem);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Removed: $name '),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No data'),
    );

    if (_isLoading == true) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_groceryItems[index].id),
            onDismissed: (direction) {
              _removeItem(_groceryItems[index]);
            },
            child: ListTile(
              title: Text(_groceryItems[index].name),
              leading: Container(
                width: 24,
                height: 24,
                color: _groceryItems[index].category.color,
              ),
              trailing: Text(
                _groceryItems[index].quantity.toString(),
              ),
            ),
          );
        },
      );
    }

    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Groceries"),
          actions: [
            IconButton(
              onPressed: _addNewItem,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: content);
  }
}
