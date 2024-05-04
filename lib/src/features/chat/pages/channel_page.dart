import '../../../config/index.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;

class ChannelArgs {
  final chat.Channel channel;
  const ChannelArgs({required this.channel});
}

class ChannelPage extends StatelessWidget {
  static const String path = '/channel';
  const ChannelPage({super.key});
  @override
  Widget build(BuildContext context) {
    final ChannelArgs args = ModalRoute.of(context)?.settings.arguments as ChannelArgs;
    return chat.StreamChannel(
      channel: args.channel,
      child: const Scaffold(
        appBar: chat.StreamChannelHeader(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: chat.StreamMessageListView(),
            ),
            chat.StreamMessageInput(),
          ],
        ),
      ),
    );
  }
}
