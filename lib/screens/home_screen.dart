import 'package:image_editor/providers/app_image_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Artify', style: GoogleFonts.lato(fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: CloseButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              _saveCurrentImage(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 16, 16, 16),
      body: Center(
        child: Consumer<AppImageProvider>(
          builder: (BuildContext context, value, Widget? child) {
            if (value.currentImage != null) {
              return Image.memory(
                value.currentImage!,
                height: screenHeight * 1, 
                width: screenWidth * 1,  
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: screenHeight * 0.07,  
        color: Colors.black,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: screenWidth * 0.43,),  
                  _bottomBatItem(
                    Icons.photo_filter_rounded,
                    'Filters',
                    onPress: () {
                      Navigator.of(context).pushNamed('/filter');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _bottomBatItem(IconData icon, String title, {required onPress}) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(
              height: 3,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white70,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _saveCurrentImage(BuildContext context) async {
    final appImageProvider =
        Provider.of<AppImageProvider>(context, listen: false);
    final currentImageBytes = appImageProvider.currentImage;

    if (currentImageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No image to save.'),
        ),
      );
      return;
    }

    try {
      final result = await ImageGallerySaver.saveImage(
        currentImageBytes,
        quality: 100,
      );

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image saved successfully.'),
          ),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save image to gallery.'),
        ),
      );
    } catch (e) {
      print('Error saving image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving image.'),
        ),
      );
    }
  }
}
