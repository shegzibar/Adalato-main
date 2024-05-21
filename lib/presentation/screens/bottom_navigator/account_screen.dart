import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_app/generated/l10n.dart';
import 'package:exercise_app/main.dart';
import 'package:exercise_app/presentation/screens/signup_login/signup_login_design/background_image.dart';
import 'package:exercise_app/presentation/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String? username = "";
  final String? useremail = FirebaseAuth.instance.currentUser?.email;

  void _fetchData() async {
    try {
      final String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        print('User is not signed in');
        return;
      }

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var userDocument = snapshot.docs.first;
        String? user = userDocument['name'] as String?;
        setState(() {
          username = user;
        });
        print('Username: $user');
      } else {
        print('No user found with this ID');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  final Authservice _auth = Authservice();

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[600]?.withOpacity(0.6),
          title: Text(
              S.of(context).chooseLanguage,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                tileColor: Colors.transparent,
                title: Text(
                    'English',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale('en'));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                tileColor: Colors.transparent,
                title: Text(
                    'العربية',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale('ar'));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              S.of(context).account,
              style: TextStyle(
                fontSize: 25,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.language, color: Colors.red),
                onPressed: () => _showLanguageDialog(context),
              ),
            ],
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    username ?? 'Username not available',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    useremail ?? 'Email not available',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _auth.signout();
                    },
                    child: Text(S.of(context).signout),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
