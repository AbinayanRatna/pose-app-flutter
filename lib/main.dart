import 'dart:io';
import 'dart:ui';

import 'package:animated_notch_bottom_bar_no_border_radius/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:bouncing_button/bouncing_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pose_detection_app/models/pose_one_model.dart';
import 'package:pose_detection_app/poseType.dart';
import 'package:pose_detection_app/views/pose_detection_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC24YIdu2Wg65Y-nz6SnlAQPrdVLUyt8Do",
      appId: "1:908067463207:android:70c0e1218b11889eeb6e02",
      messagingSenderId: "908067463207",
      projectId: "pose-app-new",
    ),
  ) : await Firebase.initializeApp();
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
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
            body: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    color: const Color.fromRGBO(255, 255, 255, 1.0),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2,
                    alignment: Alignment.center,
                    child: Center(
                      child: SvgPicture.asset("assets/pose1.svg"),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Container(
                      width: ((MediaQuery
                          .of(context)
                          .size
                          .width) - (80.w)),
                      height: (MediaQuery
                          .of(context)
                          .size
                          .height),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 1.0),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.w),
                            topRight: Radius.circular(40.w),
                            bottomLeft: Radius.circular(40.w),
                            bottomRight: Radius.circular(40.w),
                          )),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 25.w, 0, 15.w),
                              child: Text(
                                "Welcome Buddy",
                                style: TextStyle(
                                  color: const Color.fromRGBO(16, 36, 85, 1.0),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18.w,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10.w, 0, 20.w),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GuestPageHome()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        15.w), // <-- Radius
                                  ),
                                  elevation: 0,
                                  primary:
                                  const Color.fromRGBO(19, 154, 157, 1.0),
                                  onPrimary: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "Enter as Guest",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.w,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10.w, 0, 20.w),
                              child: ElevatedButton(
                                onPressed: () {
                                  //   print("Padding value 1: ${EdgeInsets.only(top: 10.w)}");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                         LoginPageVIP()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        15.w), // <-- Radius
                                  ),
                                  elevation: 0,
                                  primary:
                                  const Color.fromRGBO(19, 154, 157, 1.0),
                                  onPrimary: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      22.w, 10.w, 22.w, 10.w),
                                  child: Text(
                                    "Login as VIP",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.w,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10.w, 0, 20.w),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPageVIP()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        15.w), // <-- Radius
                                  ),
                                  elevation: 0,
                                  primary:
                                  const Color.fromRGBO(19, 154, 157, 1.0),
                                  onPrimary: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      10.w, 10.w, 10.w, 10.w),
                                  child: Text(
                                    "Signup for VIP",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.w,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: const Color.fromRGBO(255, 255, 255, 1.0),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class PoseListPage extends StatelessWidget {
  const PoseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text("Select a pose"),
          backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 20.w, bottom: 10.w, left: 0, right: 0),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 20.w),
            children: [
              InkWell(
                onTap: () {
                  print("1st options");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PoseDetectorView()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.w),
                      topLeft: Radius.circular(20.w),
                      bottomRight: Radius.circular(20.w),
                      bottomLeft: Radius.circular(20.w),
                    ),
                  ),
                  margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                  child: const Center(
                    child: Text("first pose"),
                  ),
                ),
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
                      bottomLeft: Radius.circular(20.w),
                    ),
                  ),
                  margin: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                  child: const Center(
                    child: Text("second pose"),
                  ),
                ),
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginPageVIP({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //designSize: const Size(411, 899),
      minTextAdapt: true,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
        body: Column(
          children: [
            Expanded(flex: 2, child: Container()),
            Expanded(
              flex: 10,
              child: Container(
                color: const Color.fromRGBO(255, 255, 255, 1.0),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                alignment: Alignment.center,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/pose2.svg",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                width: ((MediaQuery
                    .of(context)
                    .size
                    .width) - (80.w)),
                height: (MediaQuery
                    .of(context)
                    .size
                    .height),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1.0),
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
                          "Email",
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
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter the email"),
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
                        child: TextField(
                          controller: passwordController,
                          decoration: const InputDecoration(
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
                                padding: EdgeInsets.fromLTRB(23.w, 0, 20.w, 0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                        email: emailController.text.trim(),
                                        password: passwordController.text
                                            .trim()).then((value) {
                                              Fluttertoast.showToast(msg: "Signing successful");
                                      Navigator.push(
                                          (context),
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentPage()));
                                    }).onError((error, stackTrace) {
                                      Fluttertoast.showToast(
                                          msg: "error signing account");
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary:
                                    const Color.fromRGBO(19, 154, 157, 1.0),
                                    onPrimary: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        10.w, 10.w, 10.w, 10.w),
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
                                print(
                                    "Padding value 2: ${EdgeInsets.only(
                                        top: 10.w)}");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp2()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary:
                                const Color.fromRGBO(19, 154, 157, 1.0),
                                onPrimary: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                EdgeInsets.fromLTRB(15.w, 10.w, 15.w, 10.w),
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.w),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Does not have an account ?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 15.w)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPageVIP()),
                                  );
                                },
                                child: Text(" Sign up",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: const Color.fromRGBO(
                                            19, 154, 157, 1.0),
                                        fontSize: 15.w)),
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: const Color.fromRGBO(255, 255, 255, 1.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SignupPageVIP extends StatelessWidget {
  SignupPageVIP({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //designSize: const Size(411, 899),
      minTextAdapt: true,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(
                  top: (MediaQuery
                      .of(context)
                      .size
                      .height) / 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: const Color.fromRGBO(85, 38, 25, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 25.w,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(bottom: 4.w, top: 20.w, left: 30.w),
                    child: Text(
                      "Email",
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
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter the email"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.w, top: 4.w, left: 30.w),
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
                    child: TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter the username"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.w, top: 4.w, left: 30.w),
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
                    child: TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter the password"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.w, top: 4.w, left: 30.w),
                    child: Text(
                      "Confirm Password",
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
                    child: TextField(
                      controller: confirmPasswordController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Confirm the password"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.w),
                    child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                print(
                                    "Padding value 2: ${EdgeInsets.only(
                                        top: 10.w)}");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp2()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary:
                                const Color.fromRGBO(19, 154, 157, 1.0),
                                onPrimary: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                EdgeInsets.fromLTRB(15.w, 10.w, 15.w, 10.w),
                                child: Text(
                                  "Back",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.w,
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                String email = emailController.text.trim();
                                String username =
                                usernameController.text.trim();
                                String password =
                                passwordController.text.trim();
                                String confirmPassword =
                                confirmPasswordController.text.trim();

                                if (email == "" ||
                                    username == "" ||
                                    password == "" ||
                                    confirmPassword == "") {
                                  if (email == "") {
                                    Fluttertoast.showToast(
                                        msg: 'Email is empty!');
                                  } else if (username == "") {
                                    Fluttertoast.showToast(
                                        msg: 'Username is empty!');
                                  } else if (password == "") {
                                    Fluttertoast.showToast(
                                        msg: 'Password is empty!');
                                  }
                                } else if (password.length < 8) {
                                  Fluttertoast.showToast(
                                      msg:
                                      'Password must contain minimum 8 characters!');
                                } else if (password != confirmPassword) {
                                  Fluttertoast.showToast(
                                      msg: 'Passwords do not match!');
                                } else {
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                      email: email, password: password)
                                      .then((value) {
                                    Fluttertoast.showToast(
                                        msg: "success in creating account");
                                    Navigator.push(
                                        (context),
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PaymentPage()));
                                  }).onError((error, stackTrace) {
                                    Fluttertoast.showToast(
                                        msg: "error creating account");
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary:
                                const Color.fromRGBO(19, 154, 157, 1.0),
                                onPrimary: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 10.w),
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.w,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.w),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account ?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 15.w)),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPageVIP()),
                              );
                            },
                            child: Text(" Log in",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color:
                                    const Color.fromRGBO(19, 154, 157, 1.0),
                                    fontSize: 15.w)),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              Fluttertoast.showToast(msg: "Signed out");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyApp2()),
              );
            });
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary:
            const Color.fromRGBO(19, 154, 157, 1.0),
            onPrimary: Colors.white,
          ),
          child: Padding(
            padding:
            EdgeInsets.fromLTRB(15.w, 10.w, 15.w, 10.w),
            child: Text(
              "Logout",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GuestPageHome extends StatelessWidget {
  GuestPageHome({super.key});

  final List<String> numbers = [
    "ad1",
    "ad2",
    "ad3",
    "ad4",
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Welcome Home"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
                icon: const Icon(Icons.logout))
          ],
          backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1.0),
                  borderRadius: BorderRadius.only(
                    //bottomLeft: Radius.circular(20.w),
                    bottomRight: Radius.circular(60.w),
                    bottomLeft: Radius.circular(60.w),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30.w, left: 20.w),
                      child: Text(
                        "Hello (Username),",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.w,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.w),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 2.5.w,
                      child: ListView.builder(
                        // This next line does the trick.
                          scrollDirection: Axis.horizontal,
                          itemCount: numbers.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.8.w,
                              child: Card(
                                margin: EdgeInsets.only(
                                    left: 5.w, top: 40.w, right: 10.w),
                                color: Colors.blue,
                                child: Container(
                                  child: Center(
                                      child: Text(
                                        numbers[index].toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 36.w),
                                      )),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.fromLTRB(20.w, 40.w, 20.w, 0),
                //color: Colors.blue,
                height: MediaQuery
                    .of(context)
                    .size
                    .height -
                    (MediaQuery
                        .of(context)
                        .size
                        .height / 1.6.w),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                      MediaQuery
                          .of(context)
                          .size
                          .width < 700 ? 3 : 3,
                      childAspectRatio: (1.w),
                      mainAxisSpacing: 30.w,
                      crossAxisSpacing: 30.w),
                  children: [
                    InkWell(
                      onTap: () {
                        print("1st Options: Poses");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavBarPage(currentTab: 0)),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(188, 197, 197, 1.0),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.w),
                                topLeft: Radius.circular(20.w),
                                bottomRight: Radius.circular(20.w),
                                bottomLeft: Radius.circular(20.w))),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          children: [
                            Padding(
                                padding:
                                EdgeInsets.only(top: 10.w, bottom: 10.w),
                                child: Icon(
                                  Icons.accessibility_new,
                                  color: Colors.black,
                                )),
                            Center(
                                child: Text(
                                  "Poses",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.w),
                                )),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print("2nd options:profile ");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavBarPage(currentTab: 2)),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(188, 197, 197, 1.0),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.w),
                                topLeft: Radius.circular(20.w),
                                bottomRight: Radius.circular(20.w),
                                bottomLeft: Radius.circular(20.w))),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          children: [
                            Padding(
                                padding:
                                EdgeInsets.only(top: 10.w, bottom: 10.w),
                                child: Icon(
                                  Icons.account_circle,
                                  color: Colors.black,
                                )),
                            Center(
                                child: Text(
                                  "Profile",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.w),
                                )),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print("3rd options: Settings");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavBarPage(currentTab: 1)),
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(188, 197, 197, 1.0),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.w),
                                  topLeft: Radius.circular(20.w),
                                  bottomRight: Radius.circular(20.w),
                                  bottomLeft: Radius.circular(20.w))),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                EdgeInsets.only(top: 10.w, bottom: 10.w),
                                child: Icon(
                                  Icons.settings,
                                  color: Colors.black,
                                ),
                              ),
                              Center(
                                  child: Text(
                                    "Settings",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.w),
                                  )),
                            ],
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        print("4th options: about app");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavBarPage(currentTab: 3)),
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(188, 197, 197, 1.0),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.w),
                                  topLeft: Radius.circular(20.w),
                                  bottomRight: Radius.circular(20.w),
                                  bottomLeft: Radius.circular(20.w))),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                EdgeInsets.only(top: 10.w, bottom: 10.w),
                                child: Icon(
                                  Icons.account_tree_outlined,
                                  color: Colors.black,
                                ),
                              ),
                              Center(
                                  child: Text(
                                    "About us",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.w),
                                  )),
                            ],
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        print("5rd options: Share");
                        /*
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NavBarPage(currentTab: 1)),
                        );

                         */
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(188, 197, 197, 1.0),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.w),
                                  topLeft: Radius.circular(20.w),
                                  bottomRight: Radius.circular(20.w),
                                  bottomLeft: Radius.circular(20.w))),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                EdgeInsets.only(top: 10.w, bottom: 10.w),
                                child: Icon(
                                  Icons.share_outlined,
                                  color: Colors.black,
                                ),
                              ),
                              Center(
                                  child: Text(
                                    "Share us",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.w),
                                  )),
                            ],
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        print("6rd options: Rateus");
                        /*
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NavBarPage(currentTab: 1)),
                        );

                         */
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(188, 197, 197, 1.0),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.w),
                                  topLeft: Radius.circular(20.w),
                                  bottomRight: Radius.circular(20.w),
                                  bottomLeft: Radius.circular(20.w))),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                EdgeInsets.only(top: 10.w, bottom: 10.w),
                                child: Icon(
                                  Icons.star_rate_outlined,
                                  color: Colors.black,
                                ),
                              ),
                              Center(
                                  child: Text(
                                    "Rate us",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.w),
                                  )),
                            ],
                          )),
                    ),
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

