import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gramsuvidha/blocs/application_bloc.dart';
import 'package:gramsuvidha/utility/choose_language.dart';
import 'package:gramsuvidha/utility/localization_file.dart';
import 'package:gramsuvidha/utility/utilityColor.dart';
import 'package:gramsuvidha/view/activityPostDetailScreen.dart';
import 'package:gramsuvidha/view/activityform.dart';
import 'package:gramsuvidha/view/add_user_screen.dart';
import 'package:gramsuvidha/view/complaints_form_screen.dart';
import 'package:gramsuvidha/view/complaints_screen.dart';
import 'package:gramsuvidha/view/decisions_proceedings_screen.dart';
import 'package:gramsuvidha/view/enquiry_form_screen.dart';
import 'package:gramsuvidha/view/enquiry_screen.dart';
import 'package:gramsuvidha/view/essential_service_screen.dart';
import 'package:gramsuvidha/view/family_member_screen.dart';
import 'package:gramsuvidha/view/family_screen.dart';
import 'package:gramsuvidha/view/fcmpage.dart';
import 'package:gramsuvidha/view/googleMapScreen.dart';
import 'package:gramsuvidha/view/grampanchayat_body_info_screen.dart';
import 'package:gramsuvidha/view/gramsuvidha_dashboard_screen.dart';
import 'package:gramsuvidha/view/notificationDialog.dart';
import 'package:gramsuvidha/view/profile_screen.dart';
import 'package:gramsuvidha/view/registration_otp_screen.dart';
import 'package:gramsuvidha/view/registration_screen.dart';
import 'package:gramsuvidha/view/share_app_screen.dart';
import 'package:gramsuvidha/view/splash_screen.dart';
import 'package:gramsuvidha/view/splash_screen_start.dart';
import 'package:gramsuvidha/view/update_profile_screen.dart';
import 'package:gramsuvidha/view/verification_screen.dart';
import 'package:gramsuvidha/view/work_history.dart';
import 'package:gramsuvidha/view_modal/post_otp_vm.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notificationservice/local_notification_service.dart';

String? tokenId;
DateTime currentDate = DateTime.now();
String title = '';
String body = '';
String date = '';

AudioPlayer player = AudioPlayer(playerId: 'uni');

Future<void> backgroundHandler(RemoteMessage message) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('title', message.notification!.title!);
  prefs.setString('body', message.notification!.body!);

  final SendPort? sendStopBeep =
      IsolateNameServer.lookupPortByName('stop_beep_send_port');
  if (sendStopBeep == null) {
    ReceivePort portStopBeep = ReceivePort();
    IsolateNameServer.registerPortWithName(
        portStopBeep.sendPort, 'stop_beep_send_port');

    portStopBeep.listen((dynamic data) async {
      await player.stop();
      IsolateNameServer.removePortNameMapping('stop_beep_send_port');
    });
    player.play(AssetSource('ringing.mp3'));
    player.setReleaseMode(ReleaseMode.loop);
  }

  // Music.instance.playLoop('ringing.mp3');
/*  await player.play(AssetSource('music.mp3'));
  Timer(const Duration(seconds: 10), () {
    player.stop();
  });*/
}

