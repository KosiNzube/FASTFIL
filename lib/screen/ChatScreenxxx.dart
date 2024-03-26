import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../auth/auth.dart';
import '../auth/database.dart';
import '../auth/messageDatabase.dart';
import '../auth/orderDatabase.dart';
import '../card/agentCard.dart';
import '../modelspx/Agents.dart';
import '../modelspx/Message.dart';
import '../modelspx/calls.dart';
import '../modelspx/student.dart';
import '../newbies/input_widget.dart';
import '../responsive.dart';
import '../services/paystack_integration.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../services/yiyi.dart';
import 'ChatScreen.dart';

class ChatScreenxxx extends StatefulWidget {
  ChatScreenxxx({
    Key? key, required this.message
  }) : super(key: key);

  final Message message;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<ChatScreenxxx> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();





  @override
  Widget build(BuildContext context) {

    FirebaseAuth firebaseAuth=FirebaseAuth.instance;



    return MultiProvider(

      providers: [
        StreamProvider.value(
            value: DataBaseService(uid: widget.message.student, email: '').userData, initialData: null
        ),
        StreamProvider.value(
            value: Agent(id: widget.message.agent).userData, initialData: null
        ),


      ],
      child:NewWidgetxxx( formKey: formKey, commentController: commentController, firebaseAuth: firebaseAuth,message:widget.message),
    );


  }

}

class NewWidgetxxx extends StatefulWidget {
  const NewWidgetxxx({
    super.key,
    required this.formKey,
    required this.commentController,
    required this.firebaseAuth, required this.message,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController commentController;
  final FirebaseAuth firebaseAuth;
  final Message message;

  @override
  State<NewWidgetxxx> createState() => _NewWidgetxxxState();
}

class _NewWidgetxxxState extends State<NewWidgetxxx> {
  //final formKey = GlobalKey<FormState>();
  ScrollController xx=ScrollController();
  @override
  Widget build(BuildContext context) {

    final agentdata = Provider.of<AgentData?>(context);
    final studentdata = Provider.of<StudentData?>(context);
    final usersQuery = FirebaseFirestore.instance.collection("Messages").where('agent',isEqualTo: widget.message.agent).where("student",isEqualTo: widget.message.student).orderBy('timestamp',descending: true).limit(50).snapshots().map(itemsmsgs);




    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 2,),
                CircleAvatar(
                  backgroundImage: NetworkImage(agentdata!.image),
                  maxRadius: 20,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(agentdata!.name,style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                      SizedBox(height: 6,),
                      Text(agentdata!.active==true?  "Active":"Inactive",style: TextStyle( fontSize: 13),),
                    ],
                  ),
                ),
                InkWell(
                    onTap: (){

                      final CollectionReference _reference =
                      FirebaseFirestore.instance.collection('Calls');


                      _reference.add({'userID': studentdata!.id, 'id': "", 'agentID': agentdata.id, 'number': agentdata.number,'timestamp': Timestamp.now(),'agentname':agentdata.name}).then((value) async {
                        _reference.doc(value.id).update({'id': value.id});
                      });

                      launchPhoneDialer(agentdata!.number);
                    },

                    child: Icon(CupertinoIcons.phone)),
              ],
            ),
          ),
        ),
      ),


      body:MultiProvider(
          providers: [
            StreamProvider.value(
                value: usersQuery, initialData: null),

          ],
          child: chatxxx(agent:agentdata,student: studentdata!))


















          /*
      Container(
        child: CommentBox(
          userImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/afri-gas.appspot.com/o/1personicon2.png?alt=media&token=56ed9007-3744-46d1-8272-096aae5baf53") ,
          child: NewWidget(usersQuery: usersQuery,),
          labelText: 'Write a message...',
          withBorder: false,
          errorText: 'Messages cannot be blank',
          sendButtonMethod: () async {
            if (widget.formKey.currentState!.validate()) {
              print(widget.commentController.text);


              sendMessageToTopic(agentdata!.id, studentdata!.name, widget.commentController.text);

              await messageDatabase(
                  uid: widget.firebaseAuth.currentUser!.uid)
                  .addMessage(agentdata!.id, studentdata!.id ,widget.commentController.text,"text",false,Timestamp.fromDate(DateTime.now()),false).whenComplete((){




              });

              widget.commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: widget.formKey,
          commentController: widget.commentController,
          sendWidget: Icon(CupertinoIcons.arrowshape_turn_up_right_fill, size: 30),
        ),
      ),

           */
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
  super.key,
  required this.usersQuery, required this. xx,
  });

  final ScrollController xx;
  final Query<Message> usersQuery;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);




    return FirestoreListView<Message>(
      physics: BouncingScrollPhysics(),


      controller: xx,

      query: usersQuery,
      itemBuilder: (context, snapshot) {
        // Data is now typed!
        Message user = snapshot.data();


        if(user.agentsender==true) {
          messageDatabase(uid: user.id).updateSent();
        }

        return  Container(
          padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
          child: Column(
            children: [
              Align(
                alignment: (user.agentsender == false?Alignment.topLeft:Alignment.topRight),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (user.agentsender == true?Colors.deepPurple:Colors.blue[300]),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(user.content, style: TextStyle(fontSize: 15,color: Colors.white),),
                ),
              ),
              Align(

                  alignment: (user.agentsender == false?Alignment.topLeft:Alignment.topRight),

                  child: Text(DateFormat('HH:mm').format(user.timestamp.toDate())))

            ],
          ),
        );





      },
    );
  }
}


