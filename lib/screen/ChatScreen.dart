import 'dart:math';

import 'package:afrigas/auth/messageDatabase.dart';
import 'package:afrigas/card/orderCard.dart';
import 'package:afrigas/extensions.dart';
import 'package:afrigas/modelspx/Message.dart';
import 'package:afrigas/modelspx/Order.dart';
import 'package:afrigas/screen/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../auth/auth.dart';
import '../auth/orderDatabase.dart';
import '../card/agentCard.dart';
import '../modelspx/Agents.dart';
import '../modelspx/calls.dart';
import '../modelspx/student.dart';
import '../newbies/input_widget.dart';
import '../responsive.dart';
import '../services/paystack_integration.dart';
import '../services/yiyi.dart';
import 'ChatScreenxxx.dart';



class ChatScreen extends StatefulWidget {
  ChatScreen({
    Key? key, required this.agent,required this.student
  }) : super(key: key);

  final AgentData agent;
  final StudentData student;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<ChatScreen> {


  @override
  Widget build(BuildContext context) {

    final usersQuery = FirebaseFirestore.instance.collection("Messages").where('agent',isEqualTo: widget.agent.id).where("student",isEqualTo: widget.student.id).orderBy('timestamp',descending: true).limit(50).snapshots().map(itemsmsgs);



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
                    backgroundImage: NetworkImage(widget.agent.image),
                    maxRadius: 20,
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(widget.agent.name,style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                        SizedBox(height: 6,),
                        Text(widget.agent.active==true?  "Active":"Inactive",style: TextStyle( fontSize: 13),),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){


                      final CollectionReference _reference =
                      FirebaseFirestore.instance.collection('Calls');


                       _reference.add({'userID': widget.student.id, 'id': "", 'agentID': widget.agent.id, 'number': widget.agent.number,'timestamp': Timestamp.now(),'agentname': widget.agent.name}).then((value) async {
                        _reference.doc(value.id).update({'id': value.id});
                      });


                      launchPhoneDialer(widget.agent!.number);



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
          child: chatxxx(agent:widget.agent,student: widget.student))



      /*
      HandleScrollWidget(
        context,
        controller: xx,
        child: yiyi(

          child2:         Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

              ],

            ),
          ),

          userImage: AssetImage('assets/images/qw.png'),
          child: NewWidget(usersQuery: usersQuery,xx:xx),
          labelText: 'Write a message...',

          withBorder: false,
          errorText: 'Messages cannot be blank',
          sendButtonMethod: () async {
            if (formKey.currentState!.validate()) {

              commentController.clear();
              FocusScope.of(context).unfocus();




              // user.add(Message(student:widget.student.id, agent: widget.agent!.id, type: "text", id: "",  agentsender: false, content: commentController.text, sent: false, timestamp: Timestamp.fromDate(DateTime.now())));

              sendMessageToTopic(widget.agent!.id, widget.student!.name, commentController.text);



               messageDatabase(
                  uid: firebaseAuth.currentUser!.uid)
                  .addMessage(widget.agent!.id, widget.student!.id ,commentController.text,"text",false,Timestamp.fromDate(DateTime.now()),false).whenComplete((){


              });

            //  messages.add(commentController.text);








              //  commentController.clear();
              //  FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }

          },
          formKey: formKey,
          commentController: commentController,
          sendWidget: Icon(CupertinoIcons.arrowshape_turn_up_right_fill, size: 30),
        ),
      ),


       */
    );
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

class NewWidget extends StatelessWidget {
  const NewWidget({
  super.key,
  required this.usersQuery, required this. xx,
  });

  final Query<Message> usersQuery;
  final ScrollController xx;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);




    return FirestoreListView<Message>(
      physics: BouncingScrollPhysics(),

      reverse: true,
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

                  child: Row(
                    children: [
                      Text(DateFormat('HH:mm').format(user.timestamp.toDate())),
                      SizedBox(width:user.sent==true? 2:0,),
                   //   Icon(user.sent==true?"Seen":"",style: TextStyle(fontSize: 12),)

                      Icon(user.sent==true?Icons.done_all:null,color: Colors.blue,)
                    ],
                  ))

            ],
          ),
        );





      },
    );
  }
}










class chatxxx extends StatefulWidget {

  final AgentData agent;
  final StudentData student;

  const chatxxx({super.key, required this.agent, required this.student});
  @override
  State<chatxxx> createState() => _chatState();
}



