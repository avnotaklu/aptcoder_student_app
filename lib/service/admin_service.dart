import 'package:aptcoder/model/admin.dart';
import 'package:aptcoder/service/constants.dart';

class AdminService {
  static addNewAdmin(Admin admin) async {
    db.collection('admins').doc(admin.uid).set(admin.toMap());
  }
}
