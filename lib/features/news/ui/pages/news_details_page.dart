import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:lesson_1/core/utils/date_formatter.dart';

@RoutePage()
class NewsDetailsPage extends StatelessWidget {
  const NewsDetailsPage({
    super.key,
    required this.title,
    required this.description,
    required this.author,
    required this.imageUrl,
    required this.date,
    required this.content,
  });

  final String title;
  final String description;
  final String author;
  final String imageUrl;
  final String date;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// IMAGE
              Stack(
                children: [
                  Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 320,
                    fit: BoxFit.cover,

                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return Container(
                        width: double.infinity,
                        height: 320,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.image),
                      );
                    },
                  ),

                  Positioned(
                    top: 16,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    /// TITLE
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// AUTHOR + DATE
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            author,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        Text(
                          formatDate(date),
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    /// DESCRIPTION
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// CONTENT
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}