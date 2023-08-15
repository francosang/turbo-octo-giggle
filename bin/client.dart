import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

// Client for test/dev purposes only.
void main(List<String> arguments) {
  Socket.connect('localhost', 5550).then((connection) {
    final sub = readLine().listen((data) {
      connection.write(data);
    });

    connection.listen(
      (Uint8List data) {
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
  });
}

Stream<String> readLine() =>
    stdin.transform(utf8.decoder).transform(const LineSplitter());
