class AuthException implements Exception {
  static const Map<String, String> erros = {
    '400': 'Credenciais errada',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida!',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Tente novamente mais tarde!',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado.',
    'INVALID_PASSWORD': 'Senha inválida.',
    'USER_DISABLED': 'Usuário desativado.'
  };

  final String key;
  const AuthException(this.key);

  @override
  String toString() {
    if (erros.containsKey(key)) {
      return erros[key];
    } else
      return 'Ocorreu um erro na autenticação.';
  }
}
