/// Defines API endpoints for the LayerX app.
abstract class AppUrls {
  AppUrls._();

  static const String baseAPIURL = 'https://ninja-car-api.jeuxtesting.com/api';
  static const String notificationsBaseApi = "https://fcm.googleapis.com/v1/projects/ninjacar-3cb70/messages:send";

  // Auth Apis
  static const String signUp = '/register';
  static const String addJobs = '/add-jobs';
  static const String editJobs = '/update-jobs';
  static const String login = '/login';
  static const String getAllCategories = '/categories';
  static const String sendOtp = '/send-otp';
  static const String resetPassword = '/reset-password';
  static const String getUser = '/user-profile';
  static const String logout = '/logout';
  static const String deleteAccount = '/delete-account';
  static const String updateProfile = '/update-profile';
  static const String getUserById = '/get-user-by-id';
  static const String rateUser = '/rate-user';
  static const String getPortfolio = '/get-mechanic-portfolio';
  static const String mechanicStats = '/mechanic-stats';
  static const String getOfferById = '/get-offer-by-id';
  static const String updatePortfolio = '/update-portfolio';
  static const String updateSubcategories = '/update-user-subcategory';
  static const String assignCoupon = '/assign-coupon-to-mechanic';
  static const String sendAccessRequest = '/create-mechanic-coupon-request';
  static const String sendVerificationRequest = '/create-mechanic-verification-request';

  // Customer Side Jobs
  static const String getAllJobsByStatusOfUser = "/get-jobs-by-status-of-user";
  static const String getJobDetails = "/job-details";
  static const String deleteJob = "/delete-jobs";
  static const String acceptOrRejectJob = "/accept-job-offer";
  static const String completeJobByUser = "/complete-job-by-user";
  static const String updateJobMoreOffers = "/complete-job-by-user";
  static const String updateJobAvailable = "/update-job-available";

  // Mechanic Side Jobs
  static const String sendJobOffer = "/send-job-offer-request";
  static const String updateJobOffer = "/update-job-offer";
  static const String getAllJobsByStatus = "/get-jobs-by-status";
  static const String completeJobByMechanic = "/complete-job-by-mechanic";

  // Notifications Apis
  static const String getAllNotifications = "/notifications";
  static const String markAllAsRead = "/mark-all-as-read";
  static const String deleteAllNotifications = "/delete-all-notifications";

  // App Settings
  static const String getSettings = "/get-settings";
  static const String createReport = "/create-report";
  static const String getFaqs = "/get-faqs";
  static const String getFaqSection = "/get-faq-by-section-id";

}