import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/routes/app_routes.dart';
import 'package:market/utils/images/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkInternetAndNavigate();
  }

  Future<void> checkInternetAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));

    var connectivityResult = await Connectivity().checkConnectivity();
    bool isOnline =
        connectivityResult.first == ConnectivityResult.wifi ||
        connectivityResult.first == ConnectivityResult.mobile;

    if (mounted) {
      if (isOnline) {
        Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
      } else {
        showNoInternetDialog();
      }
    }
  }

  void showNoInternetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          icon: Icon(Icons.signal_wifi_statusbar_connected_no_internet_4),
          iconColor: Colors.red,
          title: Text("Internet yo‘q!"),
          content: Text("Iltimos, internet yoki Wi-Fi-ga ulaning."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                checkInternetAndNavigate();
              },
              child: Text("Qayta urinish"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.appLogo, height: 250.h, width: 250.w),
                  Text(
                    'Sayfidin Savdo Lyuks',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 50.sp,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -130,
            right: -60,
            child: Circle(height: 250.h, width: 250.h, color: Colors.blue),
          ),
          Positioned(
            top: 30,
            right: 220,
            child: Circle(height: 100.h, width: 100.h, color: Colors.blue),
          ),
          Positioned(
            bottom: -130,
            left: -60,
            child: Circle(height: 250.h, width: 250.h, color: Colors.blue),
          ),
          Positioned(
            bottom: 30,
            left: 220,
            child: Circle(height: 100.h, width: 100.h, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

class Circle extends StatelessWidget {
  const Circle({
    super.key,
    required this.height,
    required this.width,
    required this.color,
  });

  final double height;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height),
        color: color,
      ),
    );
  }
}
