abstract class ChangePasswordState {
  const ChangePasswordState();
}

class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial();
}

class ChangePasswordLoading extends ChangePasswordState {
  const ChangePasswordLoading();
}

class ChangePasswordSuccess extends ChangePasswordState {
  final String token;
  const ChangePasswordSuccess({required this.token});
}

class ChangePasswordFailure extends ChangePasswordState {
  /// مش بنبعت message مباشرة — بنبعت key نترجمه في الـ UI
  final String messageKey;
  const ChangePasswordFailure({required this.messageKey});
}
