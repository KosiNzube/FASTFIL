
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'Searchresults.dart';

class Lily extends StatefulWidget {
  @override
  _LilyState createState() => _LilyState();
}

class _LilyState extends State<Lily> {
  late FirebaseFirestore memex;
  late TextEditingController searchController;
  List<MovieNames> originalMovieNamesList = [];
  List<MovieNames> filteredMovieNamesList = [];

  @override
  void initState() {
    super.initState();
    memex = FirebaseFirestore.instance;
    searchController = TextEditingController();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (query) {
                filterData(query);
              },
              decoration: InputDecoration(
                hintText: 'Input text',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
            ),

          ),
          ),
          Expanded(
            child: originalMovieNamesList.length>0? ListView.builder(
              itemCount: filteredMovieNamesList.length>25?25:filteredMovieNamesList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){

                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen:



                      Searchresult(collection: filteredMovieNamesList[index].id,name:filteredMovieNamesList[index].toString()),

                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation
                          .cupertino,
                    );
                  },
                  child: ListTile(
                    title: Text(filteredMovieNamesList[index].toString(),maxLines: 1,),
                    // Add other ListTile properties as needed
                  ),
                );
              },
            ):  Center(child: CircularProgressIndicator(strokeWidth: .8,)),
          ),
        ],
      ),
    );
  }

  void fetchData() async {
    try {
      QuerySnapshot querySnapshot = await memex
          .collection('Products')

          .get();

      List<MovieFree> movieArrayList = querySnapshot.docs
          .map((doc) => MovieFree.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      originalMovieNamesList = movieArrayList
          .map((gigi) => MovieNames('${gigi.name}',"${gigi.id}"))
          .toList();

      originalMovieNamesList.shuffle(); // Shuffle the data if needed
      filterData(searchController.text); // Apply initial filter
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void filterData(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredMovieNamesList = originalMovieNamesList
            .where((movie) =>
            movie.toString().toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        // If query is empty, show all data
        filteredMovieNamesList = List.from(originalMovieNamesList);
      }
    });
  }
}

class MovieFree {
  final String name;
  final String id;

  MovieFree({required this.name,required this.id});

  factory MovieFree.fromJson(Map<String, dynamic> json) {
    return MovieFree(
      name: json['name'] as String,
      id: json['id'] as String,

    );
  }
}

class MovieNames {
  final String movieName;
  final String id;

  MovieNames(this.movieName,this.id);

  @override
  String toString() {
    return movieName;
  }
}
