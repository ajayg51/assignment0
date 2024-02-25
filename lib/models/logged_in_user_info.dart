class LoggedInUserInfo {
  final String displayName;
  final String email;
  final String photoUrl;
  final String uid;

  LoggedInUserInfo({
    required this.displayName,
    required this.email,
    required this.photoUrl,
    required this.uid,
  });

  factory LoggedInUserInfo.fromMap(Map<String, dynamic> map) {
    return LoggedInUserInfo(
      displayName: map["displayName"] ?? "",
      email: map["email"] ?? "",
      photoUrl: map["photoUrl"] ?? "",
      uid: map["uid"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'uid': uid,
    };
  }
}
