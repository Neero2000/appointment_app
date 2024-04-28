import '../../../config/index.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: chat.StreamChannelHeader(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: chat.StreamMessageListView(),
          ),
          chat.StreamMessageInput(),
        ],
      ),
    );
  }
}
