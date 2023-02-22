import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project01/wordsJSON.dart';
import 'package:flutter/services.dart' show rootBundle;

class searchWord extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Future<List<wordsJSON>> ReadJsonData(String? query) async {
    final jsondata = await rootBundle.loadString('jsonFile/wordsJSON.json');
    final list = json.decode(jsondata) as List<dynamic>;

    var results = list.map((e) => wordsJSON.fromJson(e)).toList();
    if (query != null) {
      results = results
          .where((element) =>
              element.amharic!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    return results;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search goes here'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: ReadJsonData(query),
      builder: (context, data) {
        if (data.hasError) {
          return Center(child: Text('${data.error}'));
        } else if (data.hasData) {
          var items = data.data as List<wordsJSON>;
          return ListView.builder(
            itemCount: items == null ? 0 : items.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Text(items[index].amharic.toString()),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Text(items[index].english.toString()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
