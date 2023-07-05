class UserModel {
  String name;
  String gender;
  String phonenumber;
  String uid;
  UserModel({
    required this.name,
    required this.gender,
    required this.phonenumber,
    required this.uid,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      gender: map['gender'],
      phonenumber: map['phonenumber'],
      uid: map['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "gender": gender,
      "phonenumber": phonenumber,
      "uid": uid
    };
  }
}
