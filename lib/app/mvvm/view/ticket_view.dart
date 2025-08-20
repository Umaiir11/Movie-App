import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../view_model/ticket_controller.dart';

// Enhanced TheaterController

class TheaterScreen extends StatelessWidget {
  const TheaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TheaterController());

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(controller),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Movie Info Card
                    _buildMovieInfoCard(controller),

                    SizedBox(height: 16.h),

                    // Screen
                    _buildScreen(controller),

                    SizedBox(height: 20.h),

                    // Seats Area
                    _buildSeatsArea(controller),

                    SizedBox(height: 16.h),

                    // Legend
                    _buildLegend(),

                    SizedBox(height: 16.h),

                    // Selected Seats and Total
                    _buildBookingSummary(controller),

                    SizedBox(height: 100.h), // Space for bottom button
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Fixed bottom button
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Color(0xFF0F0F23),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: _buildPurchaseButton(controller),
      ),
    );
  }

  Widget _buildHeader(TheaterController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24.sp),
            onPressed: controller.goBack,
          ),
          Expanded(
            child: Text(
              'Select Seats',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 48.w), // Balance the back button
        ],
      ),
    );
  }

  Widget _buildMovieInfoCard(TheaterController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E1E3F), Color(0xFF2D2D5F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: Color(0xFFFF6B6B),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.movieTitle.value,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      controller.cinemaName.value,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _buildInfoChip(Icons.access_time, controller.showTime.value),
              SizedBox(width: 12.w),
              _buildInfoChip(Icons.calendar_today, controller.showDate.value),
              SizedBox(width: 12.w),
              _buildInfoChip(Icons.movie, controller.hallName.value),
            ],
          ),
        ],
      )),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: Color(0xFFFF6B6B)),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreen(TheaterController controller) {
    return Obx(() {
      final minScreenWidth = 1.sw - 40.w;
      var screenWidth = controller.getMaxScreenWidth(controller.seatsPerRow.value);
      screenWidth = max(screenWidth, minScreenWidth * 0.8);

      return Column(
        children: [
          Container(
            width: screenWidth,
            height: 8.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Color(0xFFFF6B6B).withOpacity(0.6),
                  Color(0xFFFF6B6B),
                  Color(0xFFFF6B6B).withOpacity(0.6),
                  Colors.transparent,
                ],
              ),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'SCREEN',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildSeatsArea(TheaterController controller) {
    return SizedBox(
      height: 380.h, // Fixed height to prevent overflow
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(controller.numOfRows.value, (rowIdx) {
              String rowLetter = String.fromCharCode(65 + rowIdx);
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Row label
                    Container(
                      width: 20.w,
                      alignment: Alignment.center,
                      child: Text(
                        rowLetter,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),

                    // Seats
                    ...List.generate(controller.seatsPerRow.value, (seatIdx) {
                      String seatName = "$rowLetter${seatIdx + 1}";
                      return _buildSeat(controller, seatName, seatIdx);
                    }),

                    SizedBox(width: 6.w),

                    // Row label (right side)
                    Container(
                      width: 20.w,
                      alignment: Alignment.center,
                      child: Text(
                        rowLetter,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          )),
        ),
      ),
    );
  }

  Widget _buildSeat(TheaterController controller, String seatName, int seatIdx) {
    return Obx(() {
      if (controller.missing.contains(seatName)) {
        return SizedBox(
          width: TheaterController.seatSize + TheaterController.seatGap,
          height: TheaterController.seatSize,
        );
      }

      Color seatColor = Color(0xFF4ECDC4); // Available
      Color borderColor = Colors.transparent;
      IconData? seatIcon;

      if (controller.blocked.contains(seatName)) {
        seatColor = Color(0xFF6B6B83);
        seatIcon = Icons.close;
      } else if (controller.bookedSeats.contains(seatName)) {
        seatColor = Color(0xFFFF6B6B);
      } else if (controller.selectedSeatNames.contains(seatName)) {
        seatColor = Color(0xFFFFD93D);
        borderColor = Colors.white;
      }

      return GestureDetector(
        onTap: () {
          if (!controller.blocked.contains(seatName) &&
              !controller.bookedSeats.contains(seatName)) {
            controller.toggleSeat(seatName);
          }
        },
        child: Container(
          margin: EdgeInsets.all(TheaterController.seatGap / 2),
          width: TheaterController.seatSize,
          height: TheaterController.seatSize,
          decoration: BoxDecoration(
            color: seatColor,
            borderRadius: BorderRadius.circular(8.r),
            border: borderColor != Colors.transparent
                ? Border.all(color: borderColor, width: 2)
                : null,
            boxShadow: controller.selectedSeatNames.contains(seatName)
                ? [BoxShadow(color: Color(0xFFFFD93D).withOpacity(0.5), blurRadius: 8)]
                : null,
          ),
          child: seatIcon != null
              ? Icon(seatIcon, size: 16.sp, color: Colors.white)
              : null,
        ),
      );
    });
  }

  Widget _buildLegend() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLegendItem(Color(0xFF4ECDC4), "Available"),
          _buildLegendItem(Color(0xFFFFD93D), "Selected"),
          _buildLegendItem(Color(0xFFFF6B6B), "Booked"),
          _buildLegendItem(Color(0xFF6B6B83), "Blocked"),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16.w,
          height: 16.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildBookingSummary(TheaterController controller) {
    return Obx(() {
      if (controller.selectedSeatNames.isEmpty) {
        return SizedBox.shrink();
      }

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Color(0xFF1E1E3F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Color(0xFFFFD93D).withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Selected Seats: ',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                  ),
                ),
                Expanded(
                  child: Wrap(
                    spacing: 8.w,
                    children: controller.selectedSeatNames.map((seat) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFD93D).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(color: Color(0xFFFFD93D), width: 1),
                        ),
                        child: Text(
                          seat,
                          style: TextStyle(
                            color: Color(0xFFFFD93D),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${controller.selectedSeatNames.length} × ₹${controller.ticketPrice.value.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  '₹${controller.totalAmount.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: Color(0xFFFFD93D),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPurchaseButton(TheaterController controller) {
    return Obx(() => Container(
      width: 1.sw - 40.w,
      height: 56.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: ElevatedButton(
        onPressed: controller.proceedToPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.selectedSeatNames.isNotEmpty
              ? Color(0xFFFF6B6B)
              : Colors.grey.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: controller.selectedSeatNames.isNotEmpty ? 8 : 0,
          shadowColor: Color(0xFFFF6B6B).withOpacity(0.5),
        ),
        child: Text(
          controller.selectedSeatNames.isNotEmpty
              ? 'Pay ₹${controller.totalAmount.toStringAsFixed(0)}'
              : 'Select Seats',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ));
  }
}