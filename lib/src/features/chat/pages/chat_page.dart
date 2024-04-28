import '../../../config/index.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;

class ChatPage extends StatefulWidget {
  static const String path = '/chat';
  const ChatPage({super.key, String? userEmail});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final _listController = chat.StreamChannelListController(
    client: chat.StreamChat.of(context).client,
    // filter: Filter._in(
    //   'members',
    //   [chat.StreamChat.of(context).currentUser!.id],
    // ),
    // sort: const [chat.SortOption('last_message_at')],
    limit: 20,
  );

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return chat.StreamChannelListView(
        controller: _listController,
        onChannelTap: (channel) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return chat.StreamChannel(
                  channel: channel,
                  child: const ChannelPage(),
                );
              },
            ),
          );
        });
  }
}
