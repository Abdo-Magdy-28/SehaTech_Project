import 'package:grad_project/cubit/Chat%20bot/ChatCubit.dart';
import 'dart:io';

abstract class ChatService {
  Future<void> sendMessage(String message, ChatCubit cubit, {File? image});
}
