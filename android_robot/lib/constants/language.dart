class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);

  static const languages = const [
    const Language('Arabic', 'ar-EG'),
    const Language('English', 'en-US'),
  ];
}
