import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/firebase_options.dart';
import 'package:bmitserp/model/addofflocationdatamodel.dart';
import 'package:bmitserp/provider/inventoryprovider.dart';
import 'package:bmitserp/provider/productprovider.dart';
import 'package:bmitserp/provider/taskprovider.dart';
import 'package:bmitserp/screen/task/task_details.dart';
import 'package:bmitserp/service/push_notifications.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fbroadcast/fbroadcast.dart';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bmitserp/utils/constant.dart';
import 'package:bmitserp/utils/DatabaseHelper.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_broadcasts/flutter_broadcasts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/model/auth.dart';
import 'package:bmitserp/provider/attendancereportprovider.dart';
import 'package:bmitserp/provider/dashboardprovider.dart';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/provider/morescreenprovider.dart';
import 'package:bmitserp/provider/payslipprovider.dart';
import 'package:bmitserp/provider/prefprovider.dart';
import 'package:bmitserp/provider/profileprovider.dart';
import 'package:bmitserp/screen/auth/login_screen.dart';
import 'package:bmitserp/screen/dashboard/dashboard_screen.dart';
import 'package:bmitserp/screen/profile/editprofilescreen.dart';
import 'package:bmitserp/screen/splashscreen.dart';
import 'package:bmitserp/utils/navigationservice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:ui';

import 'package:wakelock/wakelock.dart';

const fetchBackground = "fetchBackground";
const getLocation = "getLocation";
const checkLocationEnabled = "checkLocationEnabled";
final dbHelper = DatabaseHelper();

late SharedPreferences sharedPref;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // BroadcastReceiver receiver = BroadcastReceiver(
  //   names: <String>[
  //     "de.kevlatus.flutter_broadcasts_example.demo_action",
  //   ],
  // );  // receiver.start();
  // receiver.messages.listen(checkLocation());
  FBroadcast.instance().stickyBroadcast("message", value: "data");

  FBroadcast.instance().register("message", (value, callback) {
    var data = value;
    checkLocation();
  });

  if (message.data['taskId'] != null) {
    Get.to(DailyTaskDetails(
      task_id: message.data['taskId'].toString(),
    ));
  }

  Timer.periodic(Duration(minutes: 2), (timer) async 
  {
    Position position = await determinePosition();
    checklocation(position.latitude, position.longitude);
  });
}

checkLocation() async {
  final service = FlutterBackgroundService();
  var isRunning = await service.isRunning();
  if (!isRunning) {
    service.startService();
  }
}

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await setupFlutterNotifications();
//   showFlutterNotification(message);
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   print('Handling a background message ${message}');
// }

// /// Create a [AndroidNotificationChannel] for heads up notifications
// late AndroidNotificationChannel channel;

// bool isFlutterLocalNotificationsInitialized = false;

// Future<void> setupFlutterNotifications() async {
//   if (isFlutterLocalNotificationsInitialized) {
//     return;
//   }
//   channel = const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.high,
//   );

//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   /// Create an Android Notification Channel.
//   ///
//   /// We use this channel in the `AndroidManifest.xml` file to override the
//   /// default FCM channel to enable heads up notifications.
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   /// Update the iOS foreground notification presentation options to allow
//   /// heads up notifications.
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   isFlutterLocalNotificationsInitialized = true;
// }

// void showFlutterNotification(RemoteMessage message) {
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//   if (notification != null && android != null) {
//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: channel.description,
//           // TODO add a proper drawable resource to android, for now using
//           //      one that already exists in example app.
//           icon: 'launch_background',
//         ),
//       ),
//     );
//   }
// }

