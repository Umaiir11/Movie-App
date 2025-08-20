import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tmdb_assignment/app/config/app_assets.dart';
import 'package:tmdb_assignment/app/config/padding_extensions.dart';
import 'package:tmdb_assignment/app/config/sizedbox_extension.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_style.dart';
import '../view_model/ticket_controller.dart';

class TheaterScreen extends StatelessWidget {
  const TheaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TheaterController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: controller.goBack,
        ),
        title: Column(
          children: [
            Text(
              "The King's Man",
              style: AppTextStyles.customText18(fontWeight: FontWeight.w600, color: Colors.black),
            ),
            2.h.verticalSpace,
            Text("March 5, 2021  |  12:30 Hall 1", style: AppTextStyles.customText14(color: Colors.blue)),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  20.h.verticalSpace,
                  _buildScreen(controller),
                  30.h.verticalSpace,
                  _buildSeatsArea(controller),
                  30.h.verticalSpace,
                  _buildLegend(),
                  20.h.verticalSpace,
                  _buildSelectedSeatsInfo(controller),
                  20.h.verticalSpace,
                ],
              ),
            ),
          ),
          _buildBottomSection(controller),
        ],
      ),
    );
  }

  Widget _buildScreen(TheaterController controller) {
    return Obx(() {
      final minScreenWidth = 1.sw - 60.w;
      var screenWidth = controller.getMaxScreenWidth(controller.seatsPerRow.value);
      screenWidth = max(screenWidth, minScreenWidth * 0.8);

      return Column(
        children: [
          Container(
            width: screenWidth,
            height: 35.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(100.r), topRight: Radius.circular(100.r)),
              border: Border.all(color: Colors.blue.withOpacity(0.3), width: 2),
            ),
            child: Center(
              child: Text(
                'SCREEN',
                style: AppTextStyles.customText12(color: Colors.grey[600], letterSpacing: 3, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ).paddingHorizontal(15.w);
    });
  }

  Widget _buildSeatsArea(TheaterController controller) {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.blue.withOpacity(0.3), width: 2),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(
              () =>
              Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(controller.numOfRows.value, (rowIdx) {
                  String rowLetter = String.fromCharCode(65 + rowIdx);
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _rowLabel(rowLetter),
                        8.w.horizontalSpace,
                        ...List.generate(controller.seatsPerRow.value, (seatIdx) {
                          String seatName = "$rowLetter${seatIdx + 1}";
                          return _buildSeat(controller, seatName);
                        }),
                        8.w.horizontalSpace,
                        _rowLabel(rowLetter),
                      ],
                    ),
                  );
                }),
              ),
        ),
      ),
    );
  }

  Widget _rowLabel(String rowLetter) {
    return Container(
      width: 20.w,
      alignment: Alignment.center,
      child: Text(
        rowLetter,
        style: AppTextStyles.customText12(color: Colors.grey[600], fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildSeat(TheaterController controller, String seatName) {
    return Obx(() {
      if (controller.missing.contains(seatName)) {
        return SizedBox(width: TheaterController.seatSize + TheaterController.seatGap, height: TheaterController.seatSize);
      }

      Color seatColor = Colors.grey[300]!; // Available (light grey)
      Color borderColor = Colors.transparent;
      IconData? seatIcon;

      if (controller.blocked.contains(seatName)) {
        seatColor = Colors.grey[400]!; // Not available (darker grey)
        seatIcon = Icons.close;
      } else if (controller.bookedSeats.contains(seatName)) {
        seatColor = Colors.grey[400]!; // Not available (darker grey)
      } else if (controller.selectedSeatNames.contains(seatName)) {
        seatColor = Colors.orange; // Selected (orange/yellow)
        borderColor = Colors.orange;
      } else {
        // Available seats - light blue
        seatColor = Colors.lightBlue[100]!;
      }

      return GestureDetector(
        onTap: () {
          if (!controller.blocked.contains(seatName) && !controller.bookedSeats.contains(seatName)) {
            controller.toggleSeat(seatName);
          }
        },
        child: Container(
          margin: EdgeInsets.all(TheaterController.seatGap / 2),
          width: TheaterController.seatSize,
          height: TheaterController.seatSize,
          decoration: BoxDecoration(
            color: seatColor,
            borderRadius: BorderRadius.circular(6.r),
            border: borderColor != Colors.transparent ? Border.all(color: borderColor, width: 2) : null,
          ),
          child: seatIcon != null ? Icon(seatIcon, size: 12.sp, color: Colors.white) : null,
        ),
      );
    });
  }

  Widget _buildLegend() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _legendItem(Colors.orange, "Selected"),
          _legendItem(Colors.grey[400]!, "Not available"),
          _legendItem(Colors.grey[600]!, "VIP (150₹)"),
          _legendItem(Colors.lightBlue[100]!, "Regular (50₹)"),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(AppAssets.seatIcon, height: 15.h, color: color,),
        6.w.horizontalSpace,
        Text(label, style: AppTextStyles.customText12(color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildSelectedSeatsInfo(TheaterController controller) {
    return Obx(() {
      if (controller.selectedSeatNames.isEmpty) return const SizedBox.shrink();

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Text(
              '${controller.selectedSeatNames.length}',
              style: AppTextStyles.customText16(fontWeight: FontWeight.w600, color: Colors.black),
            ),
            4.w.horizontalSpace,
            Text('/ 3 row', style: AppTextStyles.customText14(color: Colors.grey[600])),
            Spacer(),
            GestureDetector(
              onTap: () {
                // Clear selection logic if needed
              },
              child: Icon(Icons.close, size: 20.sp, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildBottomSection(TheaterController controller) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Total Price Row
          Obx(
                () =>
                Row(
                  children: [
                    Text('Total Price', style: AppTextStyles.customText14(color: Colors.grey[600])),
                    Spacer(),
                    Text(
                      controller.selectedSeatNames.isNotEmpty ? '\$ ${controller.totalAmount.toStringAsFixed(0)}' : '\$ 0',
                      style: AppTextStyles.customText20(fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                  ],
                ),
          ),
          20.h.verticalSpace,
          // Proceed Button
          Obx(
                () =>
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: controller.selectedSeatNames.isNotEmpty ? controller.proceedToPayment : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.selectedSeatNames.isNotEmpty ? Colors.lightBlue : Colors.grey[300],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                      elevation: 0,
                    ),
                    child: Text(
                      'Proceed to pay',
                      style: AppTextStyles.customText16(
                        fontWeight: FontWeight.w600,
                        color: controller.selectedSeatNames.isNotEmpty ? Colors.white : Colors.grey[600],
                      ),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
