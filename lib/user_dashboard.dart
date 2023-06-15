import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class UserDashboard extends StatefulWidget {
  static const routeName = 'UserDashboard';
  const UserDashboard({Key? key}) : super(key: key);

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  Duration _duration = Duration();

  Timer? timer;

  // var _checkedintime = DateTime.now();
  // var _checkedoutime = DateTime.now();
  var _seconds = 0;
  var _minutes = 0;
  var _hours = 0;
  // void _checkInTime() {
  //   _checkedintime = DateTime.now();
  // }

  void dutyTimerStart() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      addTime();
    });
  }

  void addTime() {
    const incrementbyone = 1;

    setState(() {
      _seconds = (_duration.inSeconds.remainder(60) + incrementbyone);
      if (_seconds == 60) {
        _minutes = (_duration.inMinutes.remainder(60) + incrementbyone);
      }

      _duration = Duration(seconds: _seconds, minutes: _minutes, hours: _hours);
      if (_minutes == 1) {
        _hours = (_duration.inHours + incrementbyone);
      }
    });
  }

  // void _checkOutime() {
  //   var _checkedoutime = DateTime.now();
  // }

  ImagePicker _picker = ImagePicker();
  XFile? _image;

  imagePermission() async {
    print('im in');
    var status = await Permission.camera.status;
    if (status.isGranted) {
      PermissionStatus _permissionStatus = await Permission.camera.request();
    }
  }

  Future pickImageFromCamera() async {
    await Permission.camera.request();
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  Future pickImageFromGallery() async {
    XFile? image = (await _picker.pickImage(source: ImageSource.gallery));
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var layout = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Dashboard'),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              SizedBox(height: layout.size.width * 0.04),
              InkWell(
                onTap: () {},
                child: CircleAvatar(
                  radius: 80,
                  child: ClipOval(
                    child: (_image != null)
                        ? Image.file(
                            File(_image!.path),
                          )
                        : Image.asset('assets/profile.jpg'),
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
              _image != null
                  ? const Text('')
                  : Card(
                      child: ListTile(
                        leading: const Icon(Icons.image),
                        title: const Text('Select Image From Gallery'),
                        onTap: () {
                          pickImageFromGallery();
                        },
                      ),
                    ),
              _image != null
                  ? const Text('')
                  : Card(
                      child: ListTile(
                        leading: const Icon(Icons.image),
                        title: const Text('Select Image From Camera'),
                        onTap: () {
                          pickImageFromCamera();
                        },
                      ),
                    ),
              Padding(
                padding: EdgeInsets.all(layout.devicePixelRatio * 7),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: layout.devicePixelRatio * 7,
                    ),
                    SizedBox(
                      width: layout.size.width * 0.04,
                    ),
                    const Text(
                      ' Ahmed Ali',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(layout.devicePixelRatio * 7),
                child: Row(
                  children: [
                    Icon(
                      Icons.email,
                      size: layout.devicePixelRatio * 7,
                    ),
                    SizedBox(
                      width: layout.size.width * 0.04,
                    ),
                    const Text(
                      ' Ahmed@Blssol.com',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              height: layout.size.height * 0.03,
            ),
            CircleAvatar(
              radius: 80,
              child: ClipOval(
                child: (_image != null)
                    ? Image.file(
                        File(_image!.path),
                      )
                    : Image.asset('assets/profile.jpg'),
              ),
              backgroundColor: Colors.transparent,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  layout.size.width * 0.2, 0, layout.size.width * 0.2, 0),
              child: const Material(
                color: Colors.grey,
                child: Center(
                    child: Text(
                  'Employee Name: ABC',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                )),
              ),
            ),
            SizedBox(
              height: layout.size.height * 0.03,
            ),
            const Card(
              color: Colors.grey,
              child: Center(
                  child: Text(
                'Checked In At',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Text(
                    '$_hours',
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
                SizedBox(
                  width: layout.size.width * 0.04,
                ),
                Card(
                  child: Text(
                    '$_minutes',
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
                SizedBox(
                  width: layout.size.width * 0.04,
                ),
                Card(
                  child: Text(
                    '$_seconds',
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Hrs'),
                SizedBox(
                  width: layout.size.width * 0.055,
                ),
                const Text('Min'),
                SizedBox(
                  width: layout.size.width * 0.055,
                ),
                const Text('Sec'),
              ],
            ),
            SizedBox(
              height: layout.size.height * 0.03,
            ),
            const Card(
              color: Colors.grey,
              child: Center(
                  child: Text(
                'Working Hours',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Card(
                  child: Text(
                    'a',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                SizedBox(
                  width: layout.size.width * 0.04,
                ),
                const Card(
                  child: Text(
                    'a',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                SizedBox(
                  width: layout.size.width * 0.04,
                ),
                const Card(
                  child: Text(
                    'a',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Hrs'),
                SizedBox(
                  width: layout.size.width * 0.055,
                ),
                const Text('Min'),
                SizedBox(
                  width: layout.size.width * 0.055,
                ),
                const Text('Sec'),
              ],
            ),
            const Card(
              color: Colors.grey,
              child: Center(
                  child: Text(
                'Checked Out At',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Card(
                  child: Text(
                    'a',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                SizedBox(
                  width: layout.size.width * 0.04,
                ),
                const Card(
                  child: Text(
                    'a',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                SizedBox(
                  width: layout.size.width * 0.04,
                ),
                const Card(
                  child: Text(
                    'a',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Hrs'),
                SizedBox(
                  width: layout.size.width * 0.055,
                ),
                const Text('Min'),
                SizedBox(
                  width: layout.size.width * 0.055,
                ),
                const Text('Sec'),
              ],
            ),
            SizedBox(
              height: layout.size.height * 0.04,
            ),
            Padding(
              padding: EdgeInsets.all(
                layout.size.height * 0.01,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
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
                          "CheckIn",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            letterSpacing: 2.0,
                          ),
                        ),
                        onPressed: () {
                          dutyTimerStart();
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
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
                          "Break",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            letterSpacing: 2.0,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
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
                          "CheckOut",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            letterSpacing: 2.0,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
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
