mixin ValidatorsMixin {
  String? isNotEmpty(String? value, [String? message]) {
    if (value!.isEmpty) return message ?? 'Required Field';
    return null;
  }
}
