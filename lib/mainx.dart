import 'package:afrigas/card/usercartCard.dart';
import 'package:afrigas/extensions.dart';
import 'package:afrigas/modelspx/Cart.dart';
import 'package:afrigas/modelspx/Product.dart';
import 'package:afrigas/modelspx/Quantity.dart';
import 'package:afrigas/modelspx/catrogory.dart';
import 'package:afrigas/pages/about.dart';
import 'package:afrigas/pages/contact.dart';
import 'package:afrigas/responsive.dart';
import 'package:afrigas/screen/ChatScreen.dart';
import 'package:afrigas/screen/ChatScreenxxx.dart';
import 'package:afrigas/screen/CheckoutCard.dart';
import 'package:afrigas/screen/afrostore.dart';
import 'package:afrigas/screen/chatlist.dart';
import 'package:afrigas/screen/list_xyy.dart';
import 'package:afrigas/screen/liveTrack.dart';
import 'package:afrigas/screen/notification.dart';
import 'package:afrigas/screen/referdashboard.dart';
import 'package:algolia/algolia.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:client_information/client_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'auth/auth.dart';
import 'auth/database.dart';
import 'card/agentCard.dart';
import 'card/cartCard.dart';
import 'card/matchcardyy.dart';
import 'card/noti_card.dart';
import 'card/orderCard.dart';
import 'comp2/DarkThemeProvider.dart';
import 'comp2/main_button.dart';
import 'components/custom_text.dart';
import 'components/style.dart';
import 'constants.dart';
import 'modelspx/Admin.dart';
import 'modelspx/Agents.dart';
import 'modelspx/Library.dart';
import 'modelspx/Offcamp.dart';
import 'modelspx/Order.dart';
import 'modelspx/State.dart';
import 'modelspx/calls.dart';
import 'modelspx/hostels.dart';
import 'modelspx/notification.dart';
import 'modelspx/payclass.dart';
import 'modelspx/student.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);



  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int curr=0;
  AuthSerives _serives = AuthSerives();

  String statename="----";

  void logOut(BuildContext context) async {
    await _serives.logOut();
  }
  List<Widget> listcolors = <Widget>[];
  late TabController _controller;
  Future<String> _dataRequiredForBuild=getinfo();
  TextEditingController name = new TextEditingController();

  @override
  void initState() {



    FirebaseAuth firebaseAuth=FirebaseAuth.instance;

   // listcolors.add(Afrostore());
    /*
    listcolors.add(MultiProvider(
        providers: [



          StreamProvider.value(
              value: getAllStudents, initialData: null)
        ],
        child: Afrostore()));


     */

    listcolors.add(Afrostore());


    listcolors.add(MultiProvider(
        providers: [


          StreamProvider.value(
              value: DataBaseService(uid:firebaseAuth.currentUser!.uid,email:firebaseAuth.currentUser!.email).userData, initialData: null),

          StreamProvider.value(
              value: getQuantities, initialData: null),
          StreamProvider.value(
              value: adminData, initialData: null)
        ],
        child: List_xxy()));


    listcolors.add(Chatlist());



    /*
    listcolors.add( MultiProvider(
        providers: [

          StreamProvider.value(
              value: getcalls, initialData: null)
        ],
        child: calls()));

     */
    listcolors.add(MultiProvider(
        providers: [


          StreamProvider.value(

            value: getStates, initialData: null,),
        ],
        child: Account()));




    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);
    final states = Provider.of<List<Statex?>>(context);

    final student = Provider.of<StudentData?>(context);

    final admin = Provider.of<Admin>(context);




    if (x_Snulle==false) {


      logOut(context);

      setState(() {
        x_Snulle=true;
      });
    }




    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);


    if(student!=null&&student.state.isNotEmpty) {
      setState(() {
        x_State = student.state;
      });
    }


    return student!=null?  student.referGuy.isNotEmpty?student.state!=null&&student.state.isNotEmpty ?  Scaffold(

      body:FutureBuilder<String>(
        future: _dataRequiredForBuild,
        builder: (context, snapshot) {
         return PersistentTabView(


           context,
           backgroundColor: mode.brightness==Brightness.dark?CupertinoColors.darkBackgroundGray :Colors.white,
           controller: _controller,
           screens: listcolors,
           items: _navBarsItems(),
           confineInSafeArea: true,
           // Default is Colors.white.
           handleAndroidBackButtonPress: true,
           // Default is true.
           resizeToAvoidBottomInset: true,
           // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
           stateManagement: true,
           // Default is true.
           hideNavigationBarWhenKeyboardShows: true,
           // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
           decoration: NavBarDecoration(
             boxShadow: <BoxShadow>[
               BoxShadow(
                 color:mode.brightness==Brightness.dark? Colors.white24:Colors.black45,
                 blurRadius: mode.brightness==Brightness.dark?1:5,
               ),
             ],
             colorBehindNavBar:mode.brightness==Brightness.dark?CupertinoColors.lightBackgroundGray :Colors.white,
           ),
           popAllScreensOnTapOfSelectedTab: true,
           popActionScreens: PopActionScreensType.all,
           itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
             duration: Duration(milliseconds: 200),
             curve: Curves.ease,
           ),
           screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
             animateTabTransition: true,
             curve: Curves.ease,
             duration: Duration(milliseconds: 200),
           ),
           navBarStyle: NavBarStyle
               .style14, // Choose the nav bar style with this property.

         );

        },
    ),
    ):Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),

        child: Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15,top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [



              SizedBox(height: kDefaultPadding*5),

              Text("State/Residence",style: TextStyle(fontSize: 39,fontWeight: FontWeight.w600,color: active,),textAlign: TextAlign.center,),

              SizedBox(height: kDefaultPadding*2),

              InkWell(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return states!=null? Center(
                        child: ListView.builder(

                          itemCount: states.length,
                          // On mobile this active dosen't mean anything
                          itemBuilder: (context, index) {
                            return Center(
                              child: AlertDialog(
                                  content: InkWell(
                                    onTap: (){
                                      statename=states[index]!.name;

                                      setState(() {

                                        statename=states[index]!.name;
                                      });
                                      print(states[index]!.name);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(states[index]!.name),
                                  ),
                              ),
                            );



                          },
                        ),
                      ):Container();
                    },
                  );

                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0,),

                  decoration: BoxDecoration(
                    //color: active,
                    border: Border.all(color: active),

                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      Container(

                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,

                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: kDefaultPadding / 2),



                                Expanded(

                                  child: Text(statename,style: TextStyle(color: active,),),
                                ),

                              ],
                            ),
                          ],
                        ),

                      ),
                      Positioned.fill(

                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 13.0),
                            child: Icon( CupertinoIcons.chevron_up_chevron_down,color: active,),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding),


              InkWell(
                onTap: () async {
                  if (statename.length > 0) {



                    await FirebaseFirestore.instance.collection('students').doc(student.id).update({'state': statename});
                    setState(() {
                      x_State = statename;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Select state"),

                        ));
                  }


                },
                child: Container(
                  decoration: BoxDecoration(color: active,
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CustomText(
                    text: "Continue",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding*6),


            ],
          ),
        ),
      ),
    ): Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),

        child: Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15,top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [



              SizedBox(height: kDefaultPadding*5),

              Text("Were you referred?",style: TextStyle(fontSize: 39,fontWeight: FontWeight.w600,color: active,),textAlign: TextAlign.center,),

              SizedBox(height: kDefaultPadding*2),

              TextField(
                controller: name,

                decoration: InputDecoration(
                    labelText: "Referral code",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),


              SizedBox(height: kDefaultPadding),


              InkWell(
                onTap: () async {
                  if (name.text.length > 0) {
                    if(admin.refercodes.contains(name.text)) {
                      SmartDialog.showLoading(msg:"Just a moment");

                      QuerySnapshot q = await FirebaseFirestore.instance
                          .collection('students').where(
                          "myrefercode", isEqualTo: name.text).get();

                      if (q.docs.isNotEmpty) {
                        dynamic docc = q.docs.first.data() ;

                       await FirebaseFirestore.instance.collection('students').doc(
                            student.id).update({"referGuy": docc['id']});

                       SmartDialog.dismiss();
                      }
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Invalid code"),

                          ));

                    }

                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Type in the referral code"),

                        ));
                  }


                },
                child: Container(
                  decoration: BoxDecoration(color: active,
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CustomText(
                    text: "Continue",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding/2),


              InkWell(
                onTap: () async {
                   FirebaseFirestore.instance.collection('students').doc(student.id).update({'referGuy': "none"});


                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CustomText(
                    text: "NO, SKIP THIS",
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: kDefaultPadding*6),


            ],
          ),
        ),
      ),
    ) : Scaffold(
      body: Center(
        child: CircularProgressIndicator(strokeWidth: 1,),
      ),
    );





  }




}

