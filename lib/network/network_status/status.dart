enum Status {
  none,
  done,
  error,
  awaits
}

Status mapToStatus(String statusString) {
  Status status = Status.none;
  switch(statusString) {
    case "done": 
      status = Status.done;
      break;
    case "error":
      status = Status.error;
      break;
    case "wait":
      status = Status.awaits;
      break;
  }

  return status;
}