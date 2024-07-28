class AppLink {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // =======================Auth Url==============================
  static const String baseAuth = '$baseUrl/auth';
  static const String register = '$baseAuth/register';
  static const String login = '$baseAuth/login';
  static const String refreshToken = '$baseAuth/refresh_token';
  static const String logout = '$baseAuth/logout';
  //ToDo
  static const String expertAdd = '$baseUrl/addInfo';
  static const String expertGet = '$baseUrl/getInfo';
  static const String expertCategory = '$baseUrl/getExpertCategories';
  static const String expertAddTime = '$baseUrl/addTime';
  static const String expertAvailableTimes = '$baseUrl/availableTimes';
  static const String expertUnavailableTimes = '$baseUrl/unavailableTimes';
  static const String payment = '$baseUrl/payment';
  static const String getExpertsById = '$baseUrl/getExperts';
  static const String addToFavourite = '$baseUrl/addToFavorite';
  static const String getFavorite = '$baseUrl/getFavorite';
  static const String searchExpert = '$baseUrl/searchExpert';
  static const String addRating = '$baseUrl/addRating';
}
// http://127.0.0.1:8000/api/auth/register
