import 'package:afrigas/modelspx/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/database.dart';
import '../../../responsive.dart';
import '../card/cartCard.dart';
import '../modelspx/student.dart';



class Searchresult extends StatefulWidget {


  final String collection;
  final String name;

  Searchresult({required this.collection,required this.name}) ;


  // Press "Command + ."

  @override
  _ListOfEmailsState createState() => _ListOfEmailsState();
}

class _ListOfEmailsState extends State<Searchresult> {
  //final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();







  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;


    return Scaffold(

      body:
      Container(
        child: MultiProvider(providers: [



          StreamProvider.value(
              value: DataBaseService(uid:firebaseAuth.currentUser!.uid,email:firebaseAuth.currentUser!.email).userData, initialData: null),





        ],
            child: NewWidget(collection: widget.collection,name:widget.name),




      ),

    )
    );
  }
}

class NewWidget extends StatefulWidget {

  final String collection;
  final String name;

  const NewWidget({required this.collection,required this.name});

  @override
  State<NewWidget> createState() => _NewWidgetState();





}





class _NewWidgetState extends State<NewWidget> {
  late Query<Product> usersQuery;


  @override
  void initState() {




     usersQuery = FirebaseFirestore.instance.collection("Products").where('id',isEqualTo: widget.collection)
        .withConverter<Product>(
      fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );


    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    final student = Provider.of<StudentData?>(context);


    return Scaffold(

        appBar: AppBar(

          centerTitle: false,
          title: Container(

            child: Text(widget.name.replaceAll('\n', "; "),style: TextStyle(fontWeight: FontWeight.bold),),
          ), // like this!
        ),

      body:student!=null? FirestoreListView<Product>(
        physics: BouncingScrollPhysics(),


        query: usersQuery,
        itemBuilder: (context, snapshot) {
          // Data is now typed!
          Product user = snapshot.data();

          return ProductCardx(
            cart: user,
            press: () {

            }, student: student!,
          );
        },
      ):CircularProgressIndicator(strokeWidth: 1,),



    );
  }
}

