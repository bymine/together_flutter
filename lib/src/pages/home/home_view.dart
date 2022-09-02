import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:search_page/search_page.dart';
import 'package:together_flutter/src/constants/api_constants.dart';
import 'package:together_flutter/src/constants/color_constants.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/controllers/home/home_controller.dart';
import 'package:together_flutter/src/controllers/home/search_project_controller.dart';
import 'package:together_flutter/src/models/project.dart';
import 'package:together_flutter/src/pages/home/widget/project_card_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Together",
          style: TextStyle(
              fontSize: 14, color: subColor, fontStyle: FontStyle.italic),
        ),
        actions: [
          IconButton(
              onPressed: () => Get.toNamed('/AddProject'),
              icon: const Icon(LineIcons.folderPlus)),
          IconButton(
              onPressed: () {
                showSearchPage(context);
              },
              icon: const Icon(LineIcons.search)),
        ],
      ),
      body: Obx(() {
        if (controller.firebaseCode.value == FirebaseCode.loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: subColor,
          ));
        } else if (controller.firebaseCode.value == FirebaseCode.failed) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("예상치 못한 오류가 발생했습니다"),
                const SizedBox(
                  height: kSmallSpace,
                ),
                InkWell(
                  onTap: () {
                    controller.loadProjects();
                  },
                  customBorder: const CircleBorder(),
                  splashColor: Colors.red,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 1,
                              spreadRadius: 1)
                        ]),
                    child: const Icon(Icons.sync),
                  ),
                )
              ],
            ),
          );
        } else if (controller.firebaseCode.value == FirebaseCode.success) {
          return Obx(
            () => Swiper(
              itemCount: controller.projects.length,
              layout: SwiperLayout.DEFAULT,
              viewportFraction: 0.8,
              scale: 0.8,
              loop: controller.projects.length > 1 ? true : false,
              pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 20),
                  builder: DotSwiperPaginationBuilder(
                      color: Colors.grey, activeColor: subColor)),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Get.toNamed('/MainProject',
                          arguments: controller.projects[index].id);
                    },
                    child: ProjectCard(project: controller.projects[index]));
              },
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }

  void showSearchPage(BuildContext context) {
    Get.put(SearchProjectController());
    showSearch(
      context: context,
      delegate: SearchPage<Project>(
        searchLabel: "프로젝트 검색",
        barTheme: ThemeData(
            inputDecorationTheme: const InputDecorationTheme(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
            ),
            appBarTheme: const AppBarTheme(
                centerTitle: true,
                color: Colors.transparent,
                elevation: 0,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                iconTheme: IconThemeData(color: Colors.black)),
            textSelectionTheme:
                const TextSelectionThemeData(cursorColor: subColor)),
        showItemsOnEmpty: true,
        builder: (project) => Column(
          children: [
            const Divider(),
            ListTile(
              onTap: () {
                Get.toNamed('/ShowProject', arguments: project);
              },
              minLeadingWidth: 40,
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(project.profile!),
                        fit: BoxFit.fill)),
              ),
              title: Text(
                project.title,
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ],
        ),
        filter: (project) {
          List<String> list = [];
          for (var element in SearchProjectController.to.projects) {
            if (element.title.contains(project.title)) {
              list.add(element.title);
            }
          }
          return list;
        },
        failure: const Center(
          child: Text(
            '일치하는 프로젝트가 없습니다',
            style: TextStyle(color: borderColor),
          ),
        ),
        items: SearchProjectController.to.projects,
      ),
    );
  }
}
