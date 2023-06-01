import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:quicktep/layoutproperty/buttonfield.dart';
//import 'package:quicktep/layoutproperty/showsnackbar.dart';
import 'package:quicktep/screens/creaateprofile.dart';
import 'package:quicktep/screens/locationpermission.dart';
import '../provider/auth_provider.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();

  String? otpCode;
  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(250),
          child: AppBar(
            flexibleSpace: ClipRect(
                child: Container(
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.blueAccent)),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/Enter OTP-amico.png"))),
            )),
            //backgroundColor: Colors.a,
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.help_outline)),
              TextButton(onPressed: () {}, child: const Text("Help"))
            ],
          )),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
            child: isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                    child: Center(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              "Phone Verification",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black),
                            ),
                          ),
                          const Text(
                            "Enter the OTP send your phone number",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black38),
                          ),
                          const SizedBox(height: 20),
                          Pinput(
                            length: 6,
                            showCursor: false,
                            defaultPinTheme: PinTheme(
                                width: 40,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2, color: Colors.black38)),
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            onSubmitted: (value) {
                              setState(() {
                                otpCode = value;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: ReuseButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LocationPermissionScreen()));
              // if (otpCode != null) {
              //   // verifyOtp(context, otpCode!);

              // } else {
              //   showSnackBars(context, "Enter 6-digite OTP number");
              // }
            },
            text: "Verify"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          onPressed: () {},
          child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage("assets/images/Directions-amico.png"))),
          )),
    );
  }

  void verifyOtp(BuildContext context, String otpnum) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    ap.verifyOtp(
        context: context,
        verificationId: widget.verificationId,
        userOtp: otpnum,
        onSuccess: () {
          ap.checkExistingUser().then((value) async {
            if (value == true) {
            } else {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LocationPermissionScreen()),
                  (route) => false);
            }
          });
        });
  }
}