Future<bool?> getValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('login');
}

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  FirebaseMessaging.instance.getToken().then((token) => {
        tokenId = token,
    print('########$tokenId*********')
      });

  ///language selection
  var lang = selectLanguage.read('language');
  print(lang);

  ///App work only in portrait mode
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: splashBackgroundColor, // status bar color
  ));
  getValue().then((value) {
    print('########$value*********');
    print('########${userIdValue.read('userId')}*********');
/*    /// 2. This method only call when App in forground it mean app must be opened
      FirebaseMessaging.onMessage.listen(
        (message) async {
          // audioPlayerState == AudioPlayerState.PLAYING?pauseMusic():playMusic();
          // AndroidNotification? android = message.notification?.android;
          print("FirebaseMessaging.onMessage.listen");
          if (message.notification != null) {
            NotificationManager.handleNotificationMsg(message, context)
            player.play(AssetSource('ringing.mp3'));
            print(message.notification!.title);
            print(message.notification!.body);
            print("message.data11 ${message.data}");
            LocalNotificationService.createanddisplaynotification(message);

            title = message.notification!.title!;
            body = message.notification!.body!;
          }
        },
      );*/

/*    /// 3. This method only call when App in background and not terminated(not closed)
      FirebaseMessaging.onMessageOpenedApp.listen(

        (message) async {

          print("FirebaseMessaging.onMessageOpenedApp.listen");
          if (message.notification != null) {

            print(message.notification!.title);
            print(message.notification!.body);

            // print("message.data22 ${message.data['_id']}");
            // if (message.data['_id'] != null) {}
            Get.to(() => FcmPage(
                  // id: message.data['_id'],
                  player: player,
                  title: message.notification!.title,
                  body: message.notification!.body,
                  date: currentDate,
                ));
          }
        },
      );*/

    runApp(ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,

        ///Localization configuration

        translations: LocalLanguageString(),
        locale: (lang == 'English')
            ? const Locale('en', "US")
            : (lang == 'Marathi')
                ? const Locale('mr', "IN")
                : (lang == 'Hindi')
                    ? const Locale('hi', "IN")
                    : const Locale('en', "US"),

        initialRoute: value != null ? '/gramSuvidhaDashboardScreen' : '/',
        // initialRoute: '/notificationDialog',
        getPages: [
          GetPage(name: '/', page: () => const SplashScreenStart()),
          GetPage(name: '/splashscreen', page: () => const SplashScreen()),
          GetPage(
              name: '/registrationOtp',
              page: () => const RegistrationOtpScreen()),
          GetPage(
              name: '/verificationScreen',
              page: () => const VerificationScreen()),
          GetPage(
              name: '/gramSuvidhaDashboardScreen',
              page: () => const GramsuvidhaDashboardScreen()),
          GetPage(
              name: '/fcmPage',
              page: () => FcmPage(
                    player: player,
                  )),
          GetPage(
              name: '/registrationScreen',
              page: () => const RegistrationScreen()),
          GetPage(
              name: '/enquiryScreen',
              page: () => const EnquiryServiceRequestsScreen()),
          GetPage(
              name: '/complaintsScreen', page: () => const ComplaintsScreen()),
          GetPage(
              name: '/decisionsProceedingsScreen',
              page: () => const DecisionsProceedingsScreen()),
          GetPage(name: '/profileScreen', page: () => ProfileScreen()),
          GetPage(
              name: '/familyMemberScreen',
              page: () => const FamilyMemberScreen()),
          GetPage(
              name: '/essentialServicesScreen',
              page: () => const EssentialServicesScreen()),
          GetPage(
              name: '/grampanchayatBodyInfoScreen',
              page: () => const GrampachayatBodyInfoScreen()),
          GetPage(
              name: '/enquiryFormScreen',
              page: () => const EnquiryFormScreen()),
          GetPage(
              name: '/complaintsFormScreen',
              page: () => const ComplaintsFormScreen()),
          GetPage(name: '/addUserScreen', page: () => const AddUserScreen()),
          GetPage(name: '/shareAppScreen', page: () => const ShareAppScreen()),
          GetPage(
              name: '/addFamilyMemberScreen',
              page: () => const AddFamilyMemberScreen()),
          GetPage(
              name: '/chooseLanguage',
              page: () => const ChooseLangugeAlertDialog()),
          GetPage(
              name: '/notificationDialog',
              page: () => const NotificationDialog()),
          GetPage(name: '/activityScreen', page: () => ActivityForms()),
          GetPage(name: '/workHistory', page: () => const WorkHistory()),
          GetPage(
              name: '/googleMapScreen', page: () => const GoogleMapScreen()),
          GetPage(
              name: '/updateProfile', page: () => const UpdateProfileScreen()),
          GetPage(
              name: '/activityPostDetailScreen',
              page: () => const ActivityPostDetailScreen()),
          // GetPage(name: '/imageZoomPage', page: ()=> const ImageZoomPage())
        ],
      ),
    ));
  });
}
