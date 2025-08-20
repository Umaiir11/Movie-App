import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TheaterController extends GetxController {
  static double get seatSize => 32.w;
  static double get seatGap => 6.w;

  final RxInt seatsPerRow = 12.obs;
  final RxInt numOfRows = 8.obs;
  final RxList<String> missing = <String>['C6', 'C7', 'D6', 'D7', 'F1', 'F12'].obs;
  final RxList<String> blocked = <String>['A1', 'A12', 'H1', 'H12'].obs;
  final RxList<String> bookedSeats = <String>['B3', 'B4', 'C3', 'E8', 'E9', 'F8'].obs;
  final RxList<String> selectedSeatNames = <String>[].obs;

  // Movie details
  final RxString movieTitle = 'Avengers: Endgame'.obs;
  final RxString cinemaName = 'PVR Cinemas'.obs;
  final RxString showTime = '7:30 PM'.obs;
  final RxString showDate = 'Today, Aug 20'.obs;
  final RxString hallName = 'Screen 1'.obs;
  final RxDouble ticketPrice = 250.0.obs;

  double getMaxScreenWidth(int seats) => seats * (seatSize + seatGap);

  void toggleSeat(String seatName) {
    if (selectedSeatNames.contains(seatName)) {
      selectedSeatNames.remove(seatName);
    } else {
      if (selectedSeatNames.length < 8) { // Limit selection to 8 seats
        selectedSeatNames.add(seatName);
      } else {
        Get.snackbar(
          "Limit Reached",
          "Maximum 8 seats can be selected",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange.withOpacity(0.8),
          colorText: Colors.white,
        );
      }
    }
  }

  double get totalAmount => selectedSeatNames.length * ticketPrice.value;

  void goBack() {
    Get.back();
  }

  void proceedToPayment() {
    if (selectedSeatNames.isEmpty) {
      Get.snackbar(
        "No Seats Selected",
        "Please select at least one seat",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } else {
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: Text('Booking Confirmed!', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Seats: ${selectedSeatNames.join(", ")}', style: TextStyle(fontSize: 16.sp)),
              SizedBox(height: 8.h),
              Text('Total: ₹${totalAmount.toStringAsFixed(0)}', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('OK', style: TextStyle(fontSize: 16.sp)),
            ),
          ],
        ),
      );
    }
  }
}
