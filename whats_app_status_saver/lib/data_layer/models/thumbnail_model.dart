import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'thumbnail_model.g.dart';

@Collection(inheritance: false)
class ThumbnailsModel extends Equatable {
  @Index(unique: true, replace: true)
  final String dbKey = (ThumbnailsModel).toString();
  final Id id = Isar.autoIncrement;
  final List<String>? thumbnailsPath;

  ThumbnailsModel({
    this.thumbnailsPath,
  });

  @override
  @ignore
  List<Object?> get props => [thumbnailsPath];
}
