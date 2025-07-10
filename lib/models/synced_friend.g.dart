// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'synced_friend.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSyncedFriendCollection on Isar {
  IsarCollection<SyncedFriend> get syncedFriends => this.collection();
}

const SyncedFriendSchema = CollectionSchema(
  name: r'SyncedFriend',
  id: -83231685473951475,
  properties: {
    r'friendId': PropertySchema(
      id: 0,
      name: r'friendId',
      type: IsarType.string,
    ),
    r'syncedAt': PropertySchema(
      id: 1,
      name: r'syncedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _syncedFriendEstimateSize,
  serialize: _syncedFriendSerialize,
  deserialize: _syncedFriendDeserialize,
  deserializeProp: _syncedFriendDeserializeProp,
  idName: r'id',
  indexes: {
    r'friendId': IndexSchema(
      id: 3009825909668687770,
      name: r'friendId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'friendId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _syncedFriendGetId,
  getLinks: _syncedFriendGetLinks,
  attach: _syncedFriendAttach,
  version: '3.1.0+1',
);

int _syncedFriendEstimateSize(
  SyncedFriend object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.friendId.length * 3;
  return bytesCount;
}

void _syncedFriendSerialize(
  SyncedFriend object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.friendId);
  writer.writeDateTime(offsets[1], object.syncedAt);
}

SyncedFriend _syncedFriendDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SyncedFriend();
  object.friendId = reader.readString(offsets[0]);
  object.id = id;
  object.syncedAt = reader.readDateTime(offsets[1]);
  return object;
}

P _syncedFriendDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _syncedFriendGetId(SyncedFriend object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _syncedFriendGetLinks(SyncedFriend object) {
  return [];
}

void _syncedFriendAttach(
    IsarCollection<dynamic> col, Id id, SyncedFriend object) {
  object.id = id;
}

extension SyncedFriendByIndex on IsarCollection<SyncedFriend> {
  Future<SyncedFriend?> getByFriendId(String friendId) {
    return getByIndex(r'friendId', [friendId]);
  }

  SyncedFriend? getByFriendIdSync(String friendId) {
    return getByIndexSync(r'friendId', [friendId]);
  }

  Future<bool> deleteByFriendId(String friendId) {
    return deleteByIndex(r'friendId', [friendId]);
  }

  bool deleteByFriendIdSync(String friendId) {
    return deleteByIndexSync(r'friendId', [friendId]);
  }

  Future<List<SyncedFriend?>> getAllByFriendId(List<String> friendIdValues) {
    final values = friendIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'friendId', values);
  }

  List<SyncedFriend?> getAllByFriendIdSync(List<String> friendIdValues) {
    final values = friendIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'friendId', values);
  }

  Future<int> deleteAllByFriendId(List<String> friendIdValues) {
    final values = friendIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'friendId', values);
  }

  int deleteAllByFriendIdSync(List<String> friendIdValues) {
    final values = friendIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'friendId', values);
  }

  Future<Id> putByFriendId(SyncedFriend object) {
    return putByIndex(r'friendId', object);
  }

  Id putByFriendIdSync(SyncedFriend object, {bool saveLinks = true}) {
    return putByIndexSync(r'friendId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByFriendId(List<SyncedFriend> objects) {
    return putAllByIndex(r'friendId', objects);
  }

  List<Id> putAllByFriendIdSync(List<SyncedFriend> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'friendId', objects, saveLinks: saveLinks);
  }
}

extension SyncedFriendQueryWhereSort
    on QueryBuilder<SyncedFriend, SyncedFriend, QWhere> {
  QueryBuilder<SyncedFriend, SyncedFriend, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SyncedFriendQueryWhere
    on QueryBuilder<SyncedFriend, SyncedFriend, QWhereClause> {
  QueryBuilder<SyncedFriend, SyncedFriend, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterWhereClause> idBetween(
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

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterWhereClause> friendIdEqualTo(
      String friendId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'friendId',
        value: [friendId],
      ));
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterWhereClause>
      friendIdNotEqualTo(String friendId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'friendId',
              lower: [],
              upper: [friendId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'friendId',
              lower: [friendId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'friendId',
              lower: [friendId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'friendId',
              lower: [],
              upper: [friendId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension SyncedFriendQueryFilter
    on QueryBuilder<SyncedFriend, SyncedFriend, QFilterCondition> {
  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition>
      friendIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'friendId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition>
      friendIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'friendId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition>
      friendIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'friendId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition>
      friendIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'friendId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition>
      friendIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'friendId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition>
      friendIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'friendId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition>
      friendIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'friendId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition>
      friendIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'friendId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition>
      friendIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'friendId',
        value: '',
      ));
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition>
      friendIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'friendId',
        value: '',
      ));
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition>
      syncedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition>
      syncedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'syncedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition>
      syncedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'syncedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterFilterCondition>
      syncedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'syncedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SyncedFriendQueryObject
    on QueryBuilder<SyncedFriend, SyncedFriend, QFilterCondition> {}

extension SyncedFriendQueryLinks
    on QueryBuilder<SyncedFriend, SyncedFriend, QFilterCondition> {}

extension SyncedFriendQuerySortBy
    on QueryBuilder<SyncedFriend, SyncedFriend, QSortBy> {
  QueryBuilder<SyncedFriend, SyncedFriend, QAfterSortBy> sortByFriendId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendId', Sort.asc);
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterSortBy> sortByFriendIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendId', Sort.desc);
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterSortBy> sortBySyncedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncedAt', Sort.asc);
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterSortBy> sortBySyncedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncedAt', Sort.desc);
    });
  }
}

extension SyncedFriendQuerySortThenBy
    on QueryBuilder<SyncedFriend, SyncedFriend, QSortThenBy> {
  QueryBuilder<SyncedFriend, SyncedFriend, QAfterSortBy> thenByFriendId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendId', Sort.asc);
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterSortBy> thenByFriendIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendId', Sort.desc);
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterSortBy> thenBySyncedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncedAt', Sort.asc);
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QAfterSortBy> thenBySyncedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncedAt', Sort.desc);
    });
  }
}

extension SyncedFriendQueryWhereDistinct
    on QueryBuilder<SyncedFriend, SyncedFriend, QDistinct> {
  QueryBuilder<SyncedFriend, SyncedFriend, QDistinct> distinctByFriendId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'friendId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncedFriend, SyncedFriend, QDistinct> distinctBySyncedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncedAt');
    });
  }
}

extension SyncedFriendQueryProperty
    on QueryBuilder<SyncedFriend, SyncedFriend, QQueryProperty> {
  QueryBuilder<SyncedFriend, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SyncedFriend, String, QQueryOperations> friendIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'friendId');
    });
  }

  QueryBuilder<SyncedFriend, DateTime, QQueryOperations> syncedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncedAt');
    });
  }
}
