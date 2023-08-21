import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkati/new_code/extensions/date_format_extension.dart';
import 'package:linkati/new_code/screens/add_media_link_screen.dart';

import '../managers/cloud_manager.dart';
import '../models/social_media_link.dart';
import 'media_link_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CloudManager cloudManager = CloudManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("قروباتي")),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: cloudManager.linksCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No social media links available.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var linkData =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              var link = SocialMediaLink.fromJson(linkData);

              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MediaLinkDetailScreen(),
                  ));
                },
                child: Card(
                  child: ListTile(
                    title: Text(link.title),
                    subtitle: Text(link.createDt.formatTimeAgoString()),
                    trailing: Text('${link.views} مشاهدة'),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddMediaLinkScreen(),
          ));
        },
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
