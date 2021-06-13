class User {
  final String phoneNumber;
  final String username;
  final String cancertype;
  final String location;
  final String id;

  User({this.username, this.cancertype, this.location, this.id, this.phoneNumber});

  Map<String, dynamic> tomap() {
    return {
      'phoneNumber': phoneNumber,
      'username': username,
      'cancertype': cancertype,
      'location': location,
      'id': id
    };
  }
}