Future<String> getinfo() async {
  ClientInformation info = await ClientInformation.fetch();

  return info.deviceId;

}
List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.home),
      title: ("Home"),

      contentPadding: 1,
      textStyle: TextStyle(fontSize: 13.5,fontWeight: FontWeight.w500),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,

    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.checkmark_seal),
      title: ("Re-fill"),
      textStyle: TextStyle(fontSize: 13.5,fontWeight: FontWeight.w500),
      contentPadding: 1,

      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.chat_bubble_text),
      title: ("Chat"),
      textStyle: TextStyle(fontSize: 13.5,fontWeight: FontWeight.w500),
      contentPadding: 1,

      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),

    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.settings),
      title: ("More"),
      textStyle: TextStyle(fontSize: 13.5,fontWeight: FontWeight.w500),
      contentPadding: 1,

      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    )


  ];
}





class payx extends StatefulWidget {

  @override
  State<payx> createState() => _payxState();
}

class _payxState extends State<payx> {
  @override
  Widget build(BuildContext context) {
    final brewx = Provider.of<List<PayClass>>(context);
    final student = Provider.of<StudentData>(context);

    Size _size = MediaQuery
        .of(context)
        .size;
      return Scaffold(

          appBar: AppBar(
            centerTitle: false,
            title: Container(

              child: Text("Premium"),
            ),
            // like this!
          ),

        body: brewx!=null? Responsive(

          // Let's work on our mobile part
          mobile: ListOfPay(brewx: brewx,student:student),
          tablet: ListOfPay(brewx: brewx,student:student),
          desktop: ListOfPay(brewx: brewx,student:student),
        ):Center(child: CircularProgressIndicator()),
      );

  }
}

