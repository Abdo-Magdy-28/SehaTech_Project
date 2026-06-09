import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/cubit/Chat%20bot/ChatCubit.dart';
import 'package:grad_project/cubit/Chat%20bot/ChatStates.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/services/Chatbot%20Services/Apiservice.dart';
import 'package:grad_project/widgets/chatbot%20page/BubbleWidget.dart';
import 'package:grad_project/widgets/chatbot%20page/chatinputwidget.dart';
import 'package:grad_project/widgets/chatbot%20page/chatsuggestedbuttons.dart';
import 'package:grad_project/widgets/chatbot%20page/customchatbotappbar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatbotwidgetState();
}

class _ChatbotwidgetState extends State<ChatBotScreen> {
  late TextEditingController _controller;
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  final ScrollController _scrollController = ScrollController();
  ChatCubit? _chatCubit;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();

    if (_chatCubit != null) {
      final service = _chatCubit!.chatService;
      if (service is ChatApiService) {
        service.cancelAllRequests();
      }
      _chatCubit!.dispose();
    }

    super.dispose();
  }

  void _handleSuggestedButton(ChatCubit cubit, String buttonText) {
    // فقط إرسال الرسالة للـ API بدون رسائل ثابتة
    cubit.addUserMessage(buttonText);
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${S.of(context).failedtoselectimage}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    S.of(context).attachimage,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF0066FF).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.camera_alt, color: Color(0xFF0066FF)),
                    ),
                    title: Text(
                      S.of(context).takephoto,
                      style: TextStyle(fontFamily: 'Cairo'),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF0066FF).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.photo_library,
                        color: Color(0xFF0066FF),
                      ),
                    ),
                    title: Text(
                      S.of(context).chooseimage,
                      style: TextStyle(fontFamily: 'Cairo'),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    },
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _removeSelectedImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (_) {
        _chatCubit = ChatCubit(ChatApiService());
        return _chatCubit!;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const Customchatbotappbar(),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            final cubit = context.read<ChatCubit>();
            final hasMessages = state.messages.isNotEmpty;

            if (hasMessages) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _scrollToBottom();
              });
            }

            return Column(
              children: [
                SizedBox(width: devwidth, child: const Divider(thickness: 1)),

                Expanded(
                  child: hasMessages
                      ? ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount: state.messages.length,
                          itemBuilder: (_, i) =>
                              ChatBubble(message: state.messages[i]),
                        )
                      : _buildEmptyState(context, devheight, devwidth, cubit),
                ),

                if (_selectedImage != null)
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.blue.shade200,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _selectedImage!,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Image Selected',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                _selectedImage!.path.split('/').last,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                  fontFamily: 'Cairo',
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close_rounded, color: Colors.red),
                          onPressed: _removeSelectedImage,
                          tooltip: 'Remove image',
                        ),
                      ],
                    ),
                  ),

                Chatinputwidget(
                  controller: _controller,
                  onSend: () {
                    if (_controller.text.trim().isNotEmpty ||
                        _selectedImage != null) {
                      final message = _controller.text.trim().isEmpty
                          ? "📷 Analyze this image"
                          : _controller.text;

                      cubit.addUserMessage(message, image: _selectedImage);
                      _controller.clear();
                      _removeSelectedImage();
                    }
                  },
                  onAttachImage: _showImageSourceDialog,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    double devheight,
    double devwidth,
    ChatCubit cubit,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: devheight * 0.05),
          SizedBox(
            height: devheight * 0.2,
            child: Image.asset("assets/images/chatbot/Frame 33.png"),
          ),
          SizedBox(height: devheight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/chatbot/sparkles-sharp.svg"),
              SizedBox(width: devwidth * 0.04),
              Text(
                S.of(context).whaticanhelp,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff111111).withOpacity(0.6),
                  fontSize: 24,
                ),
              ),
            ],
          ),
          SizedBox(height: devheight * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Chatsuggestedbuttons(
                func: () =>
                    _handleSuggestedButton(cubit, S.of(context).diagnoses),
                name: S.of(context).diagnoses,
              ),
              SizedBox(width: devwidth * 0.02),
              Chatsuggestedbuttons(
                func: () =>
                    _handleSuggestedButton(cubit, S.of(context).drugprice),
                name: S.of(context).drugprice,
              ),
              SizedBox(width: devwidth * 0.02),
              Chatsuggestedbuttons(
                func: () => _handleSuggestedButton(
                  cubit,
                  S.of(context).activeingredients,
                ),
                name: S.of(context).activeingredients,
              ),
            ],
          ),
          SizedBox(height: devheight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Chatsuggestedbuttons(
                func: () => _handleSuggestedButton(
                  cubit,
                  S.of(context).diseasessymptoms,
                ),
                name: S.of(context).diseasessymptoms,
              ),
              SizedBox(width: devwidth * 0.02),
              Chatsuggestedbuttons(
                func: () => _handleSuggestedButton(
                  cubit,
                  S.of(context).chronicdiseases,
                ),
                name: S.of(context).chronicdiseases,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
