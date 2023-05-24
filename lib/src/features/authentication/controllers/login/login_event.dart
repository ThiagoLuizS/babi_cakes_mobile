abstract class LoginEvent {}

class LoadLoginEvent extends LoginEvent {
  late String email;
  late String password;
  LoadLoginEvent({required this.email, required this.password});
}

class LoadSignGoogleEvent extends LoginEvent {
  LoadSignGoogleEvent();
}