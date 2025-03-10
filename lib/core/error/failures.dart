abstract class Failure {
   final  String?  errorMessage ;

  Failure({this.errorMessage});
}


class ErrorMessageFailure extends Failure {

  ErrorMessageFailure({required String message}):super(errorMessage: message);
}
class AnotherAccountMessageFailure  extends Failure {

  AnotherAccountMessageFailure();
}

class SiginGoogleFailure extends Failure {}
class SiginAppleFailure extends Failure {}
class SiginHuaweiFailure extends Failure {}


class SiginFacebookFailure extends Failure {}


// code => 500
class ServerFailure extends Failure {}

// code => 401
class UnauthorizedFailure extends Failure {}


class InternetFailure extends Failure {}
class BanFailure extends Failure {
  BanFailure({required String message}):super(errorMessage: message);

}