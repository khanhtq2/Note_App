// presentation/widgets/ai_action_button.dart
import 'package:flutter/material.dart';

class AIActionButton extends StatelessWidget {
  const AIActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.auto_awesome, color: Colors.deepPurpleAccent),
      onPressed: () {
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("AI đang sẵn sàng hỗ trợ!")),
        );
      },
      tooltip: 'Trợ lý AI',
    );
  }
}