class chat extends StatefulWidget {

  @override
  State<chat> createState() => _chatState();
}



class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    final brewx = Provider.of<List<AgentData?>>(context);
    final student = Provider.of<StudentData?>(context);


    return Scaffold(


      body: brewx!=null && student!=null?

      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),

            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,


              itemCount: brewx.length,
              // On mobile this active dosen't mean anything
              itemBuilder: (context, index) => agentCard(
                email: brewx[index]!,
                student:student,
                press: () {

                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen:ChatScreen(agent:brewx[index]! ,student: student,),







                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation
                        .cupertino,
                  );

                },
              ),
            ),
          ],
        ),
      ):Center(child: CircularProgressIndicator()),
    );

  }
}








class calls extends StatelessWidget {
  const calls({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final calls = Provider.of<List<Calls?>>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Container(

          child: Text("Calls",),
        ),
        // like this!
      ),



      body:calls!=null?  calls.length>0?ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,


        itemCount: calls.length,
        // On mobile this active dosen't mean anything
        itemBuilder: (context, index) =>  Stack(
          children: [

            Container(
              padding: EdgeInsets.all(kDefaultPadding/2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                //   borderRadius: BorderRadius.circular(15),

                //  color:mode.brightness==Brightness.dark?  Color.fromARGB(250, 45, 45, 60) :Colors.white,
              ),
              child: Column(

                children: [
                  SizedBox(height: kDefaultPadding / 2),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Responsive.isDesktop(context)? 60:40,
                        height: Responsive.isDesktop(context)? 60:40,

                        child: InkWell(
                            onTap: (){
                              launchPhoneDialer(calls[index]!.number);
                            },

                            child: Icon(CupertinoIcons.phone)),
                      ),
                      SizedBox(width: kDefaultPadding ),



                      Expanded(


                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                calls[index]!.agentname ,textAlign: TextAlign.left,style:GoogleFonts.lato(

                                fontSize: Responsive.isDesktop(context)? 19:16,fontWeight: FontWeight.w600,color: Colors.pink)

                            ),


                            SizedBox(height: 7),

                            Text(
                                DateFormat('EEE, M/d/y').format(calls[index]!.timestamp.toDate())
                                ,textAlign: TextAlign.left,style:GoogleFonts.lato(
                                fontSize: Responsive.isDesktop(context)? 19:15)


                            )

                          ],
                        ),







                      ),


                      SizedBox(width: kDefaultPadding / 2),

                    ],
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                ],
              ),
            )
          ],
        ),) :Container(

        child: Center(
          child: SingleChildScrollView(
            physics: ScrollPhysics() ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Image.asset(
                  'assets/images/xl.png',
                  width: 350,
                  height: Responsive.isMobile(context)?300:600,

                ),
                SizedBox(height: 20.0),

                Text(
                  'No calls yet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20.0),

              ],
            ),
          ),
        ),

      ):CircularProgressIndicator(strokeWidth: 1,),
    );
  }
}





class Account extends StatefulWidget {
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String statename="";

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final ThemeData mode=Theme.of(context);
    final brewx = Provider.of<StudentData>(context);
    final states = Provider.of<List<Statex?>>(context);

