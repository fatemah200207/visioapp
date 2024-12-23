import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {"question": "How do I get started with editing my photo?", "answer": "Open the app, upload a photo, and start editing using the tools provided."},
    {"question": "What file formats does the app support?", "answer": "The app supports JPEG, PNG, and TIFF formats."},
    {"question": "How do I apply a filter to my photo?", "answer": "Select a photo, go to filters, and choose from the available options."},
    {"question": "How do I remove an object or person from a photo?", "answer": "Use the object removal tool in the editing menu."},
    {"question": "Does the app support layers for advanced editing?", "answer": "Yes, layers can be added through the advanced tools section."},
    {"question": "How do I save my edited photo?", "answer": "Click on the save button, and the photo will be stored in your gallery."},
    {"question": "The app crashed or isn’t working properly. What should I do?", "answer": "Try restarting the app. If the problem persists, contact support."},
    {"question": "How do I report a bug or suggest a feature?", "answer": "Go to the settings menu and select 'Feedback' to send your suggestions."},
    {"question": "Is my data safe on this app?", "answer": "Yes, your data is encrypted and securely stored."},
    {"question": "Can I access my edited photos on other devices?", "answer": "Yes, log in with your account to sync your photos across devices."},
    {"question": "Do I need to create an account to use the app?", "answer": "No, you can use the app without an account, but some features require signing in."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'FAQ',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB2EBF2), Color(0xFFFFCDD2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB2EBF2), Color(0xFFFFCDD2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ExpansionTile(
                leading: const Icon(Icons.circle, color: Colors.green, size: 12),
                tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Text(
                  faqs[index]['question']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                trailing: const Icon(Icons.expand_more),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      faqs[index]['answer']!,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
