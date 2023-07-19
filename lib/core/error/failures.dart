abstract class Failure {}

// class OffLineFailure extends Failure {}


// class EmptyCacheFailure extends Failure {}

class PhoneRequiredFailure extends Failure {}



// class YouHaveRoomFailure extends Failure {}

// class WrongCodeFailure extends Failure {}

// class NotAllowedFailure extends Failure {}

class SiginFacebookFailure extends Failure {}

class  PasswordOrPhoneWrongFailure extends Failure {}
// class NotInRoomFailure extends Failure {}

class SiginGoogleFailure extends Failure {}

// class NotHaveCoinsFailure extends Failure {}

class BlocRoomFailure extends Failure {

}


// class DoesMatchFailure extends Failure {}

// class CheckYourInputeFailure implements Failure {}

// code => 500
class ServerFailure extends Failure {}
//code 400
class FaildFailure extends Failure{}
// code => 401
class UnauthorizedFailure extends Failure {}

class BlocFailure extends Failure {}


class BanFailure extends Failure {}


//code 310
class NotverifiedFailure extends Failure{}

// code => 422
class BadRequestFailure extends Failure {}
// code 408
class NoPermissionFailure extends Failure {}
// code => 404
class NotFoundFailure extends Failure {}
// code 405
class AreadyExistFailure extends Failure {}
// code 444
class TooManyRequestsFailure extends Failure{}



//code 403
class ForbidenFailure extends Failure{}

class ConnectionTimeoutFailure extends Failure {}
// code 407
class LowBalancedFailure extends Failure{}
//code 409
class RequirePasswordFailure extends Failure{}
//code 410
class PasswordWrongFailure extends Failure {}

class NoInternetConnectionFailure extends Failure {}

class UnknownFailure extends Failure {}



//501 
class BanDeviceFailure extends Failure{}