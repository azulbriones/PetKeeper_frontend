import 'package:pet_keeper_front/features/stray_pet/data/datasources/api_datasource/stray_pet_remote_data_source.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class StrayPetRepositoryImpl implements StrayPetRepository {
  final StrayPetRemoteDataSource strayPetRemoteDataSource;

  StrayPetRepositoryImpl({required this.strayPetRemoteDataSource});
  @override
  Future<List<StrayPet>> createPost(StrayPet strayPet) async {
    return await strayPetRemoteDataSource.createPost(strayPet);
  }

  @override
  Future<String> deletePost(int postId) async {
    return await strayPetRemoteDataSource.deletePost(postId);
  }

  @override
  Future<List<StrayPet>> getAllPosts() async {
    return await strayPetRemoteDataSource.getAllPosts();
  }

  @override
  Future<List<StrayPet>> getPostByOwnerId(int ownerId) async {
    return await strayPetRemoteDataSource.getPostByOwnerId(ownerId);
  }

  @override
  Future<List<StrayPet>> getPostByRescuerId(int rescuerId) async {
    return await strayPetRemoteDataSource.getPostByRescuerId(rescuerId);
  }

  @override
  Future<StrayPet> getPostDetail(int postId) async {
    return await strayPetRemoteDataSource.getPostDetail(postId);
  }

  @override
  Future<List<StrayPet>> getPostsByAddress(String address) async {
    return await strayPetRemoteDataSource.getPostsByAddress(address);
  }

  @override
  Future<List<StrayPet>> getPostsByLostedDate(String lostedDate) async {
    return await strayPetRemoteDataSource.getPostsByLostedDate(lostedDate);
  }

  @override
  Future<List<StrayPet>> getPostsByStatus(String status) async {
    return await strayPetRemoteDataSource.getPostsByStatus(status);
  }

  @override
  Future<String> updatePost(StrayPet strayPet) async {
    return await strayPetRemoteDataSource.updatePost(strayPet);
  }
}
