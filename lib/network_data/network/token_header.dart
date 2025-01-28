
class APIHeader {
static Map<String, String> createAuthHeaders({required String token})  {

  return {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization':  'Bearer $token'
  };
}

}