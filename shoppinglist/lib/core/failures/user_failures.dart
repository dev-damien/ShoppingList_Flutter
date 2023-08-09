abstract class UserFailure {}

class InsufficientPermissions extends UserFailure {}

class UnexpectedFailure extends UserFailure {}

class UnexpectedFailureFirebase extends UserFailure {}