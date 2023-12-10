import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  bool buttonPressedCustomer = true;
  bool buttonPressedAdmin = false;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411, 899),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: const Color.fromRGBO(16, 36, 85, 1.0),
              body: Column(
                children: [
                  Expanded(
                    flex: 11,
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
                    flex: 11,
                    child: Container(
                      width: ((MediaQuery.of(context).size.width) - (35.w)),
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
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: buttonPressedCustomer
                                            ? const Color.fromRGBO(
                                                85, 38, 25, 1)
                                            : const Color.fromRGBO(
                                                177, 188, 217, 1),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        buttonPressedAdmin = false;
                                        buttonPressedCustomer = true;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.zero,
                                              bottomRight: Radius.zero,
                                              topLeft: Radius.circular(40),
                                              topRight: Radius.zero)),
                                      elevation: 0,
                                      onPrimary:
                                          const Color.fromRGBO(85, 38, 25, 1),
                                      primary: const Color.fromRGBO(
                                          177, 188, 217, 1),
                                      padding: EdgeInsets.only(
                                          bottom: 20.h,
                                          left: 30.h,
                                          right: 20.h,
                                          top: 20.h),
                                      textStyle: TextStyle(
                                        fontSize: 25.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    child: const Text("GUEST"),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: buttonPressedAdmin
                                        ? const Color.fromRGBO(85, 38, 25, 1)
                                        : const Color.fromRGBO(
                                            177, 188, 217, 1),
                                    width: 2,
                                  ))),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        buttonPressedAdmin = true;
                                        buttonPressedCustomer = false;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.zero,
                                              bottomRight: Radius.zero,
                                              topLeft: Radius.zero,
                                              topRight: Radius.circular(40))),
                                      elevation: 0,
                                      onPrimary:
                                          const Color.fromRGBO(85, 38, 25, 1),
                                      primary: const Color.fromRGBO(
                                          177, 188, 217, 1),
                                      padding: EdgeInsets.only(
                                          bottom: 20.h,
                                          left: 30.h,
                                          right: 20.h,
                                          top: 20.h),
                                      textStyle: TextStyle(
                                        fontSize: 25.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    child: const Text("VIP"),
                                  ),
                                ),
                              )
                            ],
                          ),
                          buttonPressedCustomer
                              ? CustomerFragment()
                              : AdminFragment(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: const Color.fromRGBO(16, 36, 85, 1.0),
                    ),
                  )
                ],
              ),
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
                              print("1st options");
                              Navigator.push(
                                context,
                                CupertinoPageRoute(builder: (context) => PoseListPage()),
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
                                    const Center(child: Text("first options"))),
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
                                child: const Center(
                                    child: Text("second options"))),
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
                                child:
                                    const Center(child: Text("third options"))),
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
                                child: const Center(
                                    child: Text("fourth options"))),
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
        padding: EdgeInsets.only(top:20.w ,bottom: 10.w,left:0 ,right:0 ),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 20.w, mainAxisSpacing: 20.w),
        children: [
          InkWell(
            onTap: () {
              print("1st options");
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
                const Center(child: Text("first options"))),
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
                child: const Center(
                    child: Text("second options"))),
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
                child:
                const Center(child: Text("third options"))),
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
                child: const Center(
                    child: Text("fourth options"))),
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
                child: const Center(
                    child: Text("fifth options"))),
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
                child: const Center(
                    child: Text("sixth options"))),
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
                child: const Center(
                    child: Text("seventh options"))),
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
                child: const Center(
                    child: Text("eighth options"))),
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
                child: const Center(
                    child: Text("ninth options"))),
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
                child: const Center(
                    child: Text("tenth options"))),
          ),
        ],
        ),
      ));
  }
}
