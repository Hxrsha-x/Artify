import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor/helper/app_image_picker.dart';
import 'package:image_editor/providers/app_image_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late AppImageProvider imageProvider;

  @override
  void initState() {
    imageProvider = Provider.of<AppImageProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(width: double.infinity, child: Image.asset('assets/images/Artify.png'),),
          Container(
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: screenHeight * 0.8,),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                            "Select/Capture an image:",
                            style: GoogleFonts.lato(
                              fontSize: screenWidth * 0.04,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      SizedBox(height: screenWidth * 0.04,),
                      SizedBox(
                        width: screenWidth * 0.35,
                        height: screenWidth * 0.1,
                        child: ElevatedButton(
                          onPressed: () {
                            AppImagePicker(source: ImageSource.gallery).pick(
                                onPick: (File? image) {
                                  imageProvider.changeImage(image!);
                                  Navigator.of(context).pushReplacementNamed('/home');
                                });
                          },
                          child: Text(
                            "Gallery",
                            style: GoogleFonts.lato(
                              fontSize: screenWidth * 0.04,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.025,),
                      SizedBox(
                        width: screenWidth * 0.35,
                        height: screenWidth * 0.1,
                        child: ElevatedButton(
                          onPressed: () {
                            AppImagePicker(source: ImageSource.camera).pick(
                                onPick: (File? image) {
                                  imageProvider.changeImage(image!);
                                  Navigator.of(context).pushReplacementNamed('/home');
                                });
                          },
                          child: Text(
                            "Camera",
                            style: GoogleFonts.lato(
                              fontSize: screenWidth * 0.04,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        
                      ),
                      SizedBox(height: screenWidth * 0.06,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
