import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:together_flutter/src/constants/dimen_constants.dart';
import 'package:together_flutter/src/controllers/file/file_controller.dart';
import 'package:together_flutter/src/models/file.dart';
import 'package:together_flutter/src/pages/file/detail_folder_page.dart';

class FileView extends StatelessWidget {
  const FileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("프로젝트 파일"),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed('/AddFile');
              },
              icon: LineIcon(LineIcons.alternateCloudUpload))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
              top: kHorizontalPadding,
              left: kHorizontalPadding,
              right: kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FilePieChart(),
              const SizedBox(
                height: kSmallSpace,
              ),
              const FileFolder(),
              const SizedBox(
                height: kSmallSpace,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "최근 파일",
                    style: TextStyle(fontSize: 16),
                  ),
                  LatestFileListView()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LatestFileListView extends GetView<FileController> {
  const LatestFileListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.latestFiles.isEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("최근 파일이 없습니다."),
          ],
        );
      } else {
        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.latestFiles.length,
            itemBuilder: (context, index) {
              return FileListTile(
                fileData: controller.latestFiles[index],
              );
            });
      }
    });
  }
}

class FilePieChart extends GetView<FileController> {
  const FilePieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          PieChart(
            colorList: controller.chartColor,
            dataMap: controller.folderMap,
            chartType: ChartType.ring,
            chartRadius: Get.width * 0.2,
            ringStrokeWidth: 10,
            chartValuesOptions: const ChartValuesOptions(
                chartValueBackgroundColor: Colors.transparent,
                showChartValuesInPercentage: true),
            legendOptions: const LegendOptions(showLegends: false),
          ),
          SizedBox(
            width: Get.width * 0.1,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                controller.folders.length,
                (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 6,
                            backgroundColor: controller.folders[index].color
                                .withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              controller.folders[index].fileMap.keys.first,
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            ),
                          ),
                          Text(
                            "${controller.folders[index].fileMap.values.first.toStringAsFixed(0)} Files",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    )),
          ))
        ],
      ),
    );
  }
}

class FileFolder extends GetView<FileController> {
  const FileFolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            controller.folders.length,
            (index) => GestureDetector(
                onTap: () {
                  controller.selectFolder(index);
                },
                child: FolderCardBox(folder: controller.folders[index])),
          ),
        ),
      ),
    );
  }
}

class FolderCardBox extends StatelessWidget {
  const FolderCardBox({Key? key, required this.folder}) : super(key: key);

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: folder.color.withOpacity(0.3),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 1),
          ]),
      width: Get.width * 0.30,
      height: Get.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Icon(
              folder.icon,
              color: folder.color,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Text(
            folder.fileMap.keys.first,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            "${folder.fileMap.values.first.toStringAsFixed(0)} Files",
            style: const TextStyle(color: Colors.black54),
          ),
          if (folder.folderSize != 0)
            Text(
              "${folder.folderSize.toStringAsFixed(2)}MB",
              style: const TextStyle(color: Colors.black54),
            ),
          const Spacer(),
        ],
      ),
    );
  }
}
