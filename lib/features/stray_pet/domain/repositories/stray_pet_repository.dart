import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';

abstract class StrayPetRepository {
  Future<List<StrayPet>> createPost(StrayPet strayPet);
  Future<List<StrayPet>> getAllPosts();
  Future<StrayPet> getPostDetail(int postId);
  Future<String> updatePost(StrayPet strayPet);
  Future<String> deletePost(int postId);
  Future<List<StrayPet>> getPostByOwnerId(int ownerId);
  Future<List<StrayPet>> getPostByRescuerId(int rescuerId);
  Future<List<StrayPet>> getPostsByAddress(String address);
  Future<List<StrayPet>> getPostsByLostedDate(String lostedDate);
  Future<List<StrayPet>> getPostsByStatus(String status);
}
