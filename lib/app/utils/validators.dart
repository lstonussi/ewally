validatorIsEmpty(String value) {
  if (value.isEmpty) {
    return 'Campo obrigatório.';
  }
  return null;
}

String validatorLogin(String value) {
  if (value.isEmpty || !value.contains('@')) {
    return 'Login é obrigatório.';
  }
  return null;
}

String validatorPass(String value) {
  if (value.isEmpty || value.length < 5) {
    return 'Informe uma senha válida, maior que 5 letras.';
  }
  return null;
}
