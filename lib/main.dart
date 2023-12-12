import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pose_detection_app/models/pose_one_model.dart';
import 'package:pose_detection_app/views/pose_detection_view.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(MyApp());
}

class AdminFragment extends StatelessWidget {
  const AdminFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.w, top: 20.w, left: 30.w),
                child: Text(
                  "Username",
                  style: TextStyle(
                    color: const Color.fromRGBO(85, 38, 25, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.w,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 10.w, top: 10.w, left: 30.w, right: 30.w),
                child: const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter the username"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.w, top: 10.w, left: 30.w),
                child: Text(
                  "Password",
                  style: TextStyle(
                    color: const Color.fromRGBO(85, 38, 25, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.w,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 10.w, top: 10.w, left: 30.w, right: 30.w),
                child: const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter the password"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.w),
                child: Center(
                  child: BouncingButton(
                    onPressed: () {},
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: const Color.fromRGBO(85, 38, 25, 1),
                        onPrimary: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}

class CustomerFragment extends StatelessWidget {
  const CustomerFragment({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30.w, bottom: 20.w),
                  child: Text(
                    "Hey ! ",
                    style: TextStyle(
                      color: const Color.fromRGBO(16, 36, 85, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 40.w,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 35.w, bottom: 20.w),
                  child: Text(
                    "Capture now",
                    style: TextStyle(
                      color: const Color.fromRGBO(16, 36, 85, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 30.w,
                    ),
                  ),
                ),
              ],
            ),
            CupertinoButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => GuestPageOne()),
                );
              },
              child: SvgPicture.asset(
                "assets/circled_right.svg",
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PoseDetector(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: MyApp2()),
    );
  }
}

class MyApp2 extends StatefulWidget {
  MyApp2({super.key});

  @override
  State<MyApp2> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp2> {
  int currentIndex = 0;
  bool buttonPressedCustomer = false;
  bool buttonPressedAdmin = false;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        //designSize: const Size(411, 899),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return Scaffold(
            backgroundColor: const Color.fromRGBO(16, 36, 85, 1.0),
            body: Column(
              children: [
                Expanded(
                  flex: 9,
                  child: Container(
                    color: const Color.fromRGBO(16, 36, 85, 1.0),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: SvgPicture.asset(
                        "assets/camera.svg",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Container(
                      width: ((MediaQuery.of(context).size.width) - (80.w)),
                      height: (MediaQuery.of(context).size.height),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(177, 188, 217, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.w),
                            topRight: Radius.circular(40.w),
                            bottomLeft: Radius.circular(40.w),
                            bottomRight: Radius.circular(40.w),
                          )),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20.w, 0, 20.w),
                            child: Text(
                              "Welcome",
                              style: TextStyle(
                                color: const Color.fromRGBO(16, 36, 85, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: 35.w,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20.w, 0, 20.w),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => GuestPageOne()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: const Color.fromRGBO(85, 38, 25, 1),
                                onPrimary: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "Enter as Guest",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.w, 0, 20.w),
                            child: ElevatedButton(
                              onPressed: () {
                                print("Padding value 1: ${EdgeInsets.only(top: 10.w)}");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPageVIP()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: const Color.fromRGBO(85, 38, 25, 1),
                                onPrimary: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(22.w, 10.w, 22.w, 10.w),
                                child: Text(
                                  "Login as VIP",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.w, 0, 20.w),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: const Color.fromRGBO(85, 38, 25, 1),
                                onPrimary: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 10.w),
                                child: Text(
                                  "Signup for VIP",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: const Color.fromRGBO(16, 36, 85, 1.0),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class GuestPageOne extends StatelessWidget {
  GuestPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(color: Colors.deepPurple),
                )),
            Expanded(
              flex: 9,
              child: Container(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 30.w, top: 10.w, right: 0, bottom: 10.w),
                        child: Text(
                          "Select an option",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.w,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                MediaQuery.of(context).size.width < 700 ? 2 : 4,
                            mainAxisSpacing: 20.w,
                            crossAxisSpacing: 20.w),
                        children: [
                          InkWell(
                            onTap: () {
                              print("1st Options: Poses");
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => PoseListPage()),
                              );
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.w),
                                        topLeft: Radius.circular(20.w),
                                        bottomRight: Radius.circular(20.w),
                                        bottomLeft: Radius.circular(20.w))),
                                margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                                child:
                                    const Center(child: Text("Poses"))),
                          ),
                          InkWell(
                            onTap: () {
                              print("2nd options:profile ");
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.w),
                                        topLeft: Radius.circular(20.w),
                                        bottomRight: Radius.circular(20.w),
                                        bottomLeft: Radius.circular(20.w))),
                                margin: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                                child: const Center(
                                    child: Text("Profile"))),
                          ),
                          InkWell(
                            onTap: () {
                              print("3rd options: Settings");
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.deepOrangeAccent,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.w),
                                        topLeft: Radius.circular(20.w),
                                        bottomRight: Radius.circular(20.w),
                                        bottomLeft: Radius.circular(20.w))),
                                margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                                child:
                                    const Center(child: Text("Settings"))),
                          ),
                          InkWell(
                            onTap: () {
                              print("4th options: About this app");
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.w),
                                        topLeft: Radius.circular(20.w),
                                        bottomRight: Radius.circular(20.w),
                                        bottomLeft: Radius.circular(20.w))),
                                margin: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                                child: const Center(
                                    child: Text("Read me"))),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PoseListPage extends StatelessWidget {
  const PoseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: 20.w, bottom: 10.w, left: 0, right: 0),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 20.w, mainAxisSpacing: 20.w),
        children: [
          InkWell(
            onTap: () {
              print("1st options");
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => PoseDetectorView()),
              );
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.w),
                        topLeft: Radius.circular(20.w),
                        bottomRight: Radius.circular(20.w),
                        bottomLeft: Radius.circular(20.w))),
                margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                child: const Center(child: Text("first pose"))),
          ),
          InkWell(
            onTap: () {
              print("2nd options");
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.w),
                        topLeft: Radius.circular(20.w),
                        bottomRight: Radius.circular(20.w),
                        bottomLeft: Radius.circular(20.w))),
                margin: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                child: const Center(child: Text("second pose"))),
          ),
          InkWell(
            onTap: () {
              print("3rd options");
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.w),
                        topLeft: Radius.circular(20.w),
                        bottomRight: Radius.circular(20.w),
                        bottomLeft: Radius.circular(20.w))),
                margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                child: const Center(child: Text("third pose"))),
          ),
          InkWell(
            onTap: () {
              print("4th options");
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.w),
                        topLeft: Radius.circular(20.w),
                        bottomRight: Radius.circular(20.w),
                        bottomLeft: Radius.circular(20.w))),
                margin: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                child: const Center(child: Text("fourth pose"))),
          ),
          InkWell(
            onTap: () {
              print("4th options");
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.w),
                        topLeft: Radius.circular(20.w),
                        bottomRight: Radius.circular(20.w),
                        bottomLeft: Radius.circular(20.w))),
                margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                child: const Center(child: Text("fifth pose"))),
          ),
          InkWell(
            onTap: () {
              print("4th options");
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.w),
                        topLeft: Radius.circular(20.w),
                        bottomRight: Radius.circular(20.w),
                        bottomLeft: Radius.circular(20.w))),
                margin: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                child: const Center(child: Text("sixth pose"))),
          ),
          InkWell(
            onTap: () {
              print("4th options");
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.w),
                        topLeft: Radius.circular(20.w),
                        bottomRight: Radius.circular(20.w),
                        bottomLeft: Radius.circular(20.w))),
                margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                child: const Center(child: Text("seventh pose"))),
          ),
          InkWell(
            onTap: () {
              print("4th options");
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.w),
                        topLeft: Radius.circular(20.w),
                        bottomRight: Radius.circular(20.w),
                        bottomLeft: Radius.circular(20.w))),
                margin: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                child: const Center(child: Text("eighth pose"))),
          ),
          InkWell(
            onTap: () {
              print("4th options");
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.w),
                        topLeft: Radius.circular(20.w),
                        bottomRight: Radius.circular(20.w),
                        bottomLeft: Radius.circular(20.w))),
                margin: EdgeInsets.fromLTRB(20.w, 0, 0, 20.w),
                child: const Center(child: Text("ninth pose"))),
          ),
          InkWell(
            onTap: () {
              print("4th options");
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.w),
                        topLeft: Radius.circular(20.w),
                        bottomRight: Radius.circular(20.w),
                        bottomLeft: Radius.circular(20.w))),
                margin: EdgeInsets.fromLTRB(0, 0, 20.w, 20.w),
                child: const Center(child: Text("tenth pose"))),
          ),
        ],
      ),
    ));
  }
}

