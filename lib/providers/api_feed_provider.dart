import 'package:flutter/foundation.dart';
import '../models/community_post.dart';
import '../services/api_service.dart';

enum ApiStatus { initial, loading, success, error }

/// Experiment 9: Provider managing REST API State, Loading, Error and Search
class ApiFeedProvider extends ChangeNotifier {
  final ApiService _apiService;

  ApiStatus _status = ApiStatus.initial;
  List<CommunityPost> _allPosts = [];
  String _errorMessage = '';
  String _searchQuery = '';

  ApiFeedProvider({ApiService? apiService})
      : _apiService = apiService ?? ApiService() {
    fetchFeed();
  }

  ApiStatus get status => _status;
  bool get isLoading => _status == ApiStatus.loading;
  bool get hasError => _status == ApiStatus.error;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;

  List<CommunityPost> get posts {
    if (_searchQuery.isEmpty) {
      return List.unmodifiable(_allPosts);
    }
    return _allPosts.where((post) {
      final q = _searchQuery.toLowerCase();
      return post.title.toLowerCase().contains(q) ||
          post.body.toLowerCase().contains(q) ||
          post.tag.toLowerCase().contains(q) ||
          post.authorName.toLowerCase().contains(q);
    }).toList();
  }

  Future<void> fetchFeed() async {
    _status = ApiStatus.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      _allPosts = await _apiService.fetchCommunityPosts();
      _status = ApiStatus.success;
    } catch (e) {
      _status = ApiStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }
    notifyListeners();
  }

  Future<void> refreshFeed() async {
    await fetchFeed();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void addLocalPost(CommunityPost post) {
    _allPosts.insert(0, post);
    notifyListeners();
  }
}
