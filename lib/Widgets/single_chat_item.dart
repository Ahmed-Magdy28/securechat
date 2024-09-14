import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:securechat/providers/user_provider.dart';

Widget singleChatItem({
  required BuildContext context,
  required List<QueryDocumentSnapshot<Map<String, dynamic>>> allMessages,
  required int index,
}) {
  String text = allMessages[index]["text"];
  String userIdHere = Provider.of<UserProvider>(context, listen: false).userId;
  String senderName = allMessages[index]["sender_name"];
  String senderId = allMessages[index]["sender_id"];
  String timeNow = allMessages[index]["timeNow"];
  bool isCurrentUser = (senderId == userIdHere);

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 6), // Smaller padding
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blue[100] : Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align name to the left
            children: [
              if (!isCurrentUser) // Show the sender's name only if it's not the current user
                Text(
                  senderName,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 4),
              Text(
                text,
                textAlign: TextAlign.center, // Center the text
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  timeNow,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
