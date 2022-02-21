import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class dbservices {
  Future<List<String>> listExample() async {
    List<String> list = [];
    firebase_storage.ListResult result =
        await firebase_storage.FirebaseStorage.instance.ref().listAll();
    result.items.forEach((firebase_storage.Reference ref) {
      list.add(ref.toString());
    });
    return list;
  }
}