    Size _size = MediaQuery
        .of(context)
        .size;
      return Scaffold(

        appBar: AppBar(
          centerTitle: false,
          title: Container(

            child: Text("Account",),
          ),
          // like this!
        ),


        body:brewx!=null&&states!=null? SingleChildScrollView(
          physics: BouncingScrollPhysics(),

          child: Column(
            children: [
              SizedBox(height: kDefaultPadding/2),




              brewx.affiliate==true?InkWell(
                onTap: () async {

                  /*
                setState(() async {
                  themeChange.darkTheme = false;


                  SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle(
                      systemNavigationBarColor:  Colors.white,
                    ),
                  );

                  // Save the new preference
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool('isNavBarBlack', false);

                });


                 */

                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen:referDashboard(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation
                        .cupertino,
                  );

                },
                child: Container(
                  // height: 90,
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF4A3298),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          style: GoogleFonts.raleway(color: Colors.white),
                          children: [
                            TextSpan(text: "Revenue\n"),
                            TextSpan(
                              text: formatAmountWithNairaSign(brewx.earnings)+".00",
                              style: GoogleFonts.nunito(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //     Icon(CupertinoIcons.star,color: Colors.white,)

                    ],
                  ),
                ),
              ):  InkWell(
                onTap: () async {

                  /*
                setState(() async {
                  themeChange.darkTheme = false;


                  SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle(
                      systemNavigationBarColor:  Colors.white,
                    ),
                  );

                  // Save the new preference
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool('isNavBarBlack', false);

                });


                 */

                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen:referDashboard(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation
                        .cupertino,
                  );

                },
                child: Container(
                  // height: 90,
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF4A3298),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          style: GoogleFonts.raleway(color: Colors.white),
                          children: [
                            TextSpan(text: "Make money on FASTFIL\n"),
                            TextSpan(
                              text: "Become an Affiliate now",
                              style: GoogleFonts.raleway(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //     Icon(CupertinoIcons.star,color: Colors.white,)

                    ],
                  ),
                ),
              ),










              accard(s:brewx.email,x:"Email",q:Icons.email),



              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
                child: InkWell(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return states!=null? Center(
                          child: ListView.builder(

                            itemCount: states.length,
                            // On mobile this active dosen't mean anything
                            itemBuilder: (context, index) {
                              return Center(
                                child: AlertDialog(
                                  content: InkWell(
                                    onTap: () async {
                                      statename=states[index]!.name;

                                      setState(() {

                                        statename=states[index]!.name;
                                      });
                                      print(states[index]!.name);
                                      Navigator.of(context).pop();
                                      SmartDialog.showLoading(msg: "Just a moment...", backDismiss: true);

                                      await FirebaseFirestore.instance.collection('students').doc(brewx.id).update({'state': states[index]!.name});
                                      setState(() {
                                        x_State = states[index]!.name;
                                      });
                                      SmartDialog.dismiss();


                                    },
                                    child: Text(states[index]!.name),
                                  ),
                                ),
                              );



                            },
                          ),
                        ):Container();
                      },
                    );

                  },
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(kDefaultPadding),
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text.rich(


                                    TextSpan(
                                      text: "Residence\n",
                                      style: TextStyle(
                                        fontSize: Responsive.isDesktop(context)?20:  16,
                                        fontWeight: FontWeight.w600,
                                      ),

                                      children: [

                                        TextSpan(
                                          text: brewx.state,
                                          style: TextStyle(
                                            fontSize: Responsive.isDesktop(context)?22:  18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Icon(Icons.home)

                              ],
                            ),
                            SizedBox(height: kDefaultPadding / 2),
                          ],
                        ),
                      ).addNeumorphism(
                        blurRadius: mode.brightness==Brightness.dark?0: 15,
                        borderRadius: mode.brightness==Brightness.dark?9: 15,
                        offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),



              /*
            accardy(s:"Fastfil Store",x:"",q: CupertinoIcons.cart,press: () {

              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen:Afrostore(),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation
                    .cupertino,
              );

            }),

             */

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
                child: InkWell(
                  onTap: () async {


                  },
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(kDefaultPadding),
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text.rich(


                                    TextSpan(
                                      text: "Dark mode\n",
                                      style: TextStyle(
                                        fontSize: Responsive.isDesktop(context)?20:  16,
                                        fontWeight: FontWeight.w600,
                                      ),

                                      children: [
                                        TextSpan(
                                          text: "Theme",
                                          style: TextStyle(
                                            fontSize: Responsive.isDesktop(context)?22:  18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.redAccent,
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                ),

                                Checkbox(
                                    value: themeChange.darkTheme,
                                    onChanged: (bool? value) async {
                                      themeChange.darkTheme = value!;

                                      SystemChrome.setSystemUIOverlayStyle(
                                        SystemUiOverlayStyle(
                                          systemNavigationBarColor: value ? Colors.black : Colors.white,
                                        ),
                                      );

                                      // Save the new preference
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setBool('isNavBarBlack', value);
                                    }

                                    )
                              ],
                            ),
                            SizedBox(height: kDefaultPadding / 2),
                          ],
                        ),
                      ).addNeumorphism(
                        blurRadius: mode.brightness==Brightness.dark?0: 15,
                        borderRadius: mode.brightness==Brightness.dark?9: 15,
                        offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),



              accard(s:"Fastfil Mobile 1.0",x:"Version",q: Icons.app_settings_alt),

              accard(s:"Lunosmart labs",x:"Developed by",q: Icons.code),
              accard(s:"Chat with us",x:"Send a Whatsapp chat",q: CupertinoIcons.chat_bubble_text),


              accard(s:"Sign out",x:"Privacy",q: Icons.account_box),
              accardy(s:"About us",x:"",q: CupertinoIcons.chevron_forward,press: () {

                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen:About(),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation
                      .cupertino,
                );

              }),
              accardy(s:"Contact us",x:"",q: CupertinoIcons.chevron_forward,press: () {

                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen:Contact(),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation
                      .cupertino,
                );

              }),


            ],
          ),
        ):Center(child: CircularProgressIndicator()),
      );

  }
}


