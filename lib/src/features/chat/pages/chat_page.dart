import '../../../config/index.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;

class ChatPage extends StatelessWidget {
  static const String path = '/chat';
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Chat',
        addBackButton: false,
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final chat.StreamChannelListController _listController = chat.StreamChannelListController(
    client: chat.StreamChat.of(context).client,
    // filter: Filter._in(
    //   'members',
    //   [chat.StreamChat.of(context).currentUser!.id],
    // ),
    // sort: const [chat.SortOption('last_message_at')],
    limit: 20,
  );

  @override
  Widget build(BuildContext context) {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    return chat.StreamChannelListView(
      controller: _listController,
      onChannelTap: (channel) {
        router.launchChannel(arguments: ChannelArgs(channel: channel));
      },
      addAutomaticKeepAlives: true,
    );
  }
}
