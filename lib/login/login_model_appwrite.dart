import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

Client client = Client().setEndpoint('https://cloud.appwrite.io/v1').setProject('66f55c3b001b2f3fdb47').setSelfSigned(status: true); // For self signed certificates, only use for development

final account = Account(client);

Databases databases=Databases(client);
String _dbID='66f5625b0009236a6944';
String _collectionID='66f5627300285c9cfe9b';

//to check if user is already existing one

Future<String> checkUserExist ({required String mobile}) async{
  try{
    final DocumentList matchuser= await databases.listDocuments(databaseId: _dbID, collectionId: _collectionID, queries: [
      Query.equal("mobile", mobile.replaceAll('+', ''))
    ]);
    if(matchuser.total>0){
      final Document user=matchuser.documents[0];
      if(user.data["mobile"]!=null || user.data["mobile"]!="" ){
        return user.data["mobile"];
      }
      else{
        print('No user found');
        return('user_not_found');
      }
    }
    else{
      print('No user found');
      return('user_not_found');
    }
  }on AppwriteException
  catch(e){
    print(e);
    return('user_not_found');
  }
}

//Send OTP for mobile verification

//Save new user to database collections
Future<bool> saveUserDataToDB({required String userId,  required String mobile, required String name, required String emailAddress} ) async{
  try{
    final response=await databases.createDocument(
        databaseId: _dbID,
        collectionId: _collectionID,
        documentId: userId,
        data: {
          'userId':userId,
          'mobile': mobile,
          'name':name,
          'email':emailAddress,
        }
    );
    print(response);
    return true;
  }on AppwriteException
  catch(e){
    print(e);
    return false;
  }
}


Future<String> sendOTPToVerify({required String mobile,  required String userstate}) async{
  try{
    checkExistingSession();
    if(userstate=="user_not_found"){
      final Token data= await account.createPhoneToken(userId: mobile.replaceAll('+', ''), phone: mobile);
      return data.userId;
    }
    else {
      final Token data= await account.createPhoneToken(userId: mobile.replaceAll('+', ''), phone: mobile);
      return data.userId;
    }
  }
  catch(e){
    print(e);
    return "login_error";
  }
}

//login using OTP

Future<bool> verifyOTP({required String secret, required String mobile, required String userId}) async {
  try{
    final Session session= await account.updatePhoneSession(userId: userId, secret: secret);
    print('User Id here:'+userId);
    // saveUserDataToDB(userId: userId, mobile: mobile.replaceAll('+', ''));
    print(session..userId);
    return true;
  }
  catch(e){
    print(e);
    return false;
  }
}

//to check existing sessions

Future<bool> checkExistingSession() async {
  try{
    final Session session= await account.getSession(sessionId: "current");
    print(session..userId);
    account.deleteSessions();
    return true;
  }
  catch(e){
    print(e);
    return false;
  }
}