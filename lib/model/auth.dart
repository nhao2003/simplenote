import 'dart:async';
import 'dart:convert';
import 'http_exception.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  late String _userId;

  bool get isAuth {
    return (token != null);
  }

  String? get token {
    if (_expiryDate != null &&
        _token != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDpBt-Ob64UtJvsQgxfqWPcAusQ876GQbs');
    try {
      final response = await post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = jsonDecode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
    //print(json.decode(response.body));
  }

  //Register an account
  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  //Sign user in
  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
