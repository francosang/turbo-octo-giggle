import 'dart:convert';
import 'dart:io';

// Client for test/dev purposes only.
void main(List<String> arguments) async {
  final connection = await Socket.connect('localhost', 5550);

  final sub = readLine().listen((data) {
    connection.write(data);
  });

  connection.listen(
    (data) {
      final msg = String.fromCharCodes(data);
      print('Server: $msg');
    },
    onDone: () {
      connection.close();
      sub.cancel();
      print("Desconectado");
    },
    onError: (error) {
      connection.close();
      sub.cancel();
      print("Error");
    },
  );
}

Stream<String> readLine() =>
    stdin.transform(utf8.decoder).transform(const LineSplitter());
