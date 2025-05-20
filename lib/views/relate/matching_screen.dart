import 'package:laatte/common_libs.dart';

class MatchingScreen extends StatefulWidget {
  static const String route = "/MatchingScreen";
  const MatchingScreen({super.key, required this.chatId});
  final String chatId;
  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  //  context.read<SocketBloc>().add(
  //                                           SocketMessage(
  //                                               chatId: v, setChatID: true));
  //                                       context.push(Routes.chatMessages,
  //                                           extra: v);
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
