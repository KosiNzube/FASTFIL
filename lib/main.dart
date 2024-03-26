import 'dart:math';

import 'package:afrigas/pages/page_home.dart';
import 'package:afrigas/services/routes.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'auth/auth.dart';
import 'auth/controller2.dart';
import 'comp2/DarkThemeProvider.dart';
import 'comp2/Styles.dart';
import 'modelspx/student.dart';


void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
   // name:"Fast-fil",

    options:FirebaseOptions(
      apiKey: "AIzaSyBRWe6ljejI4tJLMTfjjfISQniFbNK-S6M",
      appId: "1:500621667467:web:2a39d8a92661995991788e",
      messagingSenderId: "500621667467",
      projectId: "afri-gas"),);


  if(kIsWeb){

  }else{

    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.white)
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true
    );


    await FlutterDownloader.initialize(
        debug: true, // optional: set to false to disable printing logs to console (default: true)
        ignoreSsl: true // option: set to false to disable working with http links (default: false)
    );
  }
 // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Colors.black));

  runApp( MyApp());


}



class MyApp extends StatefulWidget {

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String name = 'Fasfil';
  static const Color mainColor = Colors.deepPurple;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {

    AwesomeNotifications().setListeners(
        onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    );



    getCurrentAppTheme();

    loadPreferences();
    super.initState();

  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }


  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });


    return
      ChangeNotifierProvider(
        create: (_) {
          return themeChangeProvider;
        },
        child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, Widget? child) {

               return GetMaterialApp(
                  shortcuts: {
                    LogicalKeySet(LogicalKeyboardKey.space): ActivateIntent(),
                  },
                  builder: FlutterSmartDialog.init(),

                  debugShowCheckedModeBanner: false,
                  theme: Styles.themeData(
                      themeChangeProvider.darkTheme, context),
                  navigatorKey: MyApp.navigatorKey,

                  title: MyApp.name,
                  color: MyApp.mainColor,
                  initialRoute: Routes.home,
                  onGenerateRoute: (RouteSettings settings) {
                    return Routes.fadeThrough(settings, (context) {
                      final settingsUri = Uri.parse(settings.name!);
                      final postID = settingsUri.queryParameters['id'];
                      print(postID); //will print "123"


                      if (settings.name!.contains(Routes.privacy)) {
                        return HomePage();
                      }

                      if (settings.name == Routes.home) {
                        return MultiProvider(
                            providers: [
                              StreamProvider<Student?>.value(
                                value: AuthSerives().user,
                                initialData: null,
                              )
                            ],

                            child: Controller2());
                      }


                      return Center(child: CircularProgressIndicator(strokeWidth: 1,));
                    });
                  },

                );

          },
        ),);
  }
  Future<void> loadPreferences() async {
    // Load the preference for navigation bar color
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool savedColor = prefs.getBool('isNavBarBlack') ?? false;

    // Set the navigation bar color based on the saved preference
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: savedColor ? Colors.black : Colors.white,
      ),
    );

    // Update the state

  }

}

class MyHomePage extends StatefulWidget{
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}




class NotificationController {

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future <void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future <void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future <void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here

    /*
    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
            (route) => (route.settings.name != Routes.privacy) || route.isFirst,
        arguments: receivedAction);

     */
  }
}

class Notify{
  static Future<bool> instantNotify() async{
    final AwesomeNotifications awesomeNotifications=AwesomeNotifications();
    return awesomeNotifications.createNotification(content: NotificationContent(id: Random().nextInt(100), channelKey: "basic_channel",title: "Fastfil",body: "Welcome to Fastfil"));
  }
}