class accard extends StatelessWidget {
  const accard({
    Key? key, required this.s, required this.x,required this.q
  }) : super(key: key);

  final IconData q;
  final String s;
  final String x;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);

    AuthSerives _serives = AuthSerives();

    void logOut(BuildContext context) async {
      await _serives.logOut();
    }
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: () async {
          if(s.contains("Sign out")){
            logOut(context);

          }
          if(s.contains("Chat with us")){
            var whatsapp = "++2349055772501";
            var whatsappAndroid =Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
            if (await canLaunchUrl(whatsappAndroid)) {
          await launchUrl(whatsappAndroid);
          } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("WhatsApp is not installed on the device"),),);
            }
          }

        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text.rich(


                          TextSpan(
                            text: s.length>1? "${x} \n":"${x}",
                            style: TextStyle(
                              fontSize: Responsive.isDesktop(context)?20:  16,
                              fontWeight: FontWeight.w600,
                            ),

                            children: [

                              TextSpan(
                                text: s,
                                style: TextStyle(
                                  fontSize: Responsive.isDesktop(context)?22:  18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Icon(q)

                    ],
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                ],
              ),
            ).addNeumorphism(
              blurRadius: mode.brightness==Brightness.dark?0: 15,
              borderRadius: mode.brightness==Brightness.dark?9: 15,
              offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
            ),
          ],
        ),
      ),
    );
  }
}


class accardy extends StatelessWidget {
  const accardy({
    Key? key, required this.s, required this.x,required this.q, required this.press
  }) : super(key: key);

  final IconData q;
  final String s;
  final String x;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);

    AuthSerives _serives = AuthSerives();

    void logOut(BuildContext context) async {
      await _serives.logOut();
    }
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: ()  {

          press();

        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(s,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                      ),

                      Icon(q)

                    ],
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                ],
              ),
            ).addNeumorphism(
              blurRadius: mode.brightness==Brightness.dark?0: 15,
              borderRadius: mode.brightness==Brightness.dark?9: 15,
              offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
            ),
          ],
        ),
      ),
    );
  }
}



