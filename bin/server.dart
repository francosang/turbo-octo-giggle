import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

final world = World();

final List<Socket> clients = [];

void main(List<String> arguments) async {
  print('Iniciando server...');

  final server = await ServerSocket.bind(InternetAddress.anyIPv4, 5550);

  print('Servidor iniciado!');

  server.listen((client) {
    clients.add(client);
    handleClientConnection(client);
  });
}

void handleClientConnection(Socket client) {
  final id = uuid.v4();

  print('Cliente conectado a nuestro server $id');

  final player = Player();
  world.players[id] = player;

  client.write(id);

  print('$world');

  client.listen(
    (data) {
      final msg = String.fromCharCodes(data);
      final parts = msg.split(',');

      final id = parts[0];
      final x = int.parse(parts[1]);
      final y = int.parse(parts[2]);

      world.players[id]?.coordinates = Coordinates(x: x, y: y);

      final worldJson = world.toJson();

      for (var element in clients) {
        if (element == client) continue;

        element.write(worldJson);
      }

      print('$world');
    },
    onDone: () {
      onDisconnected(id);

      client.close();
    },
    onError: (error) {
      onDisconnected(id);

      client.close();
    },
  );
}

void onDisconnected(String id) {
  world.players.remove(id);

  print('$world');
}

class World {
  final Map<String, Player> players = HashMap();

  @override
  String toString() {
    return players.toString();
  }

  String toJson() {
    return jsonEncode({
      "players": players.map((key, value) => MapEntry(key, value.toJson()))
    });
  }
}

class Player {
  Coordinates? coordinates;

  @override
  String toString() {
    return '(coods: $coordinates)';
  }

  String toJson() {
    return jsonEncode({
      "c": coordinates?.toJson(),
    });
  }
}

class Coordinates {
  final int x;
  final int y;

  Coordinates({
    required this.x,
    required this.y,
  });

  @override
  String toString() {
    return '($x, $y)';
  }

  String toJson() {
    return jsonEncode({
      "x": x,
      "y": y,
    });
  }
}
