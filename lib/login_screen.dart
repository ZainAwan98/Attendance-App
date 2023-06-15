import 'package:attendance_app/user_dashboard.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'LoginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  submitCredentials() {
    // if (formkey.currentState!.validate()) {
    if (emailcontroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Enter your Email')));
    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(emailcontroller.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid Email')));
    } else if (passwordcontroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter your password ')));
    } else {
      Navigator.pushNamed(context, UserDashboard.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    var layout = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          flexibleSpace: Container(),
          shadowColor: Colors.white,
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(layout.size.width * 2),
              bottomRight: Radius.elliptical(
                  layout.size.width * 0.01, layout.size.width * 0.8),
            ),
          ),
          bottom: PreferredSize(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: layout.size.height * 0.02),
              ],
            ),
            preferredSize: Size.fromHeight(layout.size.height * 0.02),
          ),
          automaticallyImplyLeading: false,
          // flexibleSpace: Container(
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //         colors: [Colors.grey, Colors.black],
          //         begin: Alignment.bottomLeft,
          //         end: Alignment.topRight),
          //   ),
          // ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: layout.size.height * 0.04,
                ),
                Material(
                  type: MaterialType.card,
                  elevation: 10,
                  shadowColor: Colors.white,
                  child: Image(
                    height: layout.size.height * 0.15,
                    width: layout.size.height * 0.15,
                    image: const AssetImage('assets/profile.jpg'),
                  ),
                ),
                SizedBox(
                  height: layout.size.height * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.all(layout.size.height * 0.02),
                  child: Material(
                    shadowColor: Colors.white,
                    color: Colors.white,
                    elevation: 20,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: layout.devicePixelRatio * 3),
                      child: TextFormField(
                        controller: emailcontroller,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            size: layout.size.width * 0.08,
                          ),
                          hintText: 'Enter your Email',
                          hintStyle: const TextStyle(
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                          filled: true,
                          contentPadding:
                              EdgeInsets.all(layout.devicePixelRatio * 7),
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: layout.size.height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.all(layout.size.height * 0.02),
                  child: Material(
                    shadowColor: Colors.white,
                    color: Colors.white,
                    elevation: 20,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: layout.devicePixelRatio * 3),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordcontroller,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.password,
                            size: layout.size.width * 0.08,
                          ),
                          hintText: 'Enter your Password',
                          hintStyle: const TextStyle(
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                          filled: true,
                          contentPadding:
                              EdgeInsets.all(layout.devicePixelRatio * 7),
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: layout.size.height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.all(layout.size.height * 0.02),
                  child: Column(
                    children: [
                      SizedBox(
                        height: layout.size.height * 0.05,
                        width: layout.size.width * 0.35,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.white,
                            primary:
                                Colors.blueAccent, //background color of button
                            side: BorderSide(
                                width: layout.size.width * 0.01,
                                color:
                                    Colors.blueAccent), //border width and color
                            elevation: 3, //elevation of button
                            shape: const RoundedRectangleBorder(
                                //to set border radius to button
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          // shape: const RoundedRectangleBorder(
                          //     borderRadius:
                          //         BorderRadius.all(Radius.elliptical(10, 0))),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              letterSpacing: 2.0,
                            ),
                          ),
                          onPressed: submitCredentials,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // getData() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   em = preferences.getString('emailcontroller');
  //   ps = preferences.getString('Pass');
  //   if (emailcontroller.text == em && password.text == ps) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Success')));
  //     Navigator.pushNamed(context, '/C');
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Failed')));
  //   }
  // }
}
