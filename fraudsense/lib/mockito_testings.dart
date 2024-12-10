class ClassToBeMocked {
  String functionToBeMocked(int zero) {
    if (zero == 0) {
      return 'zero';
    }
    if (zero == 1) throw Exception('error');
    return 'non-zero';
  }

  Future<String> functionToBeMocked2(int zero) async {
    await Future.delayed(const Duration(seconds: 1));

    if (zero == 0) {
      return 'zero';
    }
    if (zero == 1) throw Exception('error');
    return 'non-zero';
  }
}
