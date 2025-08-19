import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_assignment/app/config/app_text_style.dart';
import 'package:tmdb_assignment/app/customWidgets/custom_app_bar.dart';
import '../../../config/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _circleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();

    _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Circle vertical animation (infinite loop up-down)
    _circleAnimation = Tween<double>(begin: -10, end: 10).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Repeat for continuous movement
    _controller.repeat(reverse: true);

    // Navigate after 2 seconds
    Future.delayed(const Duration(seconds: 4), () {
      Get.offAllNamed(AppRoutes.bottomBarView);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedCircle({double size = 30, Color color = Colors.white, double left = 50, double top = 50}) {
    return AnimatedBuilder(
      animation: _circleAnimation,
      builder: (context, child) {
        return Positioned(
          left: left,
          top: top + _circleAnimation.value,
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(0.2)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(title: '', backgroundColor: Colors.transparent),
      body: SafeArea(
        child: Stack(
          children: [
            // Floating Circles (well-separated)
            _buildAnimatedCircle(size: 40, color: Colors.blue, left: 50, top: 100),
            _buildAnimatedCircle(size: 25, color: Colors.red, left: 280, top: 220),
            _buildAnimatedCircle(size: 35, color: Colors.green, left: 90, top: 300),
            _buildAnimatedCircle(size: 20, color: Colors.yellow, left: 200, top: 450),

            // Extra Circles (adjusted for spacing)
            _buildAnimatedCircle(size: 30, color: Colors.purple, left: 320, top: 120),
            _buildAnimatedCircle(size: 15, color: Colors.orange, left: 40, top: 400),
            _buildAnimatedCircle(size: 28, color: Colors.cyan, left: 250, top: 520),
            _buildAnimatedCircle(size: 22, color: Colors.pink, left: 140, top: 200),
            _buildAnimatedCircle(size: 18, color: Colors.teal, left: 310, top: 380),
            _buildAnimatedCircle(size: 26, color: Colors.lime, left: 80, top: 500),

            // TMDB Logo
            Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    "TMDB",
                    style: AppTextStyles.customText(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2),
                  ),
                ),
              ),
            ),

            // Version Text
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Text(
                "Version 1",
                textAlign: TextAlign.center,
                style: AppTextStyles.customText14(color: Colors.white.withOpacity(0.7)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