List<AgentData> items(QuerySnapshot snapshot ){
  return snapshot.docs.map((doc){
    return AgentData(
      name: doc.get('name') ,
      image: doc.get('image'),
      online: doc.get('online')??false,
      hostel: doc.get('hostel'),
      disablestamp: doc.get('disablestamp')??Timestamp(0, 0),
      disable: doc.get('disable')??false,
      state: doc.get('state'),

      hostelID: doc.get('hostelID'),
      id: doc.get('id'),
      number: doc.get("name"),
      active: doc.get('active')??false,
      deliveries: doc.get('deliveries')??0,
      rating: doc.get('rating')??0,


    );
  }).toList();
}

void sendMessageToTopic(String topic, String title, String body) async {
  final String serverKey =
      'AAAAdI9gbIs:APA91bGyzl5yItTowitWbZoIiJMOKbUisJKreCWsCq7blS1KQ0pFM9acMtUH-lLxQJejJwWbie5qX0onPhPTMO-tSBXnEqzhah7AqV24BUpmJ0zdT3r1MaLgaLA1QXIRtRG8y9v-girh'; // Replace with your FCM server key from the Firebase Console

  final Uri fcmUrl = Uri.parse('https://fcm.googleapis.com/fcm/send');

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  final Map<String, dynamic> message = {
    'to': '/topics/$topic',
    'notification': {
      'title': title,
      'body': body,
      'sound': 'default',
    },
  };

  try {
    final http.Response response = await http.post(
      fcmUrl,
      headers: headers,
      body: json.encode(message),
    );

    if (response.statusCode == 200) {
      print('Message sent successfully to topic: $topic');
    } else {
      print('Failed to send message. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending message: $e');
  }
}
Future<void> launchPhoneDialer(String phoneNumber) async {
  final Uri phoneLaunchUri = Uri(scheme: 'tel', path: phoneNumber);

  if (await canLaunch(phoneLaunchUri.toString())) {
    await launch(phoneLaunchUri.toString());
  } else {
    throw 'Could not launch $phoneNumber';
  }
}


class HandleScrollWidget extends StatefulWidget {
  final BuildContext context;
  final Widget child;
  final ScrollController controller;

  HandleScrollWidget(this.context, {required this.controller, required this.child});

  @override
  _HandleScrollWidgetState createState() => _HandleScrollWidgetState();
}

class _HandleScrollWidgetState extends State<HandleScrollWidget> {
  double? _offset;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(widget.context).viewInsets.bottom;
    if (bottom == 0) {
      _offset = null;
    } else if (bottom != 0 && _offset == null) {
      _offset = widget.controller.offset;
    }
    if (bottom > 0) widget.controller.jumpTo(_offset! + bottom);
    return widget.child;
  }
}