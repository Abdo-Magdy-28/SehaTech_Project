import 'package:grad_project/cubit/Chat%20bot/ChatCubit.dart';

abstract class ChatService {
  Future<void> sendMessage(String message, ChatCubit cubit);

  void runDiseaseSymptomsIntro(ChatCubit cubit);
  void runDiagnosesIntro(ChatCubit cubit);
  void runDrugPriceIntro(ChatCubit cubit);
  void runActiveIngredientIntro(ChatCubit cubit);
  void runChronicDiseasesIntro(ChatCubit cubit);
}