class today extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final orders = Provider.of<List<Orderx>>(context);

    final ThemeData mode=Theme.of(context);

    Size _size = MediaQuery
        .of(context)
        .size;

    return Scaffold(


      appBar:AppBar(
        centerTitle: false,
        title: TimeOfDayWidget(),

        actions: [


          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(onPressed: (){
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: Notifications(),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );

            }, icon: Icon(Icons.email)),
          )

        ],// like this!
      ),






      body:orders!=null?orders.length>0? SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: kDefaultPadding/2),
            InkWell(
              onTap: (){
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen:Afrostore(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation
                      .cupertino,
                );

              },
              child: Container(
                // height: 90,
                width: double.infinity,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF4A3298),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(text: "Grocery, cylinders and other accesories\n"),
                          TextSpan(
                            text: "Fastfil Store",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Icon(CupertinoIcons.cart,color: Colors.white,)

                  ],
                ),
              ),
            ),
            CustomText(
              text: "RECENT ORDERS",
              size: 20,
            ),
            SizedBox(height: kDefaultPadding/2),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,


              itemCount: orders.length,
              // On mobile this active dosen't mean anything
              itemBuilder: (context, index) => orderCard(
                orderx: orders[index]!,
                press: () {

                  if(orders[index]!.state=="In Progress"){
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen:liveTrack(orderx: orders[index]),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation
                          .cupertino,
                    );
                  }

                },
              ),),
          ],
        ),
      ):SingleChildScrollView(
        physics: BouncingScrollPhysics(),

        child: Column(
          children: [
            SizedBox(height: kDefaultPadding/2),
            InkWell(
              onTap: (){
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen:Afrostore(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation
                      .cupertino,
                );

              },
              child: Container(
                // height: 90,
                width: double.infinity,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF4A3298),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(text: "Grocery, cylinders and other accesories\n"),
                          TextSpan(
                            text: "Fastfil Store",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Icon(CupertinoIcons.cart,color: Colors.white,)

                  ],
                ),
              ),
            ),

            Column(
              children: [
                CustomText(
                  text: "OUR SERVICES",
                  size: 20,
                ),
                SizedBox(height: kDefaultPadding/2),

                EmailCard(isActive: true,image: "https://firebasestorage.googleapis.com/v0/b/afri-gas.appspot.com/o/gasrefill2.jpg?alt=media&token=ce06945d-e173-44eb-9650-7108e196b6f5",conyext: "Gas refill",press: (){},),

                SizedBox(height: kDefaultPadding/2),


                EmailCard(isActive: true,image: "https://firebasestorage.googleapis.com/v0/b/afri-gas.appspot.com/o/cyzz.jpeg?alt=media&token=6350486e-b4fa-4e30-b064-fd860523dcfa",conyext: "Selling of gas cylinders and other accessories",press: (){},),

                SizedBox(height: kDefaultPadding/2),
                EmailCard(isActive: true,image: "https://firebasestorage.googleapis.com/v0/b/afri-gas.appspot.com/o/Products%2Fbarbacue.jpg?alt=media&token=e03d93c5-774b-4ad9-9335-77d912a78446",conyext: "Food items, groceries and ready made meals",press: (){},),

                SizedBox(height: kDefaultPadding/2),

                Center(
                  child: CustomText(
                    text: "CUSTOMER CARE: 09055772501",
                    size: 20,
                  ),
                ),

              ],
            ),

            SizedBox(height: kDefaultPadding/2),


            InkWell(
              onTap: (){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "You cannot apply at the moment. Please try again later"),

                    ));

              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: [

                    Container(
                      padding: EdgeInsets.all(kDefaultPadding/2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(

                        children: [
                          SizedBox(height: kDefaultPadding / 2),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: kDefaultPadding / 2),



                              Expanded(

                                child: Text.rich(


                                  TextSpan(
                                    text:"Are you interested in being one of our agents?\n",
                                    style: TextStyle(
                                      fontSize: Responsive.isDesktop(context)?19: 16.5,
                                      fontWeight: FontWeight.w500,
                                    ),

                                    children: [

                                      TextSpan(
                                        text: "Submit a request  >",
                                        style: TextStyle(
                                          fontSize: Responsive.isDesktop(context)?20: 16.5,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.brown,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: kDefaultPadding / 2),
                        ],
                      ),
                    ).addNeumorphism(
                      blurRadius: mode.brightness==Brightness.dark?0: 15,
                      borderRadius: mode.brightness==Brightness.dark?9: 15,
                      offset: mode.brightness==Brightness.dark? Offset(0, 0):Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: kDefaultPadding),

          ],
        ),
      ):Center(child: CircularProgressIndicator()),
    );
  }
}
class get_products extends StatelessWidget {

  final String catid;

  final  String catname;


  const get_products({super.key, required this.catid,required this.catname});
  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;

    final usersQuery = FirebaseFirestore.instance.collection("Products").where('mrp',isEqualTo: catid).orderBy('timestamp',descending: false).limit(50).snapshots().map(items_p);


    final ThemeData mode=Theme.of(context);

    Size _size = MediaQuery
        .of(context)
        .size;

    return Scaffold(

      appBar: AppBar(

        centerTitle: false,


        title: Container(
          child: Text(catname,style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 19,
          ),),),),
      body: products!=null ?

      MultiProvider(
          providers: [
            StreamProvider.value(
                value: usersQuery, initialData: null),

            StreamProvider.value(
                value: DataBaseService(
                    uid: firebaseAuth.currentUser!.uid,
                    email: firebaseAuth.currentUser!
                        .email).userData, initialData: null),

          ],
          child: get_products_list()):Center(child: CircularProgressIndicator(strokeWidth: 1,)),
    );
  }
}


