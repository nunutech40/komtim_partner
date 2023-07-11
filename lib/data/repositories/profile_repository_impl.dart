import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:komtim_partner/common/failure.dart';
import 'package:komtim_partner/data/datasources/preferences/shared_pref.dart';
import 'package:komtim_partner/data/datasources/remote/auth_remote_datasource.dart';
import 'package:komtim_partner/data/models/login_response.dart';
import 'package:komtim_partner/data/models/profile_response.dart';
import 'package:komtim_partner/domain/entities/login_model.dart';
import 'package:komtim_partner/domain/entities/profile_model.dart';
import 'package:komtim_partner/domain/repositories/auth_repository.dart';

import '../../common/exception.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/remote/profile_remote_datasource.dart';
import 'base_repository.dart';

class ProfileRepositoryImpl extends BaseRepository
    implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final SharedPref sharedPref;

  ProfileRepositoryImpl(
      {required this.remoteDataSource, required this.sharedPref});

  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
    return executeEither(() async {
      final result = await remoteDataSource.getProfile();
      final profileModel = result.toEntity();
      sharedPref.saveProfileData(result);
      return profileModel;
    });
  }
}

// sharedPref.saveProfileData(result);
