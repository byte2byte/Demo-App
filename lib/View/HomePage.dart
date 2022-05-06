import 'dart:developer';

import 'package:demo_app/Utils/Colors.dart';
import 'package:demo_app/Utils/ConstantMethods.dart';
import 'package:demo_app/Utils/KDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:encrypt/encrypt.dart' as K;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _msgController = TextEditingController();
  TextEditingController _keyController = TextEditingController();
  var _key;
  K.Encrypted? _encrypted;
  String _keyVal = '';
  String _msgVal = '';
  String txtVal = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          child: const Icon(
            Icons.menu,
            color: Kolors.primaryText,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Kolors.primaryText,
        centerTitle: true,
        title: Text(
          "Welcome John Doe",
          style: TextStyle(color: Kolors.primaryText, fontSize: 15.0.sp),
        ),
      ),
      drawer: const kDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            kSizedBox(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
              child: TextFormField(
                controller: _msgController,
                maxLines: 10,
                onChanged: (str) {
                  setState(() {
                    _msgVal = str;
                  });
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.0.w),
                  hintText: "Message",
                  border: kBorderDecoration(),
                  enabledBorder: kBorderDecoration(),
                  focusedBorder: kBorderDecoration(),
                ),
              ),
            ),
            kSizedBox(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) {
                  if (val != null) {
                    if (val.length > 16) {
                      return 'Key cannot be greater then 16 digits';
                    } else if (val.length < 16) {
                      return 'Key should be atleast 16 digit';
                    }
                  }
                },
                controller: _keyController,
                onChanged: (val) {
                  setState(() {
                    _keyVal = val;
                  });
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.0.w),
                  hintText: "Secret Key",
                  border: kBorderDecoration(),
                  enabledBorder: kBorderDecoration(),
                  errorBorder: kBorderDecoration().copyWith(
                      borderSide: const BorderSide(color: Colors.red)),
                  focusedBorder: kBorderDecoration(),
                ),
              ),
            ),
            kSizedBox(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: !(_keyVal.length == 16) && !(_msgVal.length > 1)
                        ? ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Encrypt',
                              style:
                                  bttnTextStyle().copyWith(color: Colors.grey),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Kolors.primaryText, width: 0.6),
                                  borderRadius: BorderRadius.circular(1.0.w),
                                )),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              _key = K.Key.fromUtf8(_keyController.text);
                              final iv = K.IV.fromLength(16);
                              final encrypter = K.Encrypter(K.AES(_key));

                              final encrypted = encrypter
                                  .encrypt(_msgController.text, iv: iv);

                              setState(() {
                                txtVal = encrypted.base64;
                                _encrypted = encrypted;
                              });
                            },
                            child: Text(
                              'Encrypt',
                              style: bttnTextStyle(),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Kolors.primaryText, width: 0.6),
                                  borderRadius: BorderRadius.circular(1.0.w),
                                )),
                          ),
                  ),
                  SizedBox(
                    width: 5.0.w,
                  ),
                  Expanded(
                    child: !(_keyVal.length == 16) && !(_msgVal.length > 1)
                        ? ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Decrypt',
                              style:
                                  bttnTextStyle().copyWith(color: Colors.grey),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Kolors.primaryText, width: 0.6),
                                  borderRadius: BorderRadius.circular(1.0.w),
                                )),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              final iv = K.IV.fromLength(16);

                              final encrypter = K.Encrypter(K.AES(_key));

                              if (_encrypted != null) {
                                final decrypted =
                                    encrypter.decrypt(_encrypted!, iv: iv);
                                setState(() {
                                  txtVal = decrypted;
                                });
                              } else {
                                const SnackBar(
                                    content: Text(
                                        "Please encyrpt the key first to decrypt it"));
                              }
                            },
                            child: Text(
                              'Decrypt',
                              style: bttnTextStyle(),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Kolors.primaryText, width: 0.6),
                                  borderRadius: BorderRadius.circular(1.0.w),
                                )),
                          ),
                  ),
                ],
              ),
            ),
            kSizedBox(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Encrypted / Decrypted String",
                    style: bttnTextStyle().copyWith(
                        fontSize: 14.5.sp, fontWeight: FontWeight.bold),
                  ),
                  kSizedBox(),
                  GestureDetector(
                      onLongPress: () {
                        Clipboard.setData(ClipboardData(text: txtVal))
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Text copied to clipboard")));
                        });
                      },
                      child: Text(txtVal)),
                  kSizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
