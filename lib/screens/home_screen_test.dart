import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:voyageur_app/planning/planning_screen.dart';
import 'package:voyageur_app/provider/sign_in_provider.dart';
import 'package:voyageur_app/screens/login_screen.dart';
import 'package:voyageur_app/utils/next_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  bool scanning = false;

  Future<void> getData() async {
    final sp = context.read<SignInProvider>();
    await sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // change read to watch!!!!
    final sp = context.watch<SignInProvider>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage("${sp.imageUrl}"),
              radius: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Welcome ${sp.name}",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${sp.email}",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${sp.uid}",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("PROVIDER:"),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "${sp.provider}".toUpperCase(),
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                // Check camera permission status
                var status = await Permission.camera.status;
                if (status.isDenied) {
                  // Request camera permission
                  status = await Permission.camera.request();
                }

                if (status.isGranted) {
                  // Navigate to QR scanner screen
                  String? qrResult = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Scaffold(
                          appBar: AppBar(
                            title: const Text(
                              'Scan your code',
                              style: TextStyle(
                                color: Color.fromARGB(255, 38, 6, 39),
                              ),
                            ),
                            backgroundColor: Color.fromARGB(255, 207, 207, 219),
                          ),
                          body: QRView(
                            key: qrKey,
                            onQRViewCreated: (controller) {
                              setState(() {
                                this.controller = controller;
                              });
                              controller.scannedDataStream.listen((scanData) {
                                if (!scanning) {
                                  setState(() {
                                    scanning = true;
                                  });
                                  controller.pauseCamera();
                                  Navigator.pop(context, scanData.code);
                                }
                              });
                            },
                            overlay: QrScannerOverlayShape(
                              borderColor:
                                  Theme.of(context).colorScheme.secondary,
                              borderRadius: 10,
                              borderLength: 30,
                              borderWidth: 10,
                              cutOutSize:
                                  MediaQuery.of(context).size.width * 0.8,
                            ),
                          ),
                        );
                      },
                    ),
                  );

                  if (qrResult != null) {
                    nextScreenReplace(context, PlanningScreen());
                  }
                } else {
                  // Permission not granted, show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Camera permission is required to scan QR codes'),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: const Text(
                "Scan your Code",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            /*const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  sp.userSignOut();
                  nextScreenReplace(context, PlanningScreen());
                },
                child: const Text("Start your trip !",
                    style: TextStyle(
                      color: Colors.white,
                    ))),*/
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  sp.userSignOut();
                  nextScreenReplace(context, const LoginScreen());
                },
                child: const Text("SIGNOUT",
                    style: TextStyle(
                      color: Colors.white,
                    )))
          ],
        ),
      ),
    );
  }
}
