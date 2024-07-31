// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetThumbnailsModelCollection on Isar {
  IsarCollection<ThumbnailsModel> get thumbnailsModels => this.collection();
}

const ThumbnailsModelSchema = CollectionSchema(
  name: r'ThumbnailsModel',
  id: -3949917278058196673,
  properties: {
    r'dbKey': PropertySchema(
      id: 0,
      name: r'dbKey',
      type: IsarType.string,
    ),
    r'thumbnailsPath': PropertySchema(
      id: 1,
      name: r'thumbnailsPath',
      type: IsarType.stringList,
    )
  },
  estimateSize: _thumbnailsModelEstimateSize,
  serialize: _thumbnailsModelSerialize,
  deserialize: _thumbnailsModelDeserialize,
  deserializeProp: _thumbnailsModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'dbKey': IndexSchema(
      id: 335451121104858753,
      name: r'dbKey',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'dbKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _thumbnailsModelGetId,
  getLinks: _thumbnailsModelGetLinks,
  attach: _thumbnailsModelAttach,
  version: '3.1.0+1',
);

int _thumbnailsModelEstimateSize(
  ThumbnailsModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dbKey.length * 3;
  {
    final list = object.thumbnailsPath;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  return bytesCount;
}

void _thumbnailsModelSerialize(
  ThumbnailsModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.dbKey);
  writer.writeStringList(offsets[1], object.thumbnailsPath);
}

ThumbnailsModel _thumbnailsModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ThumbnailsModel(
    thumbnailsPath: reader.readStringList(offsets[1]),
  );
  return object;
}

P _thumbnailsModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringList(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _thumbnailsModelGetId(ThumbnailsModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _thumbnailsModelGetLinks(ThumbnailsModel object) {
  return [];
}

void _thumbnailsModelAttach(
    IsarCollection<dynamic> col, Id id, ThumbnailsModel object) {}

extension ThumbnailsModelByIndex on IsarCollection<ThumbnailsModel> {
  Future<ThumbnailsModel?> getByDbKey(String dbKey) {
    return getByIndex(r'dbKey', [dbKey]);
  }

  ThumbnailsModel? getByDbKeySync(String dbKey) {
    return getByIndexSync(r'dbKey', [dbKey]);
  }

  Future<bool> deleteByDbKey(String dbKey) {
    return deleteByIndex(r'dbKey', [dbKey]);
  }

  bool deleteByDbKeySync(String dbKey) {
    return deleteByIndexSync(r'dbKey', [dbKey]);
  }

  Future<List<ThumbnailsModel?>> getAllByDbKey(List<String> dbKeyValues) {
    final values = dbKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'dbKey', values);
  }

  List<ThumbnailsModel?> getAllByDbKeySync(List<String> dbKeyValues) {
    final values = dbKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'dbKey', values);
  }

  Future<int> deleteAllByDbKey(List<String> dbKeyValues) {
    final values = dbKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'dbKey', values);
  }

  int deleteAllByDbKeySync(List<String> dbKeyValues) {
    final values = dbKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'dbKey', values);
  }

  Future<Id> putByDbKey(ThumbnailsModel object) {
    return putByIndex(r'dbKey', object);
  }

  Id putByDbKeySync(ThumbnailsModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'dbKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDbKey(List<ThumbnailsModel> objects) {
    return putAllByIndex(r'dbKey', objects);
  }

  List<Id> putAllByDbKeySync(List<ThumbnailsModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'dbKey', objects, saveLinks: saveLinks);
  }
}

extension ThumbnailsModelQueryWhereSort
    on QueryBuilder<ThumbnailsModel, ThumbnailsModel, QWhere> {
  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ThumbnailsModelQueryWhere
    on QueryBuilder<ThumbnailsModel, ThumbnailsModel, QWhereClause> {
  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterWhereClause>
      dbKeyEqualTo(String dbKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dbKey',
        value: [dbKey],
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterWhereClause>
      dbKeyNotEqualTo(String dbKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dbKey',
              lower: [],
              upper: [dbKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dbKey',
              lower: [dbKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dbKey',
              lower: [dbKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dbKey',
              lower: [],
              upper: [dbKey],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ThumbnailsModelQueryFilter
    on QueryBuilder<ThumbnailsModel, ThumbnailsModel, QFilterCondition> {
  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      dbKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dbKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      dbKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dbKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      dbKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dbKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      dbKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dbKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      dbKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dbKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      dbKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dbKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      dbKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dbKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      dbKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dbKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      dbKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dbKey',
        value: '',
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      dbKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dbKey',
        value: '',
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'thumbnailsPath',
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'thumbnailsPath',
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailsPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thumbnailsPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thumbnailsPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thumbnailsPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'thumbnailsPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'thumbnailsPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'thumbnailsPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'thumbnailsPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailsPath',
        value: '',
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'thumbnailsPath',
        value: '',
      ));
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailsPath',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailsPath',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailsPath',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailsPath',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailsPath',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterFilterCondition>
      thumbnailsPathLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thumbnailsPath',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension ThumbnailsModelQueryObject
    on QueryBuilder<ThumbnailsModel, ThumbnailsModel, QFilterCondition> {}

extension ThumbnailsModelQueryLinks
    on QueryBuilder<ThumbnailsModel, ThumbnailsModel, QFilterCondition> {}

extension ThumbnailsModelQuerySortBy
    on QueryBuilder<ThumbnailsModel, ThumbnailsModel, QSortBy> {
  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterSortBy> sortByDbKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbKey', Sort.asc);
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterSortBy>
      sortByDbKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbKey', Sort.desc);
    });
  }
}

extension ThumbnailsModelQuerySortThenBy
    on QueryBuilder<ThumbnailsModel, ThumbnailsModel, QSortThenBy> {
  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterSortBy> thenByDbKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbKey', Sort.asc);
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterSortBy>
      thenByDbKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbKey', Sort.desc);
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension ThumbnailsModelQueryWhereDistinct
    on QueryBuilder<ThumbnailsModel, ThumbnailsModel, QDistinct> {
  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QDistinct> distinctByDbKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dbKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThumbnailsModel, ThumbnailsModel, QDistinct>
      distinctByThumbnailsPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'thumbnailsPath');
    });
  }
}

extension ThumbnailsModelQueryProperty
    on QueryBuilder<ThumbnailsModel, ThumbnailsModel, QQueryProperty> {
  QueryBuilder<ThumbnailsModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ThumbnailsModel, String, QQueryOperations> dbKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dbKey');
    });
  }

  QueryBuilder<ThumbnailsModel, List<String>?, QQueryOperations>
      thumbnailsPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'thumbnailsPath');
    });
  }
}
