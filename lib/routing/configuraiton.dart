class Configuration {
  final String? path;
  final Map<String, String>? pathParams;

  Configuration.home()
      : path = null,
        pathParams = null;

  Configuration.otherPage(this.path, this.pathParams);

  bool get isHomePage => path == null;
  bool get isOtherPage => path != null;

  @override
  String toString() {
    return '${path ?? ''}__$pathParams';
  }
}
