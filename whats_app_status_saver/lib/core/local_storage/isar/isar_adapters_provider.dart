import 'package:isar/isar.dart';

import '../../../data_layer/models/thumbnail_model.dart';

class IsarAdaptersProvider {
  List<CollectionSchema> getAdapters() {
    //only first entity of a data set needs to be added here
    return <CollectionSchema<dynamic>>[
      ThumbnailsModelSchema,
    ];
  }
}
