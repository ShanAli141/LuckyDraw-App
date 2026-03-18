import 'package:flutter/material.dart';
import 'package:luckywinner/core/theme/app_button.dart';

import '../../../../core/widgets/app_button.dart';

class ParticipantInputBar extends StatefulWidget {
  final Future<void> Function(String name) onSubmit;

  const ParticipantInputBar({
    super.key,
    required this.onSubmit,
  });

  @override
  State<ParticipantInputBar> createState() => _ParticipantInputBarState();
}

class _ParticipantInputBarState extends State<ParticipantInputBar> {
  final _controller = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isSubmitting) return;

    setState(() => _isSubmitting = true);
    await widget.onSubmit(text);
    _controller.clear();
    setState(() => _isSubmitting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextField(
            controller: _controller,
            hintText: 'Enter participant name',
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _handleSubmit(),
          ),
        ),
        const SizedBox(width: 8),
        AppButton(
          label: _isSubmitting ? 'Adding...' : 'Add',
          onPressed: _isSubmitting ? null : _handleSubmit,
        ),
      ],
    );
  }
}