class get_products_list extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>?>(context);

    final student = Provider.of<StudentData>(context);


    final ThemeData mode=Theme.of(context);

    Size _size = MediaQuery
        .of(context)
        .size;

    return products!=null? products.length>0?  SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: GridView.builder(

              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 240,
              ),
              primary: false,
              itemCount: products.length,
              itemBuilder: (context, index) => ProductCard(
                cart: products[index],
                press: () {

                }, student: student,
              ),
            ),
          ),
          SizedBox(height: 30.0),

        ],
      ),
    ):Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: 30.0),

          Image.asset(
            'assets/images/xl.png',
            width: 350,
            height: Responsive.isMobile(context) ? 300 : 600,

          ),
          SizedBox(height: 20.0),

          Text(
            'No items in this category yet',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20.0),


        ],
      ),
    ):Center(child: CircularProgressIndicator(strokeWidth: 1,));
  }
}




class products extends StatelessWidget {

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {

    final student = Provider.of<StudentData>(context);
    final products = Provider.of<List<Product>>(context);
    final categories = Provider.of<List<Categoryx>>(context);

    final ThemeData mode=Theme.of(context);

    Size _size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: products!=null && categories!=null ?

      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),


            CarouselSlider.builder(
              itemCount: categories.length>15?15:categories.length,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  InkWell(
                    onTap: () async {

                      PersistentNavBarNavigator .pushNewScreen(
                        context,
                        screen:get_products(catid: categories[itemIndex].id, catname: categories[itemIndex].name),

                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      );

                    },
                    child: Container(
                      decoration:  BoxDecoration(
                        color: CupertinoColors.systemIndigo,
                        borderRadius: BorderRadius.circular(15),



                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[

                              Expanded(
                                child: Text.rich(


                                  TextSpan(
                                    text: categories[itemIndex].name+"\n",
                                    style: GoogleFonts.raleway(
                                      color:  Colors.white,
                                      fontSize: Responsive.isDesktop(context)?19: 16.5,
                                      fontWeight: FontWeight.w500,
                                    ),

                                    children: [

                                      TextSpan(
                                        text: categories[itemIndex].description,
                                        style: GoogleFonts.raleway(
                                          fontSize: Responsive.isDesktop(context)?20: 13.5,
                                          fontWeight: FontWeight.w400,

                                          color:  Colors.yellowAccent,


                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),


                              SizedBox(width: 5,),

                              CachedNetworkImage(
                                imageUrl:categories[itemIndex].photo,
                                imageBuilder: (context, imageProvider) => Container(

                                  width: 65,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain,),
                                  ),
                                ),
                                placeholder: (context, url) =>  Container(
                                  //  color: Colors.white,
                                  width: 65,),
                                errorWidget: (context, url, error) =>Container(
                                  //  color: Colors.black,
                                  width: 65,),
                              ),
                            ]
                        ),
                      ),
                    ),
                  ), options: CarouselOptions(  aspectRatio: 16/9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              height: 100,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,),
            ),




            Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: GridView.builder(

                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 240,
                ),
                primary: false,
                itemCount: products.length,
                itemBuilder: (context, index) => ProductCard(
                  cart: products[index],
                  press: () {

                  }, student: student,
                ),
              ),
            ),

            SizedBox(height: 30.0),

            /*
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,


                itemCount: products.length,
                // On mobile this active dosen't mean anything
                itemBuilder: (context, index) => ProductCard(
                  cart: products[index],
                  press: () {

                  }, student: student,
                ),
              ),
            ),

             */
          ],
        ),
      ):Center(child: CircularProgressIndicator()),
    );
  }
}

class usercat extends StatefulWidget {
  @override
  State<usercat> createState() => _usercatState();
}

class _usercatState extends State<usercat> {
  double xxx =0;

  String xoxo="";

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final hostels = Provider.of<List<Hostel?>>(context);
    final offcamps = Provider.of<List<Offcamp?>>(context);
    final student = Provider.of<StudentData>(context);
    final products = Provider.of<List<Cart>>(context);
    String cityNames="";

    Size _size = MediaQuery
        .of(context)
        .size;


    if(products!=null) {
      xxx = products!   .fold(0.00, (sum, item) => sum + item.saleprice*item.numberofproducts);

      setState(() {
        cityNames = products.map((city) => city.description+"---"+"Quantity: "+city.numberofproducts.toString()).toString();

      });

    }


    return Scaffold(


      bottomNavigationBar: CheckoutCard(xxx:xxx,student:student,des:cityNames,hostels:hostels,offcamps:offcamps),



      body: products!=null ?

      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10,),

              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,


