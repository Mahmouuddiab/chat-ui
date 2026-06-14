import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircleAvatar(
        child: Text('M'),
      ),
      title: Text('Mahmoud Diab'),
      subtitle: Text('Online'),
    );
  }
}