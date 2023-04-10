class WebServerException implements Exception {

  final String error;

  const WebServerException({required this.error});
}