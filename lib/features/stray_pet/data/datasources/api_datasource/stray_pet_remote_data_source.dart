import 'package:pet_keeper_front/features/stray_pet/data/models/stray_pet_model.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';

abstract class StrayPetRemoteDataSource {
  Future<List<StrayPetModel>> createPost(StrayPet strayPet);
  Future<List<StrayPetModel>> getAllPosts();
  Future<StrayPetModel> getPostDetail(int postId);
  Future<String> updatePost(StrayPet strayPet);
  Future<String> deletePost(int postId);
  Future<List<StrayPetModel>> getPostByOwnerId(int ownerId);
  Future<List<StrayPetModel>> getPostByRescuerId(int rescuerId);
  Future<List<StrayPetModel>> getPostsByAddress(String address);
  Future<List<StrayPetModel>> getPostsByLostedDate(String lostedDate);
  Future<List<StrayPetModel>> getPostsByStatus(String status);
}
