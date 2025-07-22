class FileData {
  final int id;
  final String originalName;
  final String generatedName;
  final String fileCode;
  final String? downloadUrl;
  final String? fileType;
  final String? base64;
  final int fileSize;

  FileData({
    required this.id,
    required this.originalName,
    required this.generatedName,
    required this.fileCode,
    this.downloadUrl,
    this.fileType,
    this.base64,
    required this.fileSize,
  });

  factory FileData.fromJson(Map<String, dynamic> json) {
    return FileData(
      id: json['id'],
      originalName: json['originalName'] ?? '',
      generatedName: json['generatedName'] ?? '',
      fileCode: json['fileCode'] ?? '',
      downloadUrl: json['downloadUrl'],
      fileType: json['fileType'],
      base64: json['base64'],
      fileSize: json['fileSize'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'originalName': originalName,
      'generatedName': generatedName,
      'fileCode': fileCode,
      'downloadUrl': downloadUrl,
      'fileType': fileType,
      'base64': base64,
      'fileSize': fileSize,
    };
  }
}