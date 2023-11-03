abstract class ResetPasswordFailure {}

class CodeInvalid extends ResetPasswordFailure {}

class CodeExpired extends ResetPasswordFailure {}

class UserNotFound extends ResetPasswordFailure {}

class WeakPassword extends ResetPasswordFailure {}

class UnexpectedFailure extends ResetPasswordFailure {}

class UnexpectedFailureFirebase extends ResetPasswordFailure {}
