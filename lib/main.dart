import 'package:animated_notch_bottom_bar_no_border_radius/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pose_detection_app/models/pose_one_model.dart';
import 'package:pose_detection_app/views/pose_detection_view.dart';

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
                    width: MediaQuery.of(context).size.width,
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
                                  borderRadius:
                                      BorderRadius.circular(15.w), // <-- Radius
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
                                          const LoginPageVIP()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(15.w), // <-- Radius
                                ),
                                elevation: 0,
                                primary:
                                    const Color.fromRGBO(19, 154, 157, 1.0),
                                onPrimary: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(22.w, 10.w, 22.w, 10.w),
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
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(15.w), // <-- Radius
                                ),
                                elevation: 0,
                                primary:
                                    const Color.fromRGBO(19, 154, 157, 1.0),
                                onPrimary: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 10.w),
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
  const LoginPageVIP({super.key});

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
                                padding: EdgeInsets.fromLTRB(23.w, 0, 20.w, 0),
                                child: ElevatedButton(
                                  onPressed: () {},
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
                                Navigator.pop(context);
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
                      )
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
        backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.6.w,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1.0),
                  borderRadius: BorderRadius.only(
                    //bottomLeft: Radius.circular(20.w),
                    bottomRight: Radius.circular(60.w),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 70.w, left: 20.w),
                      child: Text(
                        "Welcome (Username),",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.w,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3.w,
                      child: ListView.builder(
                          // This next line does the trick.
                          scrollDirection: Axis.horizontal,
                          itemCount: numbers.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.8.w,
                              child: Card(
                                margin: EdgeInsets.only(
                                    left: 15.w, top: 40.w, right: 15.w),
                                color: Colors.blue,
                                child: Container(
                                  child: Center(
                                      child: Text(
                                    numbers[index].toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 36.w),
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
            Container(
              padding: EdgeInsets.fromLTRB(20.w, 30.w, 20.w, 0),
              //color: Colors.blue,
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.height / 1.6.w),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width < 700 ? 3 : 3,
                    childAspectRatio: (1.w),
                    mainAxisSpacing: 30.w,
                    crossAxisSpacing: 30.w),
                children: [
                  InkWell(
                    onTap: () {
                      print("1st Options: Poses");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NavBarPage(currentTab: 0)),
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
                            padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
                            child: Icon(Icons.accessibility_new,color: Colors.black,)
                          ),
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
                        MaterialPageRoute(builder: (context) => NavBarPage(currentTab: 2)),
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
                            padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
                            child: Icon(Icons.account_circle,color: Colors.black,)
                          ),
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
                        MaterialPageRoute(builder: (context) => NavBarPage(currentTab: 1)),
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
                              child: Icon(Icons.settings,color: Colors.black,),
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
                        MaterialPageRoute(builder: (context) => NavBarPage(currentTab: 3)),
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
                              child: Icon(Icons.account_tree_outlined,color: Colors.black,),
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
                              child: Icon(Icons.share_outlined,color: Colors.black,),
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
                              child: Icon(Icons.star_rate_outlined,color: Colors.black,),
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
  late final

  int maxCount = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();

  }

  @override
  void initState(){
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
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Profile"),backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),),
    body:Container(
        color: const Color.fromRGBO(255, 255, 255, 1.0), child: const Center(child: Text('Profile Page'))));
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Settings"),backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),),
    body:Container(
        color: const Color.fromRGBO(255, 255, 255, 1.0), child: const Center(child: Text('Setting Page'))));
  }
}

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About us"),backgroundColor: const Color.fromRGBO(19, 154, 157, 1.0),),
      body: Container(
          color: const Color.fromRGBO(255, 255, 255, 1.0), child: const Center(child: Text('About Us'))),
    );
  }
}
