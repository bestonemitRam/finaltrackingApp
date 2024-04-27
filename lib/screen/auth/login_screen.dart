import 'dart:ui';
import 'package:bmitserp/model/auth.dart';
import 'package:bmitserp/screen/dashboard/dashboard_screen.dart';
import 'package:bmitserp/widget/buttonborder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  @override
  State<StatefulWidget> createState() => loginScreenState();
}

class loginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _form.currentState!.dispose();
    super.dispose();
  }

  var _isLoading = false;
  bool validateField(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  validateValue() {
    final value = _form.currentState!.validate();
    if (value) {
      loginUser();
    }
  }

  /// Loader Screen
  void loginUser() async {
    setState(() {
      _isLoading = true;
      EasyLoading.show(
          status: 'Signing in..', maskType: EasyLoadingMaskType.black);
    });

    try {
      final response = await Provider.of<Auth>(context, listen: false)
          .login(_usernameController.text, _passwordController.text);

      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.message)));

      Navigator.of(context)
          .pushNamedAndRemoveUntil(DashboardScreen.routeName, (route) => false);
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }

    setState(() {
      _isLoading = false;
      EasyLoading.dismiss(animation: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Container(
            decoration: backgroundDecoration(),
            child: IgnorePointer(
              ignoring: _isLoading,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: SizedBox(
                          width: 180,
                          height: 120,
                          child: Image.asset(
                            'assets/icons/logo_bnw.png',
                          ),
                        ),
                      ),
                      gaps(20),
                      Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      gaps(20),
                      textHeading('Employee Code'),
                      gaps(10),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (!validateField(value!)) {
                            return "Empty Field";
                          }
                          return null;
                        },
                        controller: _usernameController,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person, color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.white24,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(10))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(10))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(10))),
                        ),
                      ),
                      gaps(10),
                      textHeading('Password'),
                      gaps(10),
                      TextFormField(
                        obscureText: _obscureText,
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (!validateField(value!)) {
                            return "Empty Field";
                          }
                          return null;
                        },
                        controller: _passwordController,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.white24,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(10))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(10))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(10))),
                          suffixIcon: InkWell(
                            onTap: _toggle,
                            child: Icon(
                              _obscureText
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              size: 15.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      gaps(30),

                      ///click on Login Button Action
                      button(),
                      gaps(20),

                      /// create Forget password option
                      // Center(
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       openBrowserTab();
                      //     },
                      //     child: Text(
                      //         textAlign: TextAlign.left,
                      //         style: TextStyle(color: Colors.white),
                      //         'Forget Password'),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///MARK:- openBrowserTab Function
  openBrowserTab() async {
    await FlutterWebBrowser.openWebPage(
      url: "https://attendance.cyclonenepal.com/password/reset",
      customTabsOptions: const CustomTabsOptions(
        colorScheme: CustomTabsColorScheme.dark,
        shareState: CustomTabsShareState.on,
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: true,
      ),
      safariVCOptions: const SafariViewControllerOptions(
        barCollapsingEnabled: true,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        modalPresentationCapturesStatusBarAppearance: true,
      ),
    );
  }

  BoxDecoration backgroundDecoration() {
    return const BoxDecoration(
        image: DecorationImage(
      colorFilter: ColorFilter.mode(Colors.blueGrey, BlendMode.softLight),
      image: AssetImage(
        "assets/images/login.jpg",
      ),
      fit: BoxFit.cover,
    ));
  }

  Widget gaps(double value) {
    return SizedBox(
      height: value,
    );
  }

  Widget textHeading(String value) {
    return Text(
        textAlign: TextAlign.left,
        style: const TextStyle(color: Colors.white),
        value);
  }

  ///MARK: - Login Button customization Design with Widget button()
  Widget button() {
    // print("inside the login Click");
    return Container(
      width: MediaQuery.of(context).size.width,
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: HexColor("#036eb7"),
            padding: EdgeInsets.zero,
            shape: ButtonBorder(),
          ),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            validateValue();
          },
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }
}
