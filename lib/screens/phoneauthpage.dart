import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quicktep/layoutproperty/buttonfield.dart';
import 'package:quicktep/provider/auth_provider.dart';
//import 'package:quicktep/screens/otpscreen.dart';

class PhoneAtuhPage extends StatefulWidget {
  const PhoneAtuhPage({super.key});

  @override
  State<PhoneAtuhPage> createState() => _PhoneAtuhPageState();
}

class _PhoneAtuhPageState extends State<PhoneAtuhPage> {
  final numberController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  final List<String> imageList = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQojH7krtua_s4AJLeglEUXcc0louMkI6QY9RMrwTEskDDtYyIUnG2ra-_IQpM8F912ixw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRW7j4tNHb-UzZuMVQyZLdIxDKCzlKtvOBfXQ&usqp=CAU"
  ];

  @override
  void initState() {
    super.initState();
    countryController.text = "+91";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(230),
          child: AppBar(
            title: const ListTile(
              title: Text(
                "Easy Travel",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            // backgroundColor: Colors.amber.shade200,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 2))),
              child: CarouselSlider(
                  items: imageList
                      .map((item) => Center(
                              child: Image.network(
                            item,
                            //height: 340,
                            scale: 0.3,
                            //fit: BoxFit.cover,
                          )))
                      .toList(),
                  options: CarouselOptions(
                      //enlargeFactor: 0.4,
                      viewportFraction: 1,
                      //height: MediaQuery.of(context).size.height,
                      aspectRatio: 17 / 15,
                      enableInfiniteScroll: false,
                      autoPlay: false)),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.help_outline,
                    color: Colors.black87,
                  ))
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Let's get started",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black),
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 12.0),
                  child: Text(
                    "Verify your account using OTP",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black38),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black38),
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 40,
                        child: TextField(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          showCursor: false,
                          controller: countryController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 7)),
                        ),
                      ),
                      const Text(
                        "|",
                        style: TextStyle(fontSize: 32, color: Colors.black38),
                      ),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: numberController,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 7, top: 14, bottom: 14),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(15),
            child: ReuseButton(
                onPressed: () {
                  sendPhoneNumber();
                  // if (numberController.text.isNotEmpty ||
                  //     numberController.text.length == 10) {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (_) => const OtpScreen(
                  //             verificationId: "123456",
                  //           )));
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(content: Text("Enter correct number")));
                  // }
                },
                text: "Proceed")),
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phonenumber = numberController.text.trim();
    ap.signInWithPhone(context, "+$countryController$phonenumber");
  }
}
