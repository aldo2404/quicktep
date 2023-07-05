import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quicktep/layoutproperty/buttonfield.dart';
import 'package:quicktep/layoutproperty/showsnackbar.dart';
import 'package:quicktep/model/usermodel.dart';
import 'package:quicktep/provider/auth_provider.dart';
import 'package:quicktep/screens/locationpermission.dart';

class CreateUserProfile extends StatefulWidget {
  const CreateUserProfile({super.key});

  @override
  State<CreateUserProfile> createState() => _CreateUserProfileState();
}

class _CreateUserProfileState extends State<CreateUserProfile> {
  List<Map<String, dynamic>> genderList = [
    {"gender": "Male", "gendericon": "Icons.male_outlined"},
    {"gender": "Female", "gendericon": "Icons.female_outlined"},
    {"gender": "Other", "gendericon": "Icons.transgender_outlined"}
  ];
  List<Map<String, IconData>> gender = [
    {
      "Male": Icons.male_outlined,
      "Female": Icons.female_outlined,
      "other": Icons.transgender_outlined
    }
  ];
  final nameController = TextEditingController();
  final codeController = TextEditingController();

  bool genderSelected = false;
  bool _infoSelected = false;
  bool _codeSelected = false;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: AppBar(
              backgroundColor: Colors.blue.shade100,
              foregroundColor: Colors.black,
              actions: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.help_outline))
              ],
              title: const Text(
                "Create your profile",
                style: TextStyle(color: Colors.black),
              ),
              titleTextStyle:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            )),
        body: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  minimum: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: "Enter Full Name",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                borderSide: BorderSide()),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Gender",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 50,
                      //   child: ListView.builder(
                      //       padding: EdgeInsets.only(right: 10),
                      //       shrinkWrap: true,
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount: genderList.length,
                      //       itemBuilder: (context, index) {
                      //         return InkWell(
                      //           onTap: () {
                      //             setState(() {
                      //               genderSelected = !genderSelected;
                      //             });
                      //           },
                      //           child: Container(
                      //             height: 45,
                      //             width: 100,
                      //             decoration: BoxDecoration(
                      //                 border: Border.all(
                      //                     color: genderSelected
                      //                         ? Colors.green.shade300
                      //                         : Colors.black45),
                      //                 borderRadius: const BorderRadius.all(
                      //                     Radius.circular(8))),
                      //             child: Row(
                      //               //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //               children: [
                      //                 //Icon(genderList[index]["gendericon"]),
                      //                 // const SizedBox(width: 10),
                      //                 Text(
                      //                   genderList[index]["gender"],
                      //                   style: const TextStyle(
                      //                       fontWeight: FontWeight.w500),
                      //                 ),
                      //                 const SizedBox(width: 10),
                      //               ],
                      //             ),
                      //           ),
                      //         );
                      //       }),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            genderBox("Male", Icons.male_outlined),
                            genderBox("Female", Icons.female_outlined),
                            genderBox("Other", Icons.transgender_outlined)
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            visualDensity: VisualDensity.compact,
                            activeColor: Colors.green.shade200,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2)),
                            checkColor: Colors.green.shade800,
                            side: BorderSide(
                                width: 2, color: Colors.green.shade900),
                            value: _infoSelected,
                            onChanged: (value) {
                              setState(() {
                                _infoSelected = !_infoSelected;
                              });
                            },
                          ),
                          const Expanded(
                              child: ListTile(
                            title: Text("Receive important updates on WhatsApp",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                "Receive updates on latest offers & transactions"),
                          ))
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            visualDensity: VisualDensity.compact,
                            activeColor: Colors.green.shade200,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2)),
                            checkColor: Colors.green.shade800,
                            side: BorderSide(
                                width: 2, color: Colors.green.shade900),
                            value: _codeSelected,
                            onChanged: (value) {
                              setState(() {
                                _codeSelected = !_codeSelected;
                              });
                            },
                          ),
                          const Expanded(
                            child: ListTile(
                              title: Text("I have a referral code",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                      _codeSelected == true
                          ? SizedBox(
                              width: 200,
                              child: TextField(
                                controller: codeController,
                                decoration: const InputDecoration(
                                    hintText: "Enter code",
                                    hintStyle:
                                        TextStyle(color: Colors.black26)),
                              ),
                            )
                          : const SizedBox(width: 0),
                    ],
                  )),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ReuseButton(
              onPressed: () {
                storeData();
              },
              text: "Proceed"),
        ),
      ),
    );
  }

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
        name: nameController.text.trim(), gender: "", phonenumber: "", uid: "");
    // ignore: unnecessary_null_comparison
    if (nameController != null) {
      ap.saveUserDataToFirebase(
          context: context,
          onSuccess: () {
            ap.saveUserDataToSP().then((value) => ap.setSignIn().then((value) =>
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LocationPermissionScreen()),
                    (route) => false)));
          },
          userModel: userModel);
    } else {
      showSnackBars(context, "Please Enter the name");
    }
  }

  genderBox(String text, IconData icon) {
    return InkWell(
      onTap: () {
        print(genderList[0]["gendericon"]);
        setState(() {
          genderSelected = !genderSelected;
        });
      },
      child: Container(
        height: 45,
        width: 110,
        decoration: BoxDecoration(
            border: Border.all(
                color: genderSelected ? Colors.green.shade300 : Colors.black45),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icon),
            //const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
