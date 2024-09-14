import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:securechat/Widgets/my_footer.dart';
import 'package:securechat/Widgets/country_drop_down.dart';
import 'package:securechat/providers/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var db = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;
  TextEditingController newUserName = TextEditingController();
  TextEditingController newUserEmail = TextEditingController();
  TextEditingController newUserImage = TextEditingController();
  String selectedCountry = '';
  var editProfileForm = GlobalKey<FormState>();
  var logger = Logger();

  void editUserData() {
    Map<String, dynamic> dataToEdit = {
      "name": newUserName.text,
      "email": newUserEmail.text,
      "profileImage": newUserImage.text,
      "country": selectedCountry,
    };
    try {
      db
          .collection("users")
          .doc(Provider.of<UserProvider>(context, listen: false).userId)
          .update(dataToEdit);

      Provider.of<UserProvider>(context, listen: false).getUserData();
      Navigator.pop(context);
    } catch (e) {
      logger.d(e);
    }
  }

  @override
  void initState() {
    super.initState();
    newUserName.text =
        Provider.of<UserProvider>(context, listen: false).userName;
    newUserEmail.text =
        Provider.of<UserProvider>(context, listen: false).userEmail;
    selectedCountry =
        Provider.of<UserProvider>(context, listen: false).userCountry;
    newUserImage.text =
        Provider.of<UserProvider>(context, listen: false).userImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          IconButton(
              onPressed: () {
                if (editProfileForm.currentState!.validate()) {
                  editUserData();
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      bottomNavigationBar: const MyFooter(),
      body: SingleChildScrollView(
        child: Form(
          key: editProfileForm,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: newUserName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    } else {
                      return null;
                    }
                  },
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: newUserImage,
                  validator: (value) {
                    return null;
                  },
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(labelText: 'ImageLink'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: newUserEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!value.contains('@') &&
                        !value.contains('.com')) {
                      return 'Please enter true Email';
                    } else {
                      return null;
                    }
                  },
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(labelText: 'Edit email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CountryDropDown(
                  initialCountry: selectedCountry,
                  onCountryChanged: (value) {
                    setState(() {
                      selectedCountry = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
