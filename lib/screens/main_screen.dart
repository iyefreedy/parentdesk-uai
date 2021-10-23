import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:parentdesk_uai/constants.dart';
import 'package:parentdesk_uai/models/pengumuman.dart';
import 'package:parentdesk_uai/screens/pengumuman_screen.dart';
import 'package:parentdesk_uai/services/api.dart';
import 'package:parentdesk_uai/utils/helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {

  static List<String> images = [
    SLIDE_1_IMAGE,
    SLIDE_2_IMAGE,
  ];

  late Future<List<Pengumuman>> _futureListPengumuman;
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.onMessage.listen((event) {
      displayNotification(event.data);
    });

    _futureListPengumuman = getListPengumuman().catchError((e) => alert(e.toString(), context));
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android: android, iOS: iOS);
    _flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: selectNotification);
    _firebaseMessaging.requestPermission();

    _firebaseMessaging.getToken().then((String? token) {
      print("firebase token =" + token!);
    });
  }

  void selectNotification(String? s) {
    debugPrint(s.toString());
  }

  Future displayNotification(Map<String, dynamic> message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channelid', 'flutterfcm',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics
    );
    await _flutterLocalNotificationsPlugin.show(
      0,
      message['notification']['title'],
      message['notification']['body'],
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text(
          'ParentDesk UAI',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: ListView(
        children: [
          ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                onScrolled: null,
                autoPlayCurve: Curves.easeInOut,
                viewportFraction: 1.0
              ),
              items: images.map((e) => Image.asset(e)).toList(),
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                InkWell(
                  onTap: () => showDialogLogout(),
                  child: Row(
                    children: [
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                        ),
                      ),
                      Icon(Icons.power_settings_new)
                    ],
                  ),
                )
              ],
            ),
          ),
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 8.0,
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            children: [
              InkWell(
                onTap: () => Navigator.pushNamed(context, '/biodata'),
                child: Image.asset(
                  BIODATA_ICON,
                  width: 20.0,
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, '/perkuliahan'),
                child: Image.asset(
                    PERKULIAHAN_ICON
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, '/keuangan'),
                child: Image.asset(
                  KEUANGAN_ICON
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, '/kuliah-pengganti'),
                child: Image.asset(
                  JADWAL_PENGGANTI_ICON
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, '/jadwal-ujian'),
                child: Image.asset(
                  JADWAL_UJIAN_ICON
                ),
              ),
              InkWell(
                  onTap: () => Navigator.pushNamed(context, '/nilai'),
                child: Image.asset(
                    NILAI_ICON
                )
              ),
            ],
          ),
          SizedBox(height: 10,),
          Container(
            height: 20,
            color: Colors.grey[200],
          ),
          Padding(
            padding: const EdgeInsets.all(
                20.0
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pengumuman',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/pengumuman-list'),
                  child: Text(
                    'Lihat Semua',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14.0
                    ),
                  ),
                )
              ],
            ),
          ),
          FutureBuilder<List<Pengumuman>>(
            future: _futureListPengumuman,
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                snapshot.data!.sort((a, b) => DateTime.parse(b.tanggal).compareTo(DateTime.parse(a.tanggal)));
                print(snapshot.data![0].tanggal);
                return Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10, right: 10),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(color: Colors.black),
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.isEmpty ?
                    0 :
                    snapshot.data!.length > 5 ? 5 : snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (__) => new PengumumanScreen(
                                    id: snapshot.data![index].id
                                )
                            )
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  backgroundColor: Colors.amber,
                                  child: Text(
                                    snapshot.data![index].pengirim[0].toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 7,
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index].judul,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins",
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data![index].tanggal,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins",
                                              fontSize: 10.0,
                                            ),
                                          )
                                        ],
                                      )
                                  )
                              )
                            ],
                          )
                      );
                    },
                  ),
                );
              } else if(snapshot.hasError) {
                return Container(
                  child: Text('${snapshot.error.toString()}'),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          )
        ]
      )
    );
  }

  Widget listPengumuman(List<Pengumuman> pengumumanList) {
    return Padding(
      padding: EdgeInsets.only(left: 20, bottom: 10, right: 10),
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(color: Colors.black),
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: pengumumanList.isEmpty ?
        0 :
        pengumumanList.length > 5 ? 5 : pengumumanList.length,
        itemBuilder: (BuildContext context, int index) {
          print(pengumumanList);
          return InkWell(
              onTap: () {
                Navigator.push(context, new MaterialPageRoute(
                    builder: (__) => new PengumumanScreen(
                        id: pengumumanList[index].id
                    )
                )
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Text(
                        pengumumanList[index].pengirim[0].toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 7,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                pengumumanList[index].judul,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                pengumumanList[index].tanggal,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 10.0,
                                ),
                              )
                            ],
                          )
                      )
                  )
                ],
              )
          );
        },
      ),
    );
  }

  Future<void> showDialogLogout() async {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Perhatian'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Apakah anda ingin logout ?'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Ya'),
              onPressed: () {
                logout(context);
              },
            ),
            TextButton(
              child: const Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }
}