class NavBarPage extends StatefulWidget {
  final int currentTab;

  NavBarPage({Key? key, this.currentTab = 0}) : super(key: key);

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  late final PageController _pageController;
  late final NotchBottomBarController _controller;
  late final int maxCount = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.currentTab);
    _controller = NotchBottomBarController(index: widget.currentTab);
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const PoseListPage(),
    const SettingPage(),
    const ProfilePage(),
    const AboutUs(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(

        /// Provide NotchBottomBarController
        notchBottomBarController: _controller,
        color: const Color.fromRGBO(19, 154, 157, 1.0),
        showLabel: false,
        notchColor: const Color.fromRGBO(5, 59, 61, 1.0),

        /// restart app if you change removeMargins
        removeMargins: true,
        bottomBarWidth: MediaQuery
            .of(context)
            .size
            .width,

        durationInMilliSeconds: 300,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.accessibility_new,
              color: Colors.white,
            ),
            activeItem: Icon(
              Icons.accessibility_new,
              color: const Color.fromRGBO(255, 255, 255, 1.0),
            ),
            itemLabel: 'Person',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            activeItem: Icon(
              Icons.settings,
              color: const Color.fromRGBO(255, 255, 255, 1.0),
            ),
            itemLabel: 'Settings',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.person,
              color: Colors.white,
            ),
            activeItem: Icon(
              Icons.person,
              color: const Color.fromRGBO(255, 255, 255, 1.0),
            ),
            itemLabel: 'personal',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.account_tree_outlined,
              color: Colors.white,
            ),
            activeItem: Icon(
              Icons.account_tree_outlined,
              color: const Color.fromRGBO(255, 255, 255, 1.0),
            ),
            itemLabel: 'Page 5',
          ),
        ],
        onTap: (index) {
          /// perform action on tab change and to update pages you can update pages without pages
          _pageController.jumpToPage(index);
        },
      )
          : null,
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
        ),
        body: Container(
            color: const Color.fromRGBO(255, 255, 255, 1.0),
            child: const Center(child: Text('Profile Page'))));
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
        ),
        body: Container(
            color: const Color.fromRGBO(255, 255, 255, 1.0),
            child: const Center(child: Text('Setting Page'))));
  }
}

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About us"),
        backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
      ),
      body: Container(
          color: const Color.fromRGBO(255, 255, 255, 1.0),
          child: const Center(child: Text('About Us'))),
    );
  }
}

