import 'package:graduation2/core/utils/pref_helpers.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class SignalRService {
  HubConnection? _hubConnection;
 bool _isConnected = false;
  // وظيفة بتبعتلها الـ Function اللي هتتنفذ لما رسالة تيجي
  // Future<void> initSignalR(Function(dynamic) onMessageReceived) async {
  //   final token = await PrefHelpers.getToken();

  //   _hubConnection = HubConnectionBuilder()
  //       .withUrl(
  //         "https://craftoriagp.runasp.net/chatHub",
  //         options: HttpConnectionOptions(
  //           accessTokenFactory: () async => token!,
  //         ),
  //       )
  //       .build();

  //   await _hubConnection?.start();

  //   // السماع لحدث وصول رسالة جديدة (بناءً على صفحة 6)
  //   _hubConnection?.on("SendMessageToUser", (arguments) {
  //     print("✅ SignalR Event Received: $arguments");
  //     if (arguments != null) {
  //       onMessageReceived(arguments[0]);
  //     }
  //   });
  // }
  // Future<void> initSignalR(Function(dynamic) onMessageReceived) async {
  //    if (_isConnected) return;
  //   final token = await PrefHelpers.getToken();

  //   _hubConnection = HubConnectionBuilder()
  //       .withUrl(
  //         "https://craftoriagp.runasp.net/hubs/chat",
  //         options: HttpConnectionOptions(
  //           accessTokenFactory: () async => token!,
  //         ),
  //       )
  //       .build();

  //   // إحاطة الـ start بـ try-catch لمنع الـ 404 من تعطيل الـ Cubit
  //   try {
  //     await _hubConnection?.start();
  //     print("✅ SignalR Connected Successfully");
  //   } catch (e) {
  //     print("❌ SignalR Connection Failed (But Chat API will still work): $e");
  //   }

  //   // السماع لحدث وصول رسالة جديدة
  //   // _hubConnection?.on("SendMessageToUser", (arguments) {
  //   //   print("✅ SignalR Event Received: $arguments");
  //   //   if (arguments != null) {
  //   //     onMessageReceived(arguments[0]);
  //   //   }
  //   // });
  //   _hubConnection?.on("ReceiveMessage", (arguments) {
  //     print("✅ SignalR Event Received Raw Arguments: $arguments");

  //     // 🔹 التعديل هنا: يجب التأكد أن الـ arguments ليست فارغة ونمرر arguments[0]
  //     if (arguments != null && arguments.isNotEmpty) {
  //       onMessageReceived(
  //         arguments[0],
  //       ); // مرري العنصر الأول فقط [0] وليس القائمة كاملة
  //     }
  //   });

  //    _hubConnection?.on("ReceiveMessage", (arguments) { // 🔹 جربي "ReceiveMessage"
  //     print("✅ SignalR Event Received: $arguments");
  //     if (arguments != null && arguments.isNotEmpty) {
  //       onMessageReceived(arguments[0]);
  //     }
  //   });
  // }
Future<void> initSignalR(Function(dynamic) onMessageReceived) async {
  final token = await PrefHelpers.getToken();
  _hubConnection = HubConnectionBuilder()
      .withUrl(
        "https://craftoriagp.runasp.net/hubs/chat",
        options: HttpConnectionOptions(
          accessTokenFactory: () async => token!,
        ),
      )
      .build();

  try {
    await _hubConnection?.start();
    print("✅ SignalR Connected Successfully");
  } catch (e) {
    print("❌ SignalR Connection Failed: $e");
  }

  // ✅ الاسم الصح من الباك
  _hubConnection?.on("ReceiveMessage", (arguments) {
    print("✅ SignalR ReceiveMessage: $arguments");
    if (arguments != null && arguments.isNotEmpty) {
      onMessageReceived(arguments[0]);
    }
  });
}
  void stopConnection() => _hubConnection?.stop();
}
