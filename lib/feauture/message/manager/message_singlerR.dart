
import 'package:graduation2/core/utils/pref_helpers.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class SignalRService {
  HubConnection? _hubConnection;

  // وظيفة بتبعتلها الـ Function اللي هتتنفذ لما رسالة تيجي
  Future<void> initSignalR(Function(dynamic) onMessageReceived) async {
    final token = await PrefHelpers.getToken();

    _hubConnection = HubConnectionBuilder()
        .withUrl("https://craftoriagp.runasp.net/chatHub",
        options: HttpConnectionOptions(
          accessTokenFactory: () async => token!,
        ))
        .build();

    await _hubConnection?.start();

    // السماع لحدث وصول رسالة جديدة (بناءً على صفحة 6)
    _hubConnection?.on("SendMessageToUser", (arguments) {
      if (arguments != null) {
        onMessageReceived(arguments[0]);
      }
    });
  }

  void stopConnection() => _hubConnection?.stop();
}