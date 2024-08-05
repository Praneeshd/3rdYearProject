class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 60000);
  static const Duration receiveTimeout = Duration(seconds: 60000);
  //For Windows
  static const String baseUrl = "http://10.0.2.2:5000/api/";

  // ====================== Auth Routes ===========p===========
  static const String login = "user/login";
  static const String register = "user/create";
  static const String sendemail = "user/resetpassword";
  static const String sendcode = "user/resetcode";

  static const String foods = "food/get_foods";
  static const String offers = "food/get_foods";
  static const String restaurants = "restaurant/get_restaurants";

  //users
  static const String getUser = "getuser";
  static const String deleteUser = "user/profile/";
  static const String updateProfile = "user/updateuser/";
  static const String uploadImage = "user/uploadImage";
  static const String createOrder = "food/create_order";

  static const limitPage = 5;
}
