import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:redite_clone/core/enums/enums.dart';
import 'package:redite_clone/features/user_profile/controller/user_profile_controller.dart';
import 'package:redite_clone/model/comment_meodel.dart';
import 'package:redite_clone/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';
import '../../../core/provider/storage_repository_provider.dart';
import '../../../core/utils.dart';
import '../../../model/community_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../repository/post_repository.dart';

final postControllerProvider =
    StateNotifierProvider<PosCtontroller, bool>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return PosCtontroller(
    postRepository: postRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});

final getPostByIdProvider = StreamProvider.family((ref, String postId) {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.getPostById(postId);
});
final getPostCommentsProvider = StreamProvider.family((ref, String postId) {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.fechPostComments(postId);
});

final userPostsProvider =
    StreamProvider.family((ref, List<Community> communities) {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.fetchUserPosts(communities);
});
final guestPostsProvider = StreamProvider((ref) {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.fetchGuestPosts();
});

class PosCtontroller extends StateNotifier<bool> {
  final PostRopository _postRopository;
  final StorageRepository _storageRepository;
  final Ref _ref;

  PosCtontroller({
    required PostRopository postRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _postRopository = postRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void shareTextPost({
    required BuildContext context,
    required String title,
    required Community selectedCommunity,
    required String description,
  }) async {
    state = true;
    String postId = const Uuid().v1();

    final user = _ref.read(userProvider)!;

    final Post post = Post(
      id: postId,
      title: title,
      communityName: selectedCommunity.name,
      communityProfilePic: selectedCommunity.avatar,
      upvotes: [],
      downvotes: [],
      commentCount: 0,
      username: user.name,
      uid: user.uid,
      type: 'text',
      createdAt: DateTime.now(),
      awards: [],
      description: description,
    );
    final res = await _postRopository.addPost(post);
    _ref
        .read(userProfileControllerProvider.notifier)
        .updateUserKarma(UserKarma.textPost);
    state = false;
    res.fold((l) => showSnackBar(context: context, text: l.message), (r) {
      showSnackBar(context: context, text: 'Posted successfully');
      Routemaster.of(context).pop();
    });
  }

  void shareLinkPost({
    required BuildContext context,
    required String title,
    required Community selectedCommunity,
    required String link,
  }) async {
    state = true;
    String postId = const Uuid().v1();

    final user = _ref.read(userProvider)!;

    final Post post = Post(
      id: postId,
      title: title,
      communityName: selectedCommunity.name,
      communityProfilePic: selectedCommunity.avatar,
      upvotes: [],
      downvotes: [],
      commentCount: 0,
      username: user.name,
      uid: user.uid,
      type: 'link',
      createdAt: DateTime.now(),
      awards: [],
      link: link,
    );
    final res = await _postRopository.addPost(post);
    _ref
        .read(userProfileControllerProvider.notifier)
        .updateUserKarma(UserKarma.linkPost);
    state = false;
    res.fold((l) => showSnackBar(context: context, text: l.message), (r) {
      showSnackBar(context: context, text: 'Posted successfully');
      Routemaster.of(context).pop();
    });
  }

  void shareImagePost(
      {required BuildContext context,
      required String title,
      required Community selectedCommunity,
      required File? file,
      required Uint8List? webFile}) async {
    state = true;
    String postId = const Uuid().v1();

    final user = _ref.read(userProvider)!;

    final imageRes = await _storageRepository.storeFile(
      path: 'posts/${selectedCommunity.name}',
      id: postId,
      file: file,
      webFile: webFile,
    );

    imageRes.fold((l) => showSnackBar(context: context, text: l.message),
        (r) async {
      final Post post = Post(
        id: postId,
        title: title,
        communityName: selectedCommunity.name,
        communityProfilePic: selectedCommunity.avatar,
        upvotes: [],
        downvotes: [],
        commentCount: 0,
        username: user.name,
        uid: user.uid,
        type: 'image',
        createdAt: DateTime.now(),
        awards: [],
        link: r,
      );
      final res = await _postRopository.addPost(post);
      _ref
          .read(userProfileControllerProvider.notifier)
          .updateUserKarma(UserKarma.imagePost);
      state = false;
      res.fold((l) => showSnackBar(context: context, text: l.message), (r) {
        showSnackBar(context: context, text: 'Posted successfully');
        Routemaster.of(context).pop();
      });
    });
  }

  Stream<List<Post>> fetchUserPosts(List<Community> communities) {
    if (communities.isNotEmpty) {
      return _postRopository.fetchUserPosts(communities);
    }
    return Stream.value([]);
  }

  Stream<List<Post>> fetchGuestPosts() {
    return _postRopository.fetchGuestPosts();
  }

  void deletePost(Post post, BuildContext context) async {
    final res = await _postRopository.deletePost(post);
    _ref
        .read(userProfileControllerProvider.notifier)
        .updateUserKarma(UserKarma.deletePost);
    res.fold(
        (l) => null,
        (r) =>
            showSnackBar(context: context, text: 'Post Deleted successfully'));
  }

  void upvote(Post post) async {
    final uid = _ref.read(userProvider)!.uid;
    _postRopository.upvote(post, uid);
  }

  void downvote(Post post) async {
    final uid = _ref.read(userProvider)!.uid;
    _postRopository.downvote(post, uid);
  }

  Stream<Post> getPostById(String postId) {
    return _postRopository.getPostById(postId);
  }

  void addComment(
      {required BuildContext context,
      required String text,
      required Post post}) async {
    final user = _ref.read(userProvider)!;
    String commentId = const Uuid().v1();
    Comment comment = Comment(
      id: commentId,
      text: text,
      createdAt: DateTime.now(),
      postId: post.id,
      username: user.name,
      profilePic: user.profilePic,
    );
    final res = await _postRopository.addComment(comment);
    _ref
        .read(userProfileControllerProvider.notifier)
        .updateUserKarma(UserKarma.comment);
    res.fold(
        (l) => showSnackBar(context: context, text: l.message), (r) => null);
  }

  void awardPost({
    required Post post,
    required String award,
    required BuildContext context,
  }) async {
    final user = _ref.read(userProvider)!;

    final res = await _postRopository.awardPost(post, award, user.uid);

    res.fold((l) => showSnackBar(context: context, text: l.message), (r) {
      _ref
          .read(userProfileControllerProvider.notifier)
          .updateUserKarma(UserKarma.awardPost);
      _ref.read(userProvider.notifier).update((state) {
        state?.awards.remove(award);
        return state;
      });
      Routemaster.of(context).pop();
    });
  }

  Stream<List<Comment>> fechPostComments(String postId) {
    return _postRopository.getCommentsOfPost(postId);
  }
}
