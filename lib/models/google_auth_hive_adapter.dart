import 'package:assignment0/models/logged_in_user_info.dart';
import 'package:hive/hive.dart';

class GoogleAuthHiveAdapter extends TypeAdapter<LoggedInUserInfo> {
  @override
  int get typeId => 0;

  @override
  LoggedInUserInfo read(BinaryReader reader) {
    final uid = reader.read();
    final name = reader.read();
    final email = reader.read();
    final photoUrl = reader.read();
    return LoggedInUserInfo(
      displayName: name,
      email: email,
      photoUrl: photoUrl,
      uid: uid,
    );
  }

  @override
  void write(BinaryWriter writer, LoggedInUserInfo user) {
    writer.write(user.uid);
    writer.write(user.displayName);
    writer.write(user.email);
    writer.write(user.photoUrl);
  }
}
