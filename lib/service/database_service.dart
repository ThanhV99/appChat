import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService{
  final String? uid;
  DatabaseService({this.uid});

  // reference for our collections
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection = FirebaseFirestore.instance.collection("groups");
  final Reference firebaseStorage = FirebaseStorage.instance.ref();

  // saving the userdata
  Future savingUserData(String fullName, String email, {String imgName = "default"}) async{
    String? imgUrl = await getImage(imgName);
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilePic": imgUrl,
      "uid": uid
    });
  }

  // getting user data
  Future gettingUserData(String email) async{
    QuerySnapshot snapshot = await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  // getting user groups
  getUserGroups() async{
    return userCollection.doc(uid).snapshots();
  }

  // upload image to store firebase


  // get image from firebase store
  Future<String?> getImage(String imgName) async{
    try {
      if(imgName == "default"){
        var urlRef = firebaseStorage.child("avatar").child("default").child("${imgName.toLowerCase()}.png");
        var imgUrl = await urlRef.getDownloadURL();
        print('o day $imgUrl');
        return imgUrl;
      }
    } catch (e){
      return null;
    }
  }

  // search User in firebase
  Future searchUser(String name) async{
    QuerySnapshot result = await userCollection.where("fullName", isEqualTo: name).get();
    return result;
  }
}