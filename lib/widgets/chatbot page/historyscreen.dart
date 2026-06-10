import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/Chatbot%20Models/chatmodel.dart';
import 'package:grad_project/screens/chatbotScreen.dart';
import 'package:grad_project/services/Chatbot%20Services/ChatHistoryService.dart';

class Historyscreen extends StatefulWidget {
  const Historyscreen({super.key});

  @override
  State<Historyscreen> createState() => _HistoryscreenState();
}

class _HistoryscreenState extends State<Historyscreen> {
  final ChatHistoryService _service = ChatHistoryService();
  List<ChatHistoryItem> _chats = [];
  bool _isLoading = true;
  String? _error;

  final GlobalKey _menuButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  // ── Data ──────────────────────────────────────────────────────────────────

  Future<void> _loadChats() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final chats = await _service.getAllChats();
      if (mounted) setState(() => _chats = chats);
    } catch (e) {
      if (mounted) setState(() => _error = S.current.failedtoloadchats);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteChat(String chatId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          S.of(ctx).deletechat,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          S.of(ctx).deletechatconfirm,
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              S.of(ctx).cancel,
              style: const TextStyle(fontFamily: 'Cairo', color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              S.of(ctx).delete,
              style: const TextStyle(fontFamily: 'Cairo', color: Colors.red),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    final success = await _service.deleteChat(chatId);
    if (!mounted) return;
    if (success) {
      setState(() => _chats.removeWhere((c) => c.id == chatId));
      _showSnack(S.of(context).chatdeleted, Colors.green);
    } else {
      _showSnack(S.of(context).failedtodeletechat, Colors.red);
    }
  }

  Future<void> _deleteAllChats() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          S.of(ctx).removehistory,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          S.of(ctx).removehistoryconfirm,
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              S.of(ctx).cancel,
              style: const TextStyle(fontFamily: 'Cairo', color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              S.of(ctx).delete,
              style: const TextStyle(fontFamily: 'Cairo', color: Colors.red),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    for (final chat in List.from(_chats)) await _service.deleteChat(chat.id);
    if (!mounted) return;
    setState(() => _chats.clear());
    _showSnack(S.of(context).historyremoved, Colors.green);
  }

  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(fontFamily: 'Cairo')),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _openChat(ChatHistoryItem item) async {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: Color(0xFF0066FF)),
      ),
    );
    final detail = await _service.getChatContent(item.id);
    if (!mounted) return;
    Navigator.pop(context);
    if (detail == null) {
      _showSnack(S.of(context).couldnotloadchat, Colors.red);
      return;
    }
    final msgs = detail.messages
        .map(
          (m) => ChatMessage(
            text: m.content,
            isUser: m.role == 'user',
            timestamp: m.timestamp,
          ),
        )
        .toList();
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ChatBotScreen(initialChatId: item.id, initialMessages: msgs),
      ),
    );
  }

  // ── Popup anchored correctly regardless of RTL ────────────────────────────
  void _showAppBarMenu() {
    final RenderBox btn =
        _menuButtonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;

    // btn position in overlay coordinates
    final Offset btnOrigin = btn.localToGlobal(Offset.zero, ancestor: overlay);
    final double screenW = overlay.size.width;
    const double popupW = 190.0;
    const double popupH = 100.0; // approx
    const double gap = 6.0;

    // Align popup's right edge with button's right edge, clamped inside screen
    double right = screenW - btnOrigin.dx - btn.size.width;
    right = right.clamp(8.0, screenW - popupW - 8.0);
    final double top = btnOrigin.dy + btn.size.height + gap;

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      builder: (ctx) => Stack(
        children: [
          Positioned(
            top: top,
            right: right,
            width: popupW,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // New Chat
                  InkWell(
                    onTap: () {
                      Navigator.pop(ctx);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChatBotScreen(),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/chatbot/New Chat.svg',
                            width: 20,
                            height: 20,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF0066FF),
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            S.of(context).newchat,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF111111),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Remove History — red background
                  InkWell(
                    onTap: () {
                      Navigator.pop(ctx);
                      _deleteAllChats();
                    },
                    child: Container(
                      color: const Color(0xFFE53935),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/chatbot/Create.svg',
                            width: 20,
                            height: 20,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            S.of(context).removehistory,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
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

  // ── Date helper ───────────────────────────────────────────────────────────

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) {
      if (diff.inHours == 0) return S.current.minutesago(diff.inMinutes);
      return S.current.hoursago(diff.inHours);
    } else if (diff.inDays == 1) {
      return S.current.yesterday;
    } else if (diff.inDays < 7) {
      return S.current.daysago(diff.inDays);
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Use a custom title bar so we fully control left / right slots
      // regardless of RTL — back arrow always on the leading side,
      // + button always on the trailing side.
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            // ── Back arrow (leading — respects RTL automatically) ──────────
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFF111111),
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),

            // ── Title centred ──────────────────────────────────────────────
            const Expanded(
              child: Text(
                // Hardcode fallback; runtime will use S.of(context).allchats
                'All Chats',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
                  fontSize: 20,
                ),
              ),
            ),

            // ── + button — always right edge ───────────────────────────────
            GestureDetector(
              key: _menuButtonKey,
              onTap: _showAppBarMenu,
              child: Container(
                width: 34,
                height: 34,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
                child: Icon(Icons.add, color: Colors.black, size: 20),
              ),
            ),
          ],
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF0066FF)),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_rounded,
              size: 56,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              _error!,
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.grey.shade600,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadChats,
              icon: const Icon(Icons.refresh),
              label: Text(
                S.of(context).tryagain,
                style: const TextStyle(fontFamily: 'Cairo'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (_chats.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/chatbot/Caht-Bot01.svg',
              width: 80,
              height: 80,
              colorFilter: ColorFilter.mode(
                Colors.grey.shade300,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              S.of(context).nopreviouschats,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).startnewconversation,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatBotScreen()),
                );
              },
              icon: const Icon(Icons.add),
              label: Text(
                S.of(context).newchat,
                style: const TextStyle(fontFamily: 'Cairo'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066FF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadChats,
      color: const Color(0xFF0066FF),
      child: Column(
        children: [
          // ── top black border ──────────────────────────────────────────────
          const Divider(height: 1, thickness: 1, color: Color(0xFF111111)),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: _chats.length,
              separatorBuilder: (_, __) => const Divider(
                height: 1,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: Colors.grey,
              ),
              itemBuilder: (_, i) => _ChatHistoryTile(
                item: _chats[i],
                formattedDate: _formatDate(_chats[i].updatedAt),
                onTap: () => _openChat(_chats[i]),
                onDismissed: () => _deleteChat(_chats[i].id),
              ),
            ),
          ),
          // ── bottom black border ───────────────────────────────────────────
          const Divider(height: 1, thickness: 1, color: Color(0xFF111111)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tile — bot avatar + title + time
// ─────────────────────────────────────────────────────────────────────────────
class _ChatHistoryTile extends StatelessWidget {
  final ChatHistoryItem item;
  final String formattedDate;
  final VoidCallback onTap;
  final VoidCallback onDismissed;

  const _ChatHistoryTile({
    required this.item,
    required this.formattedDate,
    required this.onTap,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;

    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      confirmDismiss: (_) async {
        onDismissed();
        return false;
      },
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 13),
          child: Row(
            children: [
              // Bot icon — no circle background
              SvgPicture.asset(
                'assets/images/chatbot/Caht-Bot01.svg',
                width: 44,
                height: 44,
              ),

              const SizedBox(width: 12),

              // Title
              Expanded(
                child: Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Color(0xFF111111),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Time (trailing)
              Text(
                formattedDate,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(width: 15),

              // Delete button
              GestureDetector(
                onTap: onDismissed,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
