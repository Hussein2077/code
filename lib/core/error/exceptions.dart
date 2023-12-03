

class ErrorModelException implements Exception {

final String errorMessage ;

ErrorModelException({required this.errorMessage});


factory ErrorModelException.fromJson( Map<String,dynamic> json){
  return ErrorModelException(errorMessage: json['message']);
}


}



// code => 500
class ServerException implements Exception {}

class AnotherAccountException implements Exception {}

// code => 401
class UnauthorizedException implements Exception {}


class ConnectionTimeoutException implements Exception {}

class SiginFacebookException implements Exception {}

class SiginGoogleException implements Exception {}
class SiginAppleException implements Exception {}
class SiginHuaweiException implements Exception {}

class InternetException implements Exception {}