class APIEndpoints {
  static const String host = 'https://bookandflytoursapi.azurewebsites.net';

  static const String baseUrl =
      'https://bookandflytoursapi.azurewebsites.net/api/';

  static const String loginUrl = "Authenticate/login";

  static const String registerUrl = "Authenticate/register";

  static const String sendOtp = "Authenticate/VerifyEmail";

  static const String confirmOtp = "Authenticate/ConfirmEmail";

  static const String myProfile = "MyProfile";

  static const String myBooking = "MyBooking/loyalty";

  static const String booking = "Booking";
  
  static const String bookingPayment = "Booking/BookingPayment";

  static const String searchHotel = "SearchHotel";

  static const String review = "Review";

  static const String hotel = "Hotel";

  static const String popularHotel = "Hotel/PopularHotels";

  static const String featured = "FeaturedItems";
}
