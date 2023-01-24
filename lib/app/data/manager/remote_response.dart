class RemoteResponse<T> {
  RemoteResponse({required this.body, required this.status});

  final T? body;
  final RemoteStatus status;
}

class RemoteStatus {
  RemoteStatus({required this.statusCode, required this.statusMessage})
      : isError = (statusCode < 200) || (statusCode >= 300);

  final int statusCode;
  final String statusMessage;
  final bool isError;
}