// /// Initialize the [FlutterLocalNotificationsPlugin] package.
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();

  // Keep the screen on.
  KeepScreenOn.turnOn();

  await Firebase.initializeApp(
    name: 'BMITS ERP',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()!
  //     .requestNotificationsPermission();

   await initializeService();
  sharedPref = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  var status = await Permission.ignoreBatteryOptimizations.status;
  if (!status.isGranted) {
    var status = await Permission.ignoreBatteryOptimizations.request();

    if (status.isGranted) {
      debugPrint("Good, all your permission are granted, do some stuff");
    } else {
      debugPrint("Do stuff according to this permission was rejected");
    }
  }

  //FirebaseMessaging.onBackgroundMessage(_messageHandler);

  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  } else {}

  AwesomeNotifications().initialize(
      'resource://drawable/app_icon',
      [

        NotificationChannel(
            channelGroupKey: 'digital_hr_group',
            channelKey: 'digital_hr_channel',
            channelName: 'Digital Hr notifications',
            channelDescription: 'Digital HR Alert',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'digital_hr_group', channelGroupName: 'HR group')
      ],
      debug: true);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  FirebaseMessaging.onMessage.listen((event) {
  FlutterRingtonePlayer.play(
    fromAsset: "assets/sound/beep.mp3",
  );

  // FirebaseMessaging.onMessage.listen((event) {
  //   FlutterRingtonePlayer.play(
  //     fromAsset: "",
  //   );
    try {
      InAppNotification.show(
        child: Card(
          margin: const EdgeInsets.all(15),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            leading: Container(
                height: double.infinity, child: Icon(Icons.notifications)),
            iconColor: HexColor("#011754"),
            textColor: HexColor("#011754"),
            minVerticalPadding: 10,
            minLeadingWidth: 0,
            tileColor: Colors.white,
            title: Text(
              event.notification!.title!,
            ),
            subtitle: Text(
              event.notification!.body!,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        context: NavigationService.navigatorKey.currentState!.context,
      );
    } catch (e) {
      print(e);
    }
  });
//assets/ca/lets-encrypt-r3.pem
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print("dfgkjdjkfgjkdg  ${message}");
  });
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(MyApp());
  configLoading();
}

const notificationChannelId = 'my_foreground';

const notificationId = 888;

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'MY FOREGROUND SERVICE', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.low,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString("hello", "world");
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  int duration = 1;
  if (service is AndroidServiceInstance) {
    if (await service.isForegroundService()) {
      Position position = await determinePosition();
      checklocation(position.latitude, position.longitude);
      flutterLocalNotificationsPlugin.show(
        888,
        'BMITS ERP is running',
        'last syc at ${DateFormat.jm().format(DateTime.now())}',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'my_foreground',
            'MY FOREGROUND SERVICE',
            icon: '@mipmap/ic_launcher',
            ongoing: true,
          ),
        ),
      );

      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.getString("locationLatLongList");
      String? list = await preferences.getString("locationLatLongList");
      List<Map<String, dynamic>> data = list == null
          ? [
              {
                "value": "lat_${position.latitude} long_${position.longitude}",
                "createdDate": DateTime.now().toIso8601String()
              }
            ]
          : List<Map<String, dynamic>>.from(jsonDecode(list!));
      data.add({
        "value": "lat_${position.latitude} long_${position.longitude}",
        "createdDate": DateTime.now().toIso8601String()
      });
      await preferences.setString(
          "locationLatLongList", jsonEncode(data).toString());
    }
  }

  String? device;

  service.invoke(
    'update',
    {
      "current_date": DateTime.now().toIso8601String(),
      "device": device,
    },
  );
  Timer.periodic(Duration(seconds: 20), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        Position position = await determinePosition();
        checklocation(position.latitude, position.longitude);
        flutterLocalNotificationsPlugin.show(
          888,
          'BMITS ERP is running',
          'last syc at ${DateFormat.jm().format(DateTime.now())}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'my_foreground',
              'MY FOREGROUND SERVICE',
              icon: '@mipmap/ic_launcher',
              ongoing: true,
            ),
          ),
        );

        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.getString("locationLatLongList");
        String? list = await preferences.getString("locationLatLongList");
        List<Map<String, dynamic>> data = list == null
            ? [
                {
                  "value":
                      "lat_${position.latitude} long_${position.longitude}",
                  "createdDate": DateTime.now().toIso8601String()
                }
              ]
            : List<Map<String, dynamic>>.from(jsonDecode(list!));
        data.add({
          "value": "lat_${position.latitude} long_${position.longitude}",
          "createdDate": DateTime.now().toIso8601String()
        });
        await preferences.setString(
            "locationLatLongList", jsonEncode(data).toString());
      }
    }
    String? device;
    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
        "device": device,
      },
    );
  });
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

checklocation(double latitude, double longitude) async {
  print("test code ");
  Preferences preferences = Preferences();
  String token = await preferences.getToken();
  int getUserID = await preferences.getUserId();
  bool result = await InternetConnectionChecker().hasConnection;
  var addlocation = <AddLocation>[];
  if (result == true) {
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
    var uri =
        await Uri.parse('http://sales.meestdrive.in/api/sales/locationSaver');
    try {
      final response = await http.post(uri, headers: headers, body: {
        "user_latitude": latitude.toString(),
        "user_longitude": longitude.toString()
      });

      final responseData = json.encode(response.body);
      print(response.body);
    } catch (e) {}
  } else {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await dbHelper.insertLocationData(position.latitude!, position.longitude!,
        DateTime.now().millisecondsSinceEpoch);
  }

  if (result == true) {
    final datalist = await dbHelper.fetchLocationData();
    if (datalist.isNotEmpty) {
      addlocation.clear();
      for (int i = 0; i < datalist.length; i++) {
        addlocation.add(AddLocation(
            latitude: datalist[i]['latitude'].toString(),
            longitude: datalist[i]['longitude'].toString()));
      }
      var uri = await Uri.parse(APIURL.UPLOAD_OFFINTERNET_LOCATION);
      var headers = {
        'user_id': '$getUserID',
        'user_token': '$token',
        'Content-Type': 'application/json'
      };
      var body = jsonEncode({
        "location_data": addlocation,
      });
      var response = await http.post(uri, headers: headers, body: body);
      await dbHelper.deleteAllLocationData();
    }
  }
}

Future<void> _messageHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');

  // FlutterRingtonePlayer.play(
  //   fromAsset: "assets/sound/beep.mp3",
  // );

  Position position = await determinePosition();
  checklocation(position.latitude, position.longitude);
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 50.0
    ..radius = 0.0
    ..progressColor = Colors.blue
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.blue
    ..textColor = Colors.black
    ..maskType = EasyLoadingMaskType.none
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  String userName = '';
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Timer.periodic(Duration(seconds: 3), (timer) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });

    super.initState();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Background message received: ${message.notification?.body}');
    // Handle background messages here
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return StreamProvider<InternetConnectionStatus>(
          initialData: InternetConnectionStatus.connected,
          create: (_) {
            return InternetConnectionChecker().onStatusChange;
          },
          child: OverlaySupport.global(
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (ctx) => Auth(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => Preferences(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => LeaveProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => PrefProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => ProfileProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => AttendanceReportProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => DashboardProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => MoreScreenProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => PaySlipProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => ProductProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => InventoryProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => MyTaskProvider(),
                ),
              ],
              child: Portal(
                child: InAppNotification(
                  child: GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onVerticalDragDown: (details) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: GetMaterialApp(
                      navigatorKey: NavigationService.navigatorKey,
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                        canvasColor: const Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'GoogleSans',
                        primarySwatch: Colors.blue,
                      ),
                      initialRoute: '/',
                      routes: {
                        '/': (_) => SplashScreen(),
                        LoginScreen.routeName: (_) => LoginScreen(),
                        DashboardScreen.routeName: (_) => DashboardScreen(),
                        EditProfileScreen.routeName: (_) => EditProfileScreen(),
                      },
                      builder: EasyLoading.init(),
                    ),
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
