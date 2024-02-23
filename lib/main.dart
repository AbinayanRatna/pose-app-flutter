import 'dart:io';
import 'dart:ui';
import 'package:animated_notch_bottom_bar_no_border_radius/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pose_detection_app/models/pose_one_model.dart';
import 'package:pose_detection_app/pose.dart';
import 'package:pose_detection_app/poseType.dart';
import 'package:pose_detection_app/views/pose_detection_view.dart';
import 'package:pose_detection_app/views/pose_detection_view_vip.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().init(); //
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyC24YIdu2Wg65Y-nz6SnlAQPrdVLUyt8Do",
            appId: "1:908067463207:android:70c0e1218b11889eeb6e02",
            messagingSenderId: "908067463207",
            projectId: "pose-app-new",
          ),
        )
      : await Firebase.initializeApp();
  runApp(MyApp());
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
                    width: MediaQuery.of(context).size.width / 2,
                    alignment: Alignment.center,
                    child: Center(
                      child: SvgPicture.asset("assets/pose1.svg"),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Container(
                      width: ((MediaQuery.of(context).size.width) - (80.w)),
                      height: (MediaQuery.of(context).size.height),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPageVIP()),
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
  List<PosesDisplay> poseList = [
    PosesDisplay('assets/pose_new_1.jpg', 'Open arm pose',
        'The open arm pose, characterized by extending one or both arms outward, conveys confidence, warmth, and approachability in photography.'),
    PosesDisplay('assets/pose_new_2.jpg', 'Hands on head pose',
        'The Hands on Head pose, featuring hands placed on top of the head, exudes a sense of openness, relaxation, and confidence in photography.'),
    PosesDisplay('assets/pose_new_3.jpg', 'Dab pose',
        'The Dab pose, characterized by extending one arm diagonally upward while tucking the head into the opposite arm\'s crook, symbolizes exuberance and playfulness in photography.'),
    PosesDisplay('assets/pose_new_4.jpg', 'Hands on hip pose',
        'The Hands on Hip pose, with hands placed confidently on the hips, emanates assertiveness and self-assurance in photography.'),
    PosesDisplay('assets/pose_new_5.jpg', 'Upcoming',
        'Expect for more upcoming new poses soon!'),
  ];

  PoseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Double size=(MediaQuery.of(context).size.height/2) as Double;
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color.fromRGBO(19, 154, 157, 0.2),
        appBar: AppBar(
          title: const Text("Select a pose"),
          backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
        ),
        body: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 8.w),
          child: SizedBox(
            height: 520.w,
            child: ScrollSnapList(
              itemBuilder: _buildListItem,
              itemCount: poseList.length,
              itemSize: 268.w,
              onItemFocus: (index) {},
              dynamicItemSize: true,
            ),
          ),
        ));
  }

  Widget _buildListItem(BuildContext context, int index) {
    PosesDisplay posesDisplay = poseList[index];
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PoseDetectorView(),
                  settings: RouteSettings(arguments: index),
                ),
              );
            }
          case 1:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PoseDetectorView(),
                  settings: RouteSettings(arguments: index),
                ),
              );
            }
          case 2:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PoseDetectorView(),
                  settings: RouteSettings(arguments: index),
                ),
              );
            }
          case 3:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PoseDetectorView(),
                  settings: RouteSettings(arguments: index),
                ),
              );
            }
        }
      },
      child: SizedBox(
        width: 250.w,
        height: 400.w,
        child: Card(
          elevation: 12,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Column(
              children: [
                Image.asset(
                  posesDisplay.imagePath,
                  fit: BoxFit.cover,
                  width: 240.w,
                  height: 350.w,
                ),
                SizedBox(
                  height: 15.w,
                ),
                Text(
                  posesDisplay.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.w,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w),
                  child: Text(
                    posesDisplay.features,
                    style: TextStyle(
                      fontSize: 13.w,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPageVIP extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginPageVIP({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      // Return false to disable back button
      return false;
    },
    child:ScreenUtilInit(
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
                width: MediaQuery.of(context).size.width,
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
                width: ((MediaQuery.of(context).size.width) - (80.w)),
                height: (MediaQuery.of(context).size.height),
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
                                            password:
                                                passwordController.text.trim())
                                        .then((value) {
                                      Navigator.push(
                                          (context),
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GuestPageHomeVip()));
                                    }).onError((error, stackTrace) {
                                      String errorMessage = "An error occurred";
                                      if (error is FirebaseAuthException) {
                                        errorMessage =
                                            error.message ?? "Unknown error";
                                      }
                                      Fluttertoast.showToast(msg: errorMessage);
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
                                    "Padding value 2: ${EdgeInsets.only(top: 10.w)}");
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  MyApp2(),),(route) => false
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
    ),);
  }
}

class SignupPageVIP extends StatelessWidget {
  SignupPageVIP({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      // Return false to disable back button
      return false;
    },
    child: ScreenUtilInit(
      //designSize: const Size(411, 899),
      minTextAdapt: true,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height) / 7),
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
                                    "Padding value 2: ${EdgeInsets.only(top: 10.w)}");
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  MyApp2(),),(route) => false
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
                                String password =
                                    passwordController.text.trim();
                                String confirmPassword =
                                    confirmPasswordController.text.trim();

                                if (email == "" ||
                                    password == "" ||
                                    confirmPassword == "") {
                                  if (email == "") {
                                    Fluttertoast.showToast(
                                        msg: 'Email is empty!',
                                        toastLength: Toast.LENGTH_SHORT);
                                  } else if (password == "") {
                                    Fluttertoast.showToast(
                                        msg: 'Password is empty!',
                                        toastLength: Toast.LENGTH_SHORT);
                                  }
                                } else if (password.length < 8) {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Password must contain minimum 8 characters!',
                                      toastLength: Toast.LENGTH_SHORT);
                                } else if (password != confirmPassword) {
                                  Fluttertoast.showToast(
                                      msg: 'Passwords do not match!',
                                      toastLength: Toast.LENGTH_SHORT);
                                } else {
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: email, password: password)
                                      .then((value) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Signup successful. Re-login to continue",
                                        toastLength: Toast.LENGTH_SHORT);
                                    Navigator.push(
                                        (context),
                                        MaterialPageRoute(
                                            builder: (context) => MyApp()));
                                  }).onError((error, stackTrace) {
                                    String errorMessage = "An error occurred";
                                    if (error is FirebaseAuthException) {
                                      errorMessage =
                                          error.message ?? "Unknown error";
                                    }
                                    Fluttertoast.showToast(
                                        msg: errorMessage,
                                        toastLength: Toast.LENGTH_SHORT);
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
    ));
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
                MaterialPageRoute(builder: (context) => MyApp2()),
              );
            });
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: const Color.fromRGBO(19, 154, 157, 1.0),
            onPrimary: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.w, 10.w, 15.w, 10.w),
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

