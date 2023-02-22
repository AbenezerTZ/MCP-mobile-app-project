import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:project01/search.dart';
import 'package:project01/wordsJSON.dart';
import 'package:project01/screens/favoritePage.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fluttertoast/fluttertoast.dart';

Future<List<wordsJSON>> ReadJsonData() async {
  final jsondata = await rootBundle.loadString('jsonFile/wordsJSON.json');
  final list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => wordsJSON.fromJson(e)).toList();
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

List favorites = [];

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amharic Dictionary'),
        backgroundColor: Colors.brown.shade900,
        // leading: Icon(Icons.menu),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: searchWord());
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.0),
                child: Text(
                  'አማርኛ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(width: 70,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'English',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text('${data.error}'));
          } else if (data.hasData) 
           {
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
                        GestureDetector(
                          onTap: () {
                            favorites.add(index);
                          },
                          child: _AddButton(
                            amharic: items[index].amharic.toString(),
                            english: items[index].english.toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}


class _AddButton extends StatefulWidget {
  final String amharic;
  final String english;
  const _AddButton(
      {Key? key,
      required this.amharic,
      required this.english})
      : super(key: key);

  @override
  __AddButtonState createState() => __AddButtonState();
}

setFavorite(String amharic, String english) {
  if (!Amhariclist.contains(amharic)) {
    addToFavorite(amharic, english);
  }
}

bool favorite_flag = false;

void showToast() => Fluttertoast.showToast(
      msg: 'ቃሉ በተሳካ ሁኔታ ወደ ምርጫዎ ገብቷል።',
      fontSize: 18,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.brown.shade900,
    );

class __AddButtonState extends State<_AddButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: favorite_flag
          ? Icon(Icons.favorite, color: Colors.brown.shade900)
          : Icon(Icons.favorite_border, color: Colors.brown.shade900),
      onPressed: (() {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('ይህንን ቃል ወደ ምርጫዎ (Favorite) ማስገባት ይፍልጋሉ?'),
            actions: [
              TextButton(
                onPressed: () {
                  setFavorite(widget.amharic, widget.english);
                  showToast();
                  setState(() {
                    favorite_flag = !favorite_flag;
                  });
                  Navigator.of(context).pop();
                },
                child: Text('አዎ'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    favorite_flag = !favorite_flag;
                  });
                  Navigator.of(context).pop();
                },
                child: Text('አይ'),
              ),
            ],
          ),
        );
      }),
    );
  }
}

