class RegisterParams {
  final String name;
  final String email;
  final String password;
  final String rePassword;
  final String phone;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
  });
}
