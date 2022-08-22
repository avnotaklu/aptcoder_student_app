import 'package:aptcoder/service/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Usertype { student, admin }

class UserService {
  static Future<Usertype?> getUsertype(User user) async {
    return (await db.collection('admins').doc(user.uid).get()).exists
        ? Usertype.admin
        : (await db.collection('students').doc(user.uid).get()).exists
            ? Usertype.student
            : null;
  }
}