class GuestPageHome extends StatefulWidget {
  GuestPageHome({Key? key,}) : super(key: key);

  @override
  State<GuestPageHome> createState() => _GuestPageHomeState();
}

class _GuestPageHomeState extends State<GuestPageHome> {
  late CarouselController controller;
  int currentIndex = 0;

  @override
  void initState() {
    controller = CarouselController();
    super.initState();
  }

  final List<Widget> imageAddress = [
    Container(
      margin: EdgeInsets.only(left: 10.w),
      child: Image.asset(
        "assets/ad_1.png",
        fit: BoxFit.cover,
      ),
    ),
    Container(
      margin: EdgeInsets.only(left: 10.w),
      child: Image.asset(
        "assets/ad_2.png",
        fit: BoxFit.cover,
      ),
    ),
    Container(
      margin: EdgeInsets.only(left: 10.w),
      child: Image.asset(
        "assets/ad_3.png",
        fit: BoxFit.cover,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      // Return false to disable back button
      return false;
    },
    child:ScreenUtilInit(
      minTextAdapt: true,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                      0.1.w,
                      0.4.w,
                      0.6.w,
                      0.9.w,
                    ],
                    colors: const [
                      Color.fromRGBO(33, 160, 164, 1.0),
                      Color.fromRGBO(125, 248, 255, 1.0),
                      Color.fromRGBO(19, 154, 157, 1.0),
                      Color.fromRGBO(25, 107, 112, 1.0),
                    ],
                  )),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 75.w, left: 20.w),
                        child: Column(
                          children: [
                            Padding(
                                    padding: EdgeInsets.only(left: 7.w),
                                    child: Text(
                                      "Hello guest,",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                            Padding(
                              padding: EdgeInsets.only(top: 3.w, bottom: 8.w),
                              child: Text(
                                "Welcome to Craftie",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.w,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 65.w, left: 60.w),
                        child: InkWell(
                          onTap: () {
                            Fluttertoast.showToast(msg: "Rating button");
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(9, 88, 89, 1.0),
                            ),
                            child: const Icon(
                              Icons.star_rate_outlined,
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 65.w, left: 10.w),
                        child: InkWell(
                          onTap: () {
                            Fluttertoast.showToast(msg: "Share button");
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(9, 88, 89, 1.0),
                            ),
                            child: const Icon(
                              Icons.share_outlined,
                              // color: Color.fromRGBO(9, 75, 75, 1.0),
                              color: Color.fromRGBO(253, 253, 253, 1.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 65.w, left: 10.w),
                        child: InkWell(
                          onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MyApp(),),(route) => false
                              );

                          },
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              // color: Color.fromRGBO(76, 172, 173, 1.0),
                              color: Color.fromRGBO(9, 88, 89, 1.0),
                            ),
                            child: const Icon(
                              Icons.logout,
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
              flex: 4,
              child: Container(
                decoration: const BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: CarouselSlider(
                        carouselController: controller,
                        items: imageAddress,
                        options: CarouselOptions(
                            height: MediaQuery.of(context).size.height / 2.4.h,
                            autoPlay: true,
                            autoPlayInterval: Duration(milliseconds: 1800),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 500)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.1.w,
                    0.4.w,
                    0.6.w,
                    0.9.w,
                  ],
                  colors: const [
                    Color.fromRGBO(33, 160, 164, 1.0),
                    Color.fromRGBO(125, 248, 255, 1.0),
                    Color.fromRGBO(19, 154, 157, 1.0),
                    Color.fromRGBO(25, 107, 112, 1.0),
                  ],
                )),
                padding: EdgeInsets.fromLTRB(30.w, 10.w, 25.w, 0),
                //color: Colors.blue,
                //const Color.fromRGBO(33, 160, 164, 1.0),
                height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.height / 1.6.w),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width < 700 ? 2 : 3,
                      childAspectRatio: (1.w),
                      mainAxisSpacing: 20.w,
                      crossAxisSpacing: 20.w),
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
                            color: Color.fromRGBO(255, 255, 255, 1.0),
                            //  color: Color.fromRGBO(188, 197, 197, 1.0),
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
                                    EdgeInsets.only(top: 20.w, bottom: 10.w),
                                child: Icon(
                                  Icons.accessibility_new,
                                  color: Colors.black,
                                  size: 45.h,
                                )),
                            Center(
                                child: Text(
                              "Poses",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.w),
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
                            color: Color.fromRGBO(255, 255, 255, 1.0),
                            //color: Color.fromRGBO(188, 197, 197, 1.0),
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
                                    EdgeInsets.only(top: 20.w, bottom: 10.w),
                                child: Icon(
                                  Icons.account_circle,
                                  color: Colors.black,
                                  size: 45.h,
                                )),
                            Center(
                                child: Text(
                              "Profile",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.w),
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
                              // color: Color.fromRGBO(188, 197, 197, 1.0),
                              color: Color.fromRGBO(255, 255, 255, 1.0),
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
                                    EdgeInsets.only(top: 20.w, bottom: 10.w),
                                child: Icon(
                                  Icons.help,
                                  color: Colors.black,
                                  size: 40.h,
                                ),
                              ),
                              Center(
                                  child: Text(
                                "Help",
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
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                              //color: Color.fromRGBO(188, 197, 197, 1.0),
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
                                    EdgeInsets.only(top: 20.w, bottom: 10.w),
                                child: Icon(
                                  Icons.account_tree_outlined,
                                  color: Colors.black,
                                  size: 40.h,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class NavBarPage extends StatefulWidget {
  final int currentTab;

  NavBarPage({Key? key, this.currentTab = 0})
      : super(key: key);

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
    PoseListPage(),
    const SettingPage(),
    ProfilePage(),
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
              bottomBarWidth: MediaQuery.of(context).size.width,

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
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Guest Profile"),
          backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
        ),
        body: Container(
          decoration:
              const BoxDecoration(color: Color.fromRGBO(19, 154, 157, 0.2)),
          child: Padding(
            padding: EdgeInsets.only(top: 35.w, left: 25.w),
            child: Container(
              width: MediaQuery.of(context).size.width,
              //color: const Color.fromRGBO(255, 255, 255, 1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.w),
                        child:
                            SvgPicture.asset("assets/guest.svg", width: 150.w)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 28.w),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.w),
                              child: SvgPicture.asset("assets/vip.svg",
                                  width: 85.w)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 130.w),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NavBarPage(currentTab: 1)),
                              );
                            },
                            child: Container(
                              width: 70.w,
                              height: 70.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(19, 154, 157, 1.0),
                              ),
                              child: Icon(
                                Icons.settings,
                                color: Color.fromRGBO(255, 255, 255, 1.0),
                                size: 50.w,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 35.w, left: 25.w),
                    child: Container(
                      decoration: BoxDecoration(
                          //color: const Color.fromRGBO(142, 200, 201, 1.0),
                          color: const Color.fromRGBO(19, 154, 157, 0.4),
                          borderRadius: BorderRadius.circular(10.w)),
                      child: Padding(
                        padding: EdgeInsets.all(30.w),
                        child: Column(
                          children: [
                            Text("Please upgrade the account",
                                style: TextStyle(
                                    fontSize: 15.w,
                                    fontWeight: FontWeight.bold)),
                            Text("to unlock the following",
                                style: TextStyle(
                                    fontSize: 15.w,
                                    fontWeight: FontWeight.bold)),
                            Text("features.\n",
                                style: TextStyle(
                                    fontSize: 15.w,
                                    fontWeight: FontWeight.bold)),
                            Text("1. Audio feedback\n",
                                style: TextStyle(
                                    fontSize: 15.w,
                                    fontWeight: FontWeight.bold)),
                            Text("2. Unlimited poses",
                                style: TextStyle(
                                    fontSize: 15.w,
                                    fontWeight: FontWeight.bold)),
                            Padding(
                              padding: EdgeInsets.only(top: 10.w),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const MyApp(),),(route) => false
                                    );
                                  },
                                  child: Text("Create VIP account",
                                      style: TextStyle(
                                          fontSize: 15.w,
                                          fontWeight: FontWeight.bold))),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(19, 154, 157, 0.2),
        appBar: AppBar(
          title: const Text("Help"),
          backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height * 5,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 28.w, top: 20.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Become a VIP\n",
                        style: TextStyle(
                            fontSize: 20.w, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w, right: 30.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Join our VIP community and enjoy exclusive benefits for a nominal fee. Enhance your photography skills and access premium content by becoming a VIP member at a minimal cost. Go to Sign up page to create a VIP account. ",
                        style: TextStyle(
                            fontSize: 13.w, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 28.w, top: 20.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Pose detecting function\n",
                        style: TextStyle(
                            fontSize: 20.w, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w, right: 30.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "1. Once you're in the app, navigate to the pose selection page.\n2. Position yourself or your subject in front of the camera and align yourself as desired for the photo, ensuring that you're within the frame and visible to the camera.\n3. The pose correction feature will be automatically turned on once you turn on the camera.\n4. Follow the on-screen instructions and audio cues provided by the app.\n5. Adjust your pose in real time based on the feedback given by the app.\n6. This may involve straightening your posture, adjusting your arms, or refining your stance.\n7. Once you're satisfied with your pose and the corrections made by the app, proceed to capture the photo.",
                        style: TextStyle(
                            fontSize: 13.w, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 28.w, top: 20.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Privacy Policy\n",
                        style: TextStyle(
                            fontSize: 20.w, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.w, right: 30.w, bottom: 100.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "At Craftie,we are committed to protecting your privacy and ensuring the security of your personal information. This privacy policy outlines how we collect, use, and safeguard your data when you use our app.\nInformation We Collect:\nWe may collect personal information, such as your name, email address, or contact details, when you create an account or interact with our app.\nHow We Use Your Information:\nWe use the information we collect to provide and improve our app's functionality, personalize your experience, and communicate with you about updates or new features.Your data may also be used for analytics purposes to better understand user behavior and preferences, enabling us to optimize our services.\nData Security:\nWe take appropriate measures to protect your personal information from unauthorized access, alteration, or disclosure. This includes encryption, secure storage, and regular security audits.We do not sell, rent, or share your personal information with third parties for marketing purposes without your explicit consent.\nChildren's Privacy:\nOur app is not intended for children under the age of 13. We do not knowingly collect personal information from children under 13 years old.\nChanges to This Policy:\nWe may update this privacy policy from time to time to reflect changes in our practices or legal requirements.By using Craftie, you consent to the terms outlined in this privacy policy. If you have any questions or concerns about our privacy practices, please contact us at ratsabcreations@gmail.com\nLast updated: 1/16/2020",
                        style: TextStyle(
                            fontSize: 13.w, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("About us"),
          backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
        ),
        body: Container(
          color: Color.fromRGBO(19, 154, 157, 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  color: Color.fromRGBO(19, 154, 157, 0.2),
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.w, left: 25.w),
                    child: SvgPicture.asset(
                      "assets/abou_us.svg",
                      width: 300.w,
                    ),
                  )),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 28.w, top: 10.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Our Mission\n",
                          style: TextStyle(
                              fontSize: 20.w, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25.w, right: 30.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "To revolutionize the world of photography by providing a cutting-edge real-time pose correction app, empowering photographers of all levels to effortlessly capture flawless images during every photoshoot. We aim to redefine the standards of professional photography, enabling users to express their creativity while delivering exceptional results. We envision a world where every individual, regardless of experience, can unlock their full potential as a photographer.",
                          style: TextStyle(
                              fontSize: 13.w, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 28.w, top: 10.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "\nContact Us\n",
                          style: TextStyle(
                              fontSize: 20.w, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25.w, right: 30.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Tele.No: 0765778174\n\nEmail    :ratsabcreations@gmail.com",
                          style: TextStyle(
                              fontSize: 14.w, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GuestPageHomeVip extends StatefulWidget {
  GuestPageHomeVip({Key? key,}) : super(key: key);

  @override
  State<GuestPageHomeVip> createState() => _GuestPageHomeVipState();
}

class _GuestPageHomeVipState extends State<GuestPageHomeVip> {
  late CarouselController controller;
  int currentIndex = 0;

  @override
  void initState() {
    controller = CarouselController();
    super.initState();
  }

  final List<Widget> imageAddress = [
    Container(
      margin: EdgeInsets.only(left: 10.w),
      child: Image.asset(
        "assets/ad_1.png",
        fit: BoxFit.cover,
      ),
    ),
    Container(
      margin: EdgeInsets.only(left: 10.w),
      child: Image.asset(
        "assets/ad_2.png",
        fit: BoxFit.cover,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [
                          0.1.w,
                          0.4.w,
                          0.6.w,
                          0.9.w,
                        ],
                        colors: const [
                          Color.fromRGBO(33, 160, 164, 1.0),
                          Color.fromRGBO(125, 248, 255, 1.0),
                          Color.fromRGBO(19, 154, 157, 1.0),
                          Color.fromRGBO(25, 107, 112, 1.0),
                        ],
                      )),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 75.w, left: 18.w),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 1.w),
                              child: Text(
                                "Hello VIP,",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.w,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3.w, bottom: 8.w),
                              child: Text(
                                "Welcome to Craftie",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.w,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 65.w, left: 80.w),
                        child: InkWell(
                          onTap: () {
                            Fluttertoast.showToast(msg: "Rating button");
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(9, 88, 89, 1.0),
                            ),
                            child: const Icon(
                              Icons.star_rate_outlined,
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 65.w, left: 10.w),
                        child: InkWell(
                          onTap: () {
                            Fluttertoast.showToast(msg: "Share button");
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(9, 88, 89, 1.0),
                            ),
                            child: const Icon(
                              Icons.share_outlined,
                              // color: Color.fromRGBO(9, 75, 75, 1.0),
                              color: Color.fromRGBO(253, 253, 253, 1.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 65.w, left: 10.w),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyApp(),),(route) => false
                            );
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              // color: Color.fromRGBO(76, 172, 173, 1.0),
                              color: Color.fromRGBO(9, 88, 89, 1.0),
                            ),
                            child: const Icon(
                              Icons.logout,
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
              flex: 4,
              child: Container(
                decoration: const BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: CarouselSlider(
                        carouselController: controller,
                        items: imageAddress,
                        options: CarouselOptions(
                            height: MediaQuery.of(context).size.height / 2.4.h,
                            autoPlay: true,
                            autoPlayInterval: Duration(milliseconds: 1800),
                            autoPlayAnimationDuration:
                            const Duration(milliseconds: 500)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [
                        0.1.w,
                        0.4.w,
                        0.6.w,
                        0.9.w,
                      ],
                      colors: const [
                        Color.fromRGBO(33, 160, 164, 1.0),
                        Color.fromRGBO(125, 248, 255, 1.0),
                        Color.fromRGBO(19, 154, 157, 1.0),
                        Color.fromRGBO(25, 107, 112, 1.0),
                      ],
                    )),
                padding: EdgeInsets.fromLTRB(30.w, 10.w, 25.w, 0),
                //color: Colors.blue,
                //const Color.fromRGBO(33, 160, 164, 1.0),
                height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.height / 1.6.w),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                      MediaQuery.of(context).size.width < 700 ? 2 : 3,
                      childAspectRatio: (1.w),
                      mainAxisSpacing: 20.w,
                      crossAxisSpacing: 20.w),
                  children: [
                    InkWell(
                      onTap: () {
                        print("1st Options: Poses");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavBarPageVip(currentTab: 0)),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1.0),
                            //  color: Color.fromRGBO(188, 197, 197, 1.0),
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
                                EdgeInsets.only(top: 20.w, bottom: 10.w),
                                child: Icon(
                                  Icons.accessibility_new,
                                  color: Colors.black,
                                  size: 45.h,
                                )),
                            Center(
                                child: Text(
                                  "Poses",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 15.w),
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
                              builder: (context) => NavBarPageVip(currentTab: 2)),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1.0),
                            //color: Color.fromRGBO(188, 197, 197, 1.0),
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
                                EdgeInsets.only(top: 20.w, bottom: 10.w),
                                child: Icon(
                                  Icons.account_circle,
                                  color: Colors.black,
                                  size: 45.h,
                                )),
                            Center(
                                child: Text(
                                  "Profile",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 15.w),
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
                              builder: (context) => NavBarPageVip(currentTab: 1)),
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            // color: Color.fromRGBO(188, 197, 197, 1.0),
                              color: Color.fromRGBO(255, 255, 255, 1.0),
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
                                EdgeInsets.only(top: 20.w, bottom: 10.w),
                                child: Icon(
                                  Icons.help,
                                  color: Colors.black,
                                  size: 40.h,
                                ),
                              ),
                              Center(
                                  child: Text(
                                    "Help",
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
                              builder: (context) => NavBarPageVip(currentTab: 3)),
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                              //color: Color.fromRGBO(188, 197, 197, 1.0),
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
                                EdgeInsets.only(top: 20.w, bottom: 10.w),
                                child: Icon(
                                  Icons.account_tree_outlined,
                                  color: Colors.black,
                                  size: 40.h,
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

class NavBarPageVip extends StatefulWidget {
  final int currentTab;

  NavBarPageVip({Key? key, this.currentTab = 0})
      : super(key: key);

  @override
  State<NavBarPageVip> createState() => _NavBarPageVipState();
}

class _NavBarPageVipState extends State<NavBarPageVip> {
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
    PoseListPageVip(),
    const SettingPage(),
    ProfilePageVip(),
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
        bottomBarWidth: MediaQuery.of(context).size.width,

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

class PoseListPageVip extends StatelessWidget {
  List<PosesDisplay> poseList = [
    PosesDisplay('assets/pose_new_1.jpg', 'Open arm pose',
        'The open arm pose, characterized by extending one or both arms outward, conveys confidence, warmth, and approachability in photography.'),
    PosesDisplay('assets/pose_new_2.jpg', 'Hands on head pose',
        'The Hands on Head pose, featuring hands placed on top of the head, exudes a sense of openness, relaxation, and confidence in photography.'),
    PosesDisplay('assets/pose_new_3.jpg', 'Dab pose',
        'The Dab pose, characterized by extending one arm diagonally upward while tucking the head into the opposite arm\'s crook, symbolizes exuberance and playfulness in photography.'),
    PosesDisplay('assets/pose_new_4.jpg', 'Hands on hip pose',
        'The Hands on Hip pose, with hands placed confidently on the hips, emanates assertiveness and self-assurance in photography.'),
    PosesDisplay('assets/pose_new_5.jpg', 'Upcoming',
        'Expect for more upcoming new poses soon!'),
  ];

  PoseListPageVip({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(19, 154, 157, 0.2),
        appBar: AppBar(
          title: const Text("Select a pose"),
          backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
        ),
        body: Padding(
          padding:
          EdgeInsets.only(top: MediaQuery.of(context).size.height / 8.w),
          child: SizedBox(
            height: 520.w,
            child: ScrollSnapList(
              itemBuilder: _buildListItem,
              itemCount: poseList.length,
              itemSize: 268.w,
              onItemFocus: (index) {},
              dynamicItemSize: true,
            ),
          ),
        ));
  }

  Widget _buildListItem(BuildContext context, int index) {
    PosesDisplay posesDisplay = poseList[index];
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PoseDetectorViewVip(),
                  settings: RouteSettings(arguments: index),
                ),
              );
            }
          case 1:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PoseDetectorViewVip(),
                  settings: RouteSettings(arguments: index),
                ),
              );
            }
          case 2:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PoseDetectorViewVip(),
                  settings: RouteSettings(arguments: index),
                ),
              );
            }
          case 3:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PoseDetectorViewVip(),
                  settings: RouteSettings(arguments: index),
                ),
              );
            }
        }
      },
      child: SizedBox(
        width: 250.w,
        height: 400.w,
        child: Card(
          elevation: 12,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Column(
              children: [
                Image.asset(
                  posesDisplay.imagePath,
                  fit: BoxFit.cover,
                  width: 240.w,
                  height: 350.w,
                ),
                SizedBox(
                  height: 15.w,
                ),
                Text(
                  posesDisplay.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.w,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w),
                  child: Text(
                    posesDisplay.features,
                    style: TextStyle(
                      fontSize: 13.w,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfilePageVip extends StatelessWidget {
  ProfilePageVip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Vip Profile"),
          backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
        ),
        body: Container(
          decoration:
          const BoxDecoration(color: Color.fromRGBO(19, 154, 157, 0.2)),
          child: Padding(
            padding: EdgeInsets.only(top: 35.w, left: 25.w),
            child: Container(
              width: MediaQuery.of(context).size.width,
              //color: const Color.fromRGBO(255, 255, 255, 1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.w),
                        child:
                        SvgPicture.asset("assets/vip.svg", width: 150.w)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 28.w),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.w),
                              child: SvgPicture.asset("assets/guest.svg",
                                  width: 85.w)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 130.w),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NavBarPage(currentTab: 1)),
                              );
                            },
                            child: Container(
                              width: 70.w,
                              height: 70.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(19, 154, 157, 1.0),
                              ),
                              child: Icon(
                                Icons.settings,
                                color: Color.fromRGBO(255, 255, 255, 1.0),
                                size: 50.w,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 35.w, left: 5.w,right:25.w),
                    child: Container(
                      decoration: BoxDecoration(
                        //color: const Color.fromRGBO(142, 200, 201, 1.0),
                          color: const Color.fromRGBO(19, 154, 157, 0.4),
                          borderRadius: BorderRadius.circular(10.w)),
                      child: Padding(
                        padding: EdgeInsets.all(30.w),
                        child: Column(
                          children: [
                            Text("Congrats. You have upgraded the account. Now, You have access to the following features.\n",
                                style: TextStyle(
                                    fontSize: 15.w,
                                    fontWeight: FontWeight.bold)),
                            Text("1. Audio feedback\n",
                                style: TextStyle(
                                    fontSize: 15.w,
                                    fontWeight: FontWeight.bold)),
                            Text("2. Unlimited poses",
                                style: TextStyle(
                                    fontSize: 15.w,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}