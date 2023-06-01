import 'package:flutter/material.dart';
import 'package:quicktep/layoutproperty/buttonfield.dart';

class CreateUserProfile extends StatefulWidget {
  const CreateUserProfile({super.key});

  @override
  State<CreateUserProfile> createState() => _CreateUserProfileState();
}

class _CreateUserProfileState extends State<CreateUserProfile> {
  List<String> genderName = ["Male", "Female", "Other"];
  final nameController = TextEditingController();
  bool genderSelected = false;
  //bool _infoSelected = false;
  bool _codeSelected = false;

  @override
  Widget build(BuildContext context) {
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
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: SafeArea(
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
                            borderRadius: BorderRadius.all(Radius.circular(6)),
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
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
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
                  // ListTile(
                  //   leading: Checkbox(
                  //     activeColor: Colors.green.shade50,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(2)),
                  //     checkColor: Colors.green.shade600,
                  //     side: BorderSide(width: 2, color: Colors.green.shade800),
                  //     value: _infoSelected,
                  //     onChanged: (value) {
                  //       _infoSelected = !_infoSelected;
                  //       setState(() {});
                  //     },
                  //   ),
                  //   title: const Text(
                  //     "Receive important updates on WhatsApp",
                  //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  //   ),
                  //   subtitle: const Text(
                  //     "Receive updates on latest offers & transactions",
                  //     style: TextStyle(fontSize: 11),
                  //   ),
                  // ),
                  Row(
                    children: [
                      Checkbox(
                        visualDensity: VisualDensity.compact,
                        activeColor: Colors.green.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2)),
                        checkColor: Colors.green.shade800,
                        side:
                            BorderSide(width: 2, color: Colors.green.shade900),
                        value: _codeSelected,
                        onChanged: (value) {
                          setState(() {
                            _codeSelected = !_codeSelected;
                          });
                        },
                      ),
                      const Text("I have a referral code",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              )),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ReuseButton(onPressed: () {}, text: "Proceed"),
        ),
      ),
    );
  }

  genderBox(String text, IconData icon) {
    return InkWell(
      onTap: () {
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