class PoseListPageList extends StatefulWidget {
  @override
  State<PoseListPageList> createState() => _PoseListPageList();
}

class _PoseListPageList extends State<PoseListPageList> {
  List<PoseType> poseList = [
    PoseType("assets/pose_1.png", "Pose 1", "Try this pose.It is a good pose."),
    PoseType("assets/pose_2.png", "Pose 2", "Try this pose.It is a good pose."),
    PoseType("assets/pose_3.png", "Pose 3", "Try this pose.It is a good pose."),
    PoseType("assets/pose_4.png", "Pose 4", "Try this pose.It is a good pose."),
  ];
  int currentpage = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Select a pose")),
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: Container(
                key: ValueKey<String>(poseList[currentpage].imagePath),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(poseList[currentpage].imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 15,
                    sigmaY: 15,
                  ),
                  child: Container(color: Colors.black.withOpacity(0.2)),
                )),
          ),
          FractionallySizedBox(
            heightFactor: 0.55,
            child: PageView.builder(
              itemCount: poseList.length,
              onPageChanged: (int page) {
                setState(() {
                  currentpage = page;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  color: Colors.white, // White background color
                  child: Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.5, // Adjust the width factor as needed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.3,
                            margin: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(poseList[index].imagePath),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            poseList[index].title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            poseList[index].description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
