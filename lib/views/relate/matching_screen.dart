import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/routes.dart';
import 'package:laatte/services/api_services.dart';
import 'package:laatte/ui/theme/buttons.dart';
import 'package:laatte/ui/theme/text.dart';
import 'package:laatte/ui/widgets/progress_circle.dart';
import 'package:laatte/utils/assets_names.dart';
import 'package:laatte/utils/design_colors.dart';
import 'package:laatte/utils/extensions.dart';
import 'package:laatte/viewmodel/bloc/socket_bloc.dart';
import 'package:laatte/viewmodel/model/chat_start.dart';

class MatchingScreen extends StatefulWidget {
  static const String route = "/MatchingScreen";
  const MatchingScreen({super.key, required this.chatStart});
  final ChatStart chatStart;
  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AssetsName.pngBg,
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const DesignText.title(
                    "It's a Match!",
                    textAlign: TextAlign.center,
                    fontSize: 24,
                    fontWeight: 600,
                    color: Colors.white,
                  ),
                  40.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.chatStart.user1?.profilePicture ??
                              "https://avatar.iran.liara.run/public/boy?username=Ash",
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.chatStart.user2?.profilePicture ??
                              "https://avatar.iran.liara.run/public/boy?username=Ash",
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  40.height,
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: DesignButtons(
                      color: DesignColor.latteOrangeLight1,
                      elevation: 0,
                      fontSize: 16,
                      fontWeight: 500,
                      colorText: Colors.white,
                      isTappedNotifier: ValueNotifier<bool>(false),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        context.read<SocketBloc>().add(SocketMessage(
                            chatId: widget.chatStart.id, setChatID: true));
                        await ApiService().chatSend(
                          chatId: widget.chatStart.id!,
                          message: "Hi 👋",
                        );
                        if (!context.mounted) return;
                        setState(() {
                          isLoading = false;
                        });
                        context.pop();
                        context.push(Routes.chatMessages,
                            extra: widget.chatStart.id);
                      },
                      textLabel: "Say Hi 👋",
                      child: isLoading
                          ? const DesignProgress()
                          : const DesignText(
                              "Say Hi 👋",
                              fontSize: 16,
                              fontWeight: 500,
                              color: Colors.black,
                            ),
                    ),
                  ),
                  10.height,
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: DesignButtons(
                      color: DesignColor.latteOrangeLight1,
                      elevation: 0,
                      fontSize: 16,
                      fontWeight: 500,
                      colorText: Colors.white,
                      isTappedNotifier: ValueNotifier<bool>(false),
                      onPressed: () async {
                        context.pop();
                      },
                      textLabel: "Keep Exploring",
                      child: const DesignText(
                        "Keep Exploring",
                        fontSize: 16,
                        fontWeight: 500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
