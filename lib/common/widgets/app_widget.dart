import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_view/photo_view.dart';

class AppWidgets {
  Widget gapH(double height) {
    return SizedBox(
      height: height.h,
    );
  }

  Widget gapW(double width) {
    return SizedBox(
      width: width.w,
    );
  }

  Widget gapW8() {
    return SizedBox(
      width: 8.w,
    );
  }

  Widget gapH8() {
    return SizedBox(
      height: 8.h,
    );
  }

  Widget gapH16() {
    return SizedBox(
      height: 16.h,
    );
  }

  Widget gapW16() {
    return SizedBox(
      width: 16.w,
    );
  }

  Widget gapW12() {
    return SizedBox(
      width: 12.w,
    );
  }

  Widget gapW24() {
    return SizedBox(
      width: 24.w,
    );
  }

  Widget gapH12() {
    return SizedBox(
      height: 12.h,
    );
  }

  Widget gapH24() {
    return SizedBox(
      height: 24.h,
    );
  }

  Widget divider() {
    return const Divider(
      color: Color.fromRGBO(221, 221, 221, 1),
      thickness: 1,
    );
  }

  void showCustomSnackbar(
    BuildContext context, {
    String title = "Attention",
    String message = "Some message",
    int waitingTime = 2,
    SnackBarPosition snackBarPosition = SnackBarPosition.top,
    Color backgroundColor = Colors.black,
    double backgroundColorOpacity = .7,
    Color colorText = Colors.white,
  }) {
    // Hide any existing Snackbars
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: snackBarPosition == SnackBarPosition.top ? 50.0 : null,
        bottom: snackBarPosition == SnackBarPosition.bottom ? 50.0 : null,
        left: 20.0,
        right: 20.0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: backgroundColor.withOpacity(backgroundColorOpacity),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colorText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  message,
                  style: TextStyle(color: colorText),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Show the Snackbar
    overlay.insert(overlayEntry);

    // Remove the Snackbar after the waiting time
    Future.delayed(Duration(seconds: waitingTime), () {
      overlayEntry.remove();
    });
  }

  void showSuccessSnackbar(BuildContext context,
      {String title = "Success", required String message}) {
    showCustomSnackbar(
      context,
      title: title,
      message: message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackBarPosition: SnackBarPosition.top,
    );
  }

  void showFailureSnackbar(BuildContext context,
      {String title = "Failed", required String message}) {
    showCustomSnackbar(
      context,
      title: title,
      message: message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackBarPosition: SnackBarPosition.top,
    );
  }

  void openCustomDialog(BuildContext context, Widget content,
      {required String title,
      VoidCallback? onCancel,
      VoidCallback? onConfirm}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: content,
        actions: [
          TextButton(
            onPressed: onCancel ?? () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: onConfirm ?? () => Navigator.of(context).pop(),
            child: Text("Confirm"),
          ),
        ],
      ),
    );
  }

  void openBannedUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Attention',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'ibold',
                fontSize: 16)),
        content: SizedBox(
          height: 50,
          width: 200,
          child: Center(child: Text('You have been banned.')),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  noDataFoundLottie({String? message = "no_data_found"}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/common/empty_data.zip",
            width: 100.h,
            alignment: Alignment.center,
          ),
          Text(
            "${message}",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  showLoadingTextContainer(loadingCondition, valueCondition) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: loadingCondition ? 45.h : 0,
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: Text(valueCondition
              ? 'common_no_more_products'
              : 'common_loading_more_products'),
        ),
      ),
    );
  }

  Widget internetConnectionStatus(bool isConnected) {
    return Visibility(
      visible: !isConnected,
      child: Container(
        width: double.infinity,
        color: Colors.yellow,
        padding: EdgeInsets.all(4.0),
        child: Text(
          "No internet connection",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  openPhotoDialog(BuildContext context, path) => showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return Dialog.fullscreen(
            child: Stack(
              children: [
                PhotoView(
                  loadingBuilder: (context, event) => Container(
                      alignment: Alignment.center,
                      color: Colors.black,
                      child: CachedNetworkImage(
                          imageUrl: path,
                          placeholder: (context, url) =>
                              Image.asset("assets/common/placeholder.png"),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/common/no_image_found.png"))),
                  enableRotation: true,
                  heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
                  imageProvider: NetworkImage(path),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 10, 0).r,
                    child: Container(
                      decoration: ShapeDecoration(
                        color: Colors.grey[50],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                          ),
                        ),
                      ),
                      width: 40,
                      height: 40,
                      child: IconButton(
                        icon: Icon(Icons.clear, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
}

enum SnackBarPosition { top, bottom }