                itemCount: products.length,
                // On mobile this active dosen't mean anything
                itemBuilder: (context, index) => usercartCart(

                  cart: products[index],
                  press: () {

                    print(cityNames);
                  }, student: student,
                ),
              ),
            ],
          ),
        ),
      ):Center(child: CircularProgressIndicator()),
    );
  }
}

class Notifications extends StatefulWidget {

  const Notifications();

  @override
  State<Notifications> createState() => notiState();
}

class notiState extends State<Notifications>  {


  final usersQuery = FirebaseFirestore.instance.collection("Notifications").orderBy('timestamp',descending: true)
      .withConverter<Notificationx>(
    fromFirestore: (snapshot, _) => Notificationx.fromJson(snapshot.data()!),
    toFirestore: (user, _) => user.toJson(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

          centerTitle: false,
          title: Container(

            child: Text("Notifications",style: TextStyle(fontWeight: FontWeight.bold,),),
          ),

        // like this!
      ),

      body:FirestoreListView<Notificationx>(
        physics: BouncingScrollPhysics(),


        query: usersQuery,
        itemBuilder: (context, snapshot) {
          // Data is now typed!
          Notificationx user = snapshot.data();

          return notiCard( email: user,press:(){});
        },
      ),



    );
  }
}
class TimeOfDayWidget extends StatelessWidget {
  String getTimeOfDay() {
    var now = DateTime.now();
    var currentTime = now.hour;

    if (currentTime >= 6 && currentTime < 12) {
      return 'Good morning';
    } else if (currentTime >= 12 && currentTime < 18) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getTimeOfDay(),
    );
  }
}

class callOrders extends StatefulWidget {

  const callOrders();

  @override
  State<callOrders> createState() => callerState();
}

class callerState extends State<callOrders> {


  final usersQuery = FirebaseFirestore.instance.collection("Calls").orderBy('timestamp',descending: true)
      .withConverter<Calls>(
    fromFirestore: (snapshot, _) => Calls.fromJson(snapshot.data()!),
    toFirestore: (user, _) => user.toJson(),
  );
  @override
  Widget build(BuildContext context) {
    final ThemeData mode=Theme.of(context);


    return Scaffold(

      appBar: AppBar(

        centerTitle: false,
        title: Container(

          child: Text("Calls",style: TextStyle(fontWeight: FontWeight.bold),),
        ), // like this!
      ),

      body:   FirestoreListView<Calls>(
        physics: BouncingScrollPhysics(),


        query: usersQuery,
        itemBuilder: (context, snapshot) {
          // Data is now typed!
          Calls user = snapshot.data();

          return Stack(
            children: [

              Container(
                padding: EdgeInsets.all(kDefaultPadding/2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  //   borderRadius: BorderRadius.circular(15),

                  //  color:mode.brightness==Brightness.dark?  Color.fromARGB(250, 45, 45, 60) :Colors.white,
                ),
                child: Column(

                  children: [
                    SizedBox(height: kDefaultPadding / 2),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Responsive.isDesktop(context)? 60:40,
                          height: Responsive.isDesktop(context)? 60:40,

                          child: InkWell(
                              onTap: (){
                                launchPhoneDialer(user.number);
                              },

                              child: Icon(CupertinoIcons.phone)),
                        ),
                        SizedBox(width: kDefaultPadding /2),



                        Expanded(


                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  user.agentname ,textAlign: TextAlign.left,style:GoogleFonts.lato(

                                  fontSize: Responsive.isDesktop(context)? 19:16,fontWeight: FontWeight.w600,color: Colors.pink)

                              ),


                              SizedBox(height: 7),

                              Text(
                                  DateFormat('EEE, M/d/y').format(user.timestamp.toDate())
                                  ,textAlign: TextAlign.left,style:GoogleFonts.lato(
                                  fontSize: Responsive.isDesktop(context)? 19:15)


                              )

                            ],
                          ),







                        ),


                        SizedBox(width: kDefaultPadding / 2),

                      ],
                    ),
                    SizedBox(height: kDefaultPadding / 2),
                  ],
                ),
              )
            ],
          );
        },
      ),



    );
  }
}

List<Product> items_p(QuerySnapshot snapshot ){
  return snapshot.docs.map((doc){
    return Product(
      description: doc.get('description') ,
      mrp: doc.get('mrp'),
      saleprice: doc.get('saleprice'),
      image: doc.get('image'),
      id: doc.get('id'),
      curate: doc.get('curate'),
      name: doc.get('name'),
      previousprice: doc.get('previousprice'),

      timestamp: doc.get('timestamp')??Timestamp(0, 0),


    );
  }).toList();
}