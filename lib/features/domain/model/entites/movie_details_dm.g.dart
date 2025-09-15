// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_dm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieDetailsDmAdapter extends TypeAdapter<MovieDetailsDm> {
  @override
  final int typeId = 1;

  @override
  MovieDetailsDm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieDetailsDm(
      id: fields[0] as int,
      title: fields[1] as String,
      titleEnglish: fields[2] as String?,
      titleLong: fields[3] as String?,
      year: fields[4] as int,
      likeCount: fields[5] as int,
      rating: fields[6] as double,
      runtime: fields[7] as int,
      genres: (fields[8] as List).cast<String>(),
      description: fields[9] as String,
      ytTrailerCode: fields[10] as String?,
      language: fields[11] as String?,
      mpaRating: fields[12] as String?,
      backgroundImage: fields[13] as String?,
      largeCoverImage: fields[14] as String?,
      cast: (fields[15] as List).cast<CastEntity>(),
      torrents: (fields[16] as List).cast<TorrentEntity>(),
      screenshots: (fields[17] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, MovieDetailsDm obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.titleEnglish)
      ..writeByte(3)
      ..write(obj.titleLong)
      ..writeByte(4)
      ..write(obj.year)
      ..writeByte(5)
      ..write(obj.likeCount)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.runtime)
      ..writeByte(8)
      ..write(obj.genres)
      ..writeByte(9)
      ..write(obj.description)
      ..writeByte(10)
      ..write(obj.ytTrailerCode)
      ..writeByte(11)
      ..write(obj.language)
      ..writeByte(12)
      ..write(obj.mpaRating)
      ..writeByte(13)
      ..write(obj.backgroundImage)
      ..writeByte(14)
      ..write(obj.largeCoverImage)
      ..writeByte(15)
      ..write(obj.cast)
      ..writeByte(16)
      ..write(obj.torrents)
      ..writeByte(17)
      ..write(obj.screenshots);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDetailsDmAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CastEntityAdapter extends TypeAdapter<CastEntity> {
  @override
  final int typeId = 2;

  @override
  CastEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CastEntity(
      name: fields[0] as String,
      characterName: fields[1] as String?,
      imageUrl: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CastEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.characterName)
      ..writeByte(2)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CastEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TorrentEntityAdapter extends TypeAdapter<TorrentEntity> {
  @override
  final int typeId = 3;

  @override
  TorrentEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TorrentEntity(
      quality: fields[0] as String,
      type: fields[1] as String,
      size: fields[2] as String,
      seeds: fields[3] as int,
      peers: fields[4] as int,
      url: fields[5] as String,
      videoCodec: fields[6] as String,
      audioChannels: fields[7] as String,
      dateUploaded: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TorrentEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.quality)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.size)
      ..writeByte(3)
      ..write(obj.seeds)
      ..writeByte(4)
      ..write(obj.peers)
      ..writeByte(5)
      ..write(obj.url)
      ..writeByte(6)
      ..write(obj.videoCodec)
      ..writeByte(7)
      ..write(obj.audioChannels)
      ..writeByte(8)
      ..write(obj.dateUploaded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TorrentEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
