import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum UploadType { photo, media, document }

class Folder {
  Map<String, double> fileMap;
  Color color;
  IconData icon;
  double folderSize;
  List<ProjectFile> files;

  Folder(
      {required this.fileMap,
      required this.color,
      required this.icon,
      required this.folderSize,
      required this.files});
}

class ProjectFile {
  String? id;
  String title;
  UploadType fileType;
  double mbSize;
  Timestamp date;
  String writer;
  String downloadUrl;

  ProjectFile(
      {this.id,
      required this.title,
      required this.fileType,
      required this.mbSize,
      required this.date,
      required this.writer,
      required this.downloadUrl});

  Map<String, dynamic> toMap() {
    return {
      "file_title": title,
      "file_type": formatFileTypeToString(fileType),
      "file_size": mbSize,
      "file_date": date,
      "file_writer": writer,
      "file_downloadUrl": downloadUrl
    };
  }

  factory ProjectFile.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    var json = document.data();

    UploadType uploadType;
    if (json['file_type'] == "document") {
      uploadType = UploadType.document;
    } else if (json['file_type'] == "photo") {
      uploadType = UploadType.photo;
    } else {
      uploadType = UploadType.media;
    }

    return ProjectFile(
        id: document.id,
        title: json['file_title'],
        fileType: uploadType,
        mbSize: json['file_size'],
        date: json['file_date'],
        writer: json['file_writer'],
        downloadUrl: json['file_downloadUrl']);
  }

  String formatFileTypeToString(UploadType uploadType) {
    switch (uploadType) {
      case UploadType.document:
        return "document";
      case UploadType.photo:
        return "photo";
      case UploadType.media:
        return "media";
    }
  }
}
