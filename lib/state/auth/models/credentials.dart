class Credential {
  final String? userName;
  final String password;
  final String email;
  final String? profileUrl;

  const Credential({
    this.userName,
    required this.password,
    required this.email,
    this.profileUrl,
  });

  Credential.empty()
      : userName = '',
        password = '',
        email = '',
        profileUrl = '';

  Credential copyWith({
    String? userName,
    String? password,
    String? email,
    String? profileUrl,
  }) {
    return Credential(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      email: email ?? this.email,
      profileUrl: profileUrl ?? this.profileUrl,
    );
  }
}
