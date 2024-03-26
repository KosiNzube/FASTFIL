
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Orderx{
   String userID;
   String name;
   String hostelname;
   String hostelID;

   String service;
   String userphone;
   int price;
   String blockNO;
   String roomNO;
   String id;
   String kg;
   String state;
   bool stateBool;
   String agent;
   String agentID;
   Timestamp deliveryDate;

   Timestamp timestamp;

   Orderx({
      required this.hostelname,
      required this.blockNO,

      required this.name,
      required this.hostelID,
      required this.kg,
      required this.price,
      required this.agentID,
      required this.userphone,
      required this.service,

      required this.roomNO,
      required this.stateBool,
      required this.agent,
      required this.id,

      required this.userID,
      required this.state,
      required this.deliveryDate,
      required this.timestamp});
}


List<Orderx> items(QuerySnapshot snapshot ){
   return snapshot.docs.map((doc){
      return Orderx(
         id: doc.get('id')??'',
         name: doc.get('name') ,
         userID: doc.get('userID')??'',
         agent: doc.get('agent')??'',
         kg: doc.get('kg')??'',
         hostelID: doc.get('hostelID')??'',
         price: doc.get('price')??0,
         agentID: doc.get('agentID')??'',
         userphone: doc.get('userphone')??'',
         service: doc.get('service')??'',

         state: doc.get('state')??'',
         blockNO: doc.get('blockNO')??"",
         roomNO: doc.get('roomNO')??"",
         hostelname: doc.get('hostelname')??0,

         stateBool: doc.get('stateBool')??false,
         deliveryDate: doc.get('deliveryDate')??Timestamp(0, 0),

         timestamp: doc.get('timestamp')??Timestamp(0, 0),

      );
   }).toList();
}



Stream<List<Orderx>> get getOrders{
   FirebaseAuth firebaseAuth=FirebaseAuth.instance;

   return FirebaseFirestore.instance.collection("Orders").where("userID",isEqualTo: firebaseAuth.currentUser!.uid).orderBy('timestamp',descending: true).limit(30).snapshots().map(items);
}


Stream<List<Orderx>> get getOrderstore{
   FirebaseAuth firebaseAuth=FirebaseAuth.instance;

   return FirebaseFirestore.instance.collection("Orders").where("userID",isEqualTo: firebaseAuth.currentUser!.uid).where("service", isEqualTo: "In Store Purchase").orderBy('timestamp',descending: true).limit(30).snapshots().map(items);
}


Stream<List<Orderx>> get recentOrders{
   FirebaseAuth firebaseAuth=FirebaseAuth.instance;

   return FirebaseFirestore.instance.collection("Orders").where("userID",isEqualTo: firebaseAuth.currentUser!.uid).where("state",isEqualTo: "In Progress").orderBy('timestamp',descending: true).limit(30).snapshots().map(items);
}