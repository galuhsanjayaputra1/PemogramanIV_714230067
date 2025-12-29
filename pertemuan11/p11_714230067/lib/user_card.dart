import 'package:flutter/material.dart';
import 'user.dart';

class UserCard extends StatelessWidget {
  final UserCreate usrCreate;

  const UserCard({super.key, required this.usrCreate});

  @override
  Widget build(BuildContext context) {
    final isUpdate = usrCreate.updatedAt != null;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isUpdate ? Colors.orange[200] : Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUpdate) _row('ID', usrCreate.id),
          _row('Name', usrCreate.name),
          _row('Job', usrCreate.job),
          _row(isUpdate ? 'Updated At' : 'Created At',
              isUpdate ? usrCreate.updatedAt : usrCreate.createdAt),
        ],
      ),
    );
  }

  Widget _row(String label, String? value) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(child: Text(': $value')),
      ],
    );
  }
}
