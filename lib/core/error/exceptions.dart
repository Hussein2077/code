
class SiginFacebookException implements Exception {}

class SiginGoogleException implements Exception {}

// code => 500
class ServerException implements Exception {}
class BanException implements Exception {}


//501
class BanDeviceException implements Exception{}

// code 400
class FaildException implements Exception {}



// code => 401
class UnauthorizedException implements Exception {}
// code => 408
class BlocException implements Exception {}

// code 310
class NotverifiedException implements Exception {}

// code 422
class BadRequestException implements Exception {}

class PasswordOrPhoneWrongException implements Exception {}

// code 408
class NoPermissionException implements Exception {}

// code => 404
class NotFoundException implements Exception {}

// code 405
class AreadyExistException implements Exception {}

//code 444
class TooManyRequestsException implements Exception {}

// code=> 403
class ForbidenException implements Exception {}

//code 407
class LowBalancedException implements Exception {}

//code 409
class RequirePasswordException implements Exception {}

//code 410
class PasswordWrongException implements Exception {}

class ConnectionTimeoutException implements Exception {}

class NoInternetConnectionException implements Exception {}

class BlocRoomException implements Exception {
final String errorMessage ;
final String  remainingTime ;

BlocRoomException({required this.errorMessage, required this.remainingTime});
}

