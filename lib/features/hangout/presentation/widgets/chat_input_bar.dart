import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Chat Input Bar Widget
class ChatInputBar extends StatefulWidget {
  final Function(String) onSend;

  const ChatInputBar({
    super.key,
    required this.onSend,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSend() {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      widget.onSend(message);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.add,
                color: AppColors.hangoutMode,
                size: 24,
              ),
              onPressed: () {
                // Handle add action
              },
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: AppColors.textHint,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
                onSubmitted: (_) => _onSend(),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.send,
                color: AppColors.hangoutMode,
                size: 24,
              ),
              onPressed: _onSend,
            ),
          ],
        ),
      ),
    );
  }
}