class _chatState extends State<chatxxx> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
   late TextEditingController commentController ;


  String lastMsg="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   commentController = TextEditingController();


  }

  @override
  Widget build(BuildContext context) {

    final brewx = Provider.of<List<Message>?>(context);


    return Scaffold(




     body: yiyi(

        child2:         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

            ],

          ),
        ),

        userImage: AssetImage('assets/images/qw.png'),
        child:  brewx!=null? ListView.builder(
          reverse: true,

         // controller: xx,
          shrinkWrap: true,

          itemCount: brewx.length,


          // On mobile this active dosen't mean anything
          itemBuilder: (context, index) {

            if(brewx[index].agentsender==true) {
              messageDatabase(uid: brewx[index].id).updateSent();

            }

            return GestureDetector(
                onLongPress: () async {
                  Clipboard.setData(ClipboardData(text:brewx[index].content));

                  // Navigator.pop(context);

                  snack("Text copied", context);

                  /*
              showDialog(context: context, builder:  (context2){
                return SimpleDialog(
                  //   title: const Text('Copy'),
                  children: <Widget>[
                    SimpleDialogOption(
                      onPressed: () async {
                        Clipboard.setData(ClipboardData(text:brewx[index].content));

                        Navigator.pop(context2);

                        snack("Text copied", context);
                      },
                      child: const Text('Copy text'),
                    ),


                  ],
                );
              });


               */






                },






                child:Container(
                padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
            child: Column(
            children: [
            Align(
            alignment: (brewx[index].agentsender == false?Alignment.topLeft:Alignment.topRight),
            child: Padding(
              padding: brewx[index].agentsender==false? EdgeInsets.only(right: 15.0):EdgeInsets.only(left: 15.0),
              child: Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (brewx[index].agentsender == true?Colors.deepPurple:Colors.blue[300]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(brewx[index].content, style: TextStyle(fontSize: 15,color: Colors.white),),
                      ),
            ),
                  ),
                  Align(

                      alignment: (brewx[index].agentsender == false?Alignment.topLeft:Alignment.topRight),

                      child: Row(
                        mainAxisAlignment: brewx[index].agentsender == false?  MainAxisAlignment.start: MainAxisAlignment.end,
                        children: [
                          Text(DateFormat('HH:mm').format(brewx[index].timestamp.toDate())),
                          SizedBox(width:brewx[index].sent==true? 2:0,),
                          //   Icon(user.sent==true?"Seen":"",style: TextStyle(fontSize: 12),)

                          brewx[index].agentsender == false?Icon(  brewx[index].sent==true?Icons.done_all:brewx[index].del==true?Icons.done:Icons.alarm_outlined,color:brewx[index].sent==true? Colors.blue:null,size: 14.3,):Container()
                        ],
                      ))

                ],
              ),
            ),
          );
  }
        ):Center(child: CircularProgressIndicator(strokeWidth: 1,)),
        labelText: 'Write a message...',

        withBorder: false,
        errorText: 'Messages cannot be blank',
        sendButtonMethod: () async {
          if (formKey.currentState!.validate()) {

            String x=commentController.text;
            commentController.clear();

            FocusScope.of(context).unfocus();






            // user.add(Message(student:widget.student.id, agent: widget.agent!.id, type: "text", id: "",  agentsender: false, content: commentController.text, sent: false, timestamp: Timestamp.fromDate(DateTime.now())));

            //sendMessageToTopic(widget.agent!.id, widget.student!.name, commentController.text);



            messageDatabase(
                uid: firebaseAuth.currentUser!.uid)
                .addMessage(widget.agent!.id, widget.student!.id ,widget.student!.name,  x,"text",false,Timestamp.fromDate(DateTime.now()),false).whenComplete((){


            });




            //  messages.add(commentController.text);








            //  commentController.clear();
            //  FocusScope.of(context).unfocus();
          } else {
            print("Not validated");
          }

        },
        formKey: formKey,
        commentController: commentController,
        sendWidget: Icon(CupertinoIcons.arrowshape_turn_up_right_fill, size: 30),
      )




    );

  }
}

void snack(String s, BuildContext context) {

  SmartDialog.showToast(s,displayTime: Duration(seconds: 1),alignment:Alignment.center );



}

void snacklong(String s) {

  SmartDialog.showToast(s,displayTime: Duration(seconds: 7),alignment:Alignment.bottomCenter );



}

void snackINS( BuildContext context) {
  SmartDialog.showToast("Only PREMIUM members can make this request",displayTime: Duration(seconds: 3),alignment:Alignment.center );


}


void snackxxx(String s, BuildContext context) {

  SmartDialog.showToast(s,alignment:Alignment.center );


}
void snacklen(String s, BuildContext context) {

  SmartDialog.showToast(s,displayTime: Duration(seconds: 2),alignment:Alignment.center );


}

void snacklenx(String s, BuildContext context) {

  SmartDialog.showToast(s,displayTime: Duration(seconds: 5),alignment:Alignment.center );


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

List<Message> itemsmsgs(QuerySnapshot snapshot ){
  return snapshot.docs.map((doc){
    return Message(
      agent: doc.get('agent') ,
      student: doc.get('student'),
      type: doc.get('type'),
      content: doc.get('content'),
      id: doc.get('id'),
      agentsender: doc.get('agentsender')??false,
      del: doc.get('del')??false,

      sent: doc.get('sent')??false,
      timestamp: doc.get('timestamp')??Timestamp(0, 0),


    );
  }).toList();
}