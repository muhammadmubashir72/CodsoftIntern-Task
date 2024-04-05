import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class QuoteTileWidget extends StatefulWidget {
  final String id;
  final String text;
  final String author;
  final VoidCallback onFavouritesIconPressed;
  final bool isFavorite;
  final LinearGradient backgroundColor;

  const QuoteTileWidget({
    Key? key,
    required this.id,
    required this.text,
    required this.author,
    required this.onFavouritesIconPressed,
    required this.isFavorite,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  _QuoteTileWidgetState createState() => _QuoteTileWidgetState();
}

class _QuoteTileWidgetState extends State<QuoteTileWidget> {
  bool _isFavorite = false;
  bool _showIcons = true; // To control the visibility of icons
  late ScreenshotController _screenshotController;

  @override
  void initState() {
    _isFavorite = widget.isFavorite;
    _screenshotController = ScreenshotController();
    super.initState();
  }

  void _captureAndShare() async {
    try {
      // Hide icons before capturing the screenshot
      setState(() {
        _showIcons = false;
      });

      // Capture the widget as an image
      final Uint8List? imageUint8List = await _screenshotController.capture();

      if (imageUint8List == null) {
        throw Exception('Failed to capture the widget as an image');
      }

      // Share the image using ShareXFile
      Share.shareXFiles(
        [
          XFile.fromData(
            imageUint8List,
            name: 'Quote Image',
            mimeType: 'image/png',
          ),
        ],
        subject: 'Share Quote Image',
      );
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _showIcons = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotController,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(16),
        height: 440,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          gradient: widget.backgroundColor,
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 1,
              right: 10,
              child: _showIcons ? _buildShareIconButton() : SizedBox(),
            ),
            Positioned(
              top: 114,
              right: 210,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  'assets/quote_image.png',
                  width: 50.0,
                  height: 50.0,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 70),
                Container(
                  margin: EdgeInsets.only(top: 90.0),
                  child: Text(
                    widget.author,
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: 100.0, top: 20),
                  child: Text(
                    '- ${widget.text}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _showIcons ? _buildFavoriteIconButton() : SizedBox(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareIconButton() {
    return IconButton(
      onPressed: () {
        _captureAndShare();
      },
      icon: Icon(
        Icons.share,
        color: Colors.white,
      ),
    );
  }

  Widget _buildFavoriteIconButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isFavorite = !_isFavorite;
          print(_isFavorite);
          widget.onFavouritesIconPressed();
        });
      },
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite,
        color: Colors.red,
      ),
    );
  }
}
