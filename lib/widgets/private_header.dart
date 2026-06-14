import 'package:flutter/material.dart';

class PrivateChatHeader extends StatelessWidget
    implements PreferredSizeWidget {
  final String username;
  final bool isOnline;

  const PrivateChatHeader({
    super.key,
    required this.username,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      titleSpacing: 0,
      title: Row(
        children: [
          const SizedBox(width: 12),
          const _UserAvatar(),

          const SizedBox(width: 12),

          _UserInfo(
            username: username,
            isOnline: isOnline,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 20,
      backgroundColor: Colors.blueGrey,
      child: Icon(
        Icons.person,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  final String username;
  final bool isOnline;

  const _UserInfo({
    required this.username,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          username,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: isOnline ? Colors.green : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              isOnline ? 'Online' : 'Offline',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}