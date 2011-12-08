function FindProxyForURL(url, host) {
  if (shExpMatch(url,"*.turs.local/*")) {
    return "PROXY localhost";
  }
  return "DIRECT";
}
