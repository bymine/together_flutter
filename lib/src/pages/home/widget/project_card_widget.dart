import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 60),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
              image: CachedNetworkImageProvider(project.profile!),
              fit: BoxFit.fill)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            project.title,
            maxLines: 2,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: kSmallSpace,
          ),
          Text(
            project.note,
            maxLines: 1,
            style: const TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