class LoginPageVIP extends StatelessWidget {
  const LoginPageVIP({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //designSize: const Size(411, 899),
      minTextAdapt: true,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(16, 36, 85, 1.0),
        body: Column(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                color: const Color.fromRGBO(16, 36, 85, 1.0),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: SvgPicture.asset(
                    "assets/camera.svg",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                width: ((MediaQuery.of(context).size.width) - (80.w)),
                height: (MediaQuery.of(context).size.height),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(177, 188, 217, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.w),
                      topRight: Radius.circular(40.w),
                      bottomLeft: Radius.circular(40.w),
                      bottomRight: Radius.circular(40.w),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: 4.w, top: 20.w, left: 30.w),
                        child: Text(
                          "Username",
                          style: TextStyle(
                            color: const Color.fromRGBO(85, 38, 25, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 20.w,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 10.w, top: 4.w, left: 30.w, right: 30.w),
                        child: const TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter the username"),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: 4.w, top: 4.w, left: 30.w),
                        child: Text(
                          "Password",
                          style: TextStyle(
                            color: const Color.fromRGBO(85, 38, 25, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 20.w,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 10.w, top: 4.w, left: 30.w, right: 30.w),
                        child: const TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter the password"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.w),
                        child: Center(
                          child: Row(children: [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(25.w,0,20.w,0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: const Color.fromRGBO(85, 38, 25, 1),
                                    onPrimary: Colors.white,
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.fromLTRB(10.w,10.w,10.w,10.w),
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print("Padding value 2: ${EdgeInsets.only(top: 10.w)}");
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: const Color.fromRGBO(85, 38, 25, 1),
                                onPrimary: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(15.w,10.w,15.w,10.w),
                                child: Text(
                                  "Back",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.w,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: const Color.fromRGBO(16, 36, 85, 1.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
