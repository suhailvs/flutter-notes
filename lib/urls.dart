const String BASE_URL = '192.168.43.227:8000';

urlDeleteUpdate(int id) {
  return Uri.http(BASE_URL, '/users/$id/');
}

urlRetrieveCreate() {
  return Uri.http(BASE_URL, '/users/');
}
