import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/navigator.dart';
import '../bottom_navigation.dart';
import '../search.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

final List<String> Amhariclist = [];
final List<String> Englishlist = [];

void addToFavorite(String amharic, String english) {

  Amhariclist.add(amharic);
  Englishlist.add(english);
}

void removeFromFavorite(String amharic, String english) {

  Amhariclist.remove(amharic);
  Englishlist.remove(english);
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomBar()),
            );
          },
        ),
        title: const Text('Favorite Words'),
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
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: const <Widget>[
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.brown,
      //         ),
      //         child: Text(
      //           'Kafinoonoo Dictionary',
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 24,
      //           ),
      //         ),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.favorite),
      //         title: Text('Favorite'),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.settings),
      //         title: Text('Settings'),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.rate_review),
      //         title: Text('Rate us'),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.account_circle),
      //         title: Text('About us'),
      //       ),
      //     ],
      //   ),
      // ),
      body: ListView.builder(
        itemCount: Amhariclist.length,
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
                    child: Text(Amhariclist[index]),
                  ),
                  Expanded(
                    child: Text(Englishlist[index]),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: (() {
                        setState(() {
                          removeFromFavorite(Amhariclist[index], Englishlist[index]);
                        });
                      }),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FavoriteClass {
  // late String kafigna;
  late String amharic;
  late String english;

  FavoriteClass(
    // this.kafigna,
    this.amharic,
    this.english,
  );

  FavoriteClass.fromJson(Map<String, dynamic> json) {
    // kafigna = json['kafigna'];
    amharic = json['age'];
    english = json['english'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['kafigna'] = this.kafigna;
    data['amharic'] = this.amharic;
    data['english'] = this.english;

    return data;
  }
}
