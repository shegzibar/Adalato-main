import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {


  //collection reference
  final CollectionReference usercollection =
  FirebaseFirestore.instance.collection('users');

  Future insertuserdata(String name, String height, String weight , String level,String gender ) async {
    return await usercollection
        .doc()
        .set({'name': name, 'height': height, 'weight' : weight ,'level': level,'gender': gender });
  }

  Future updateattend(int attend) async {
    return await usercollection.doc().update({'attend': attend});
  }


}