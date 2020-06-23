class GitRelease {
  String release_title,
      release_description,
      release_tag_name,
      download_url,
      assest_name;
  bool isPrerelease, isDraft;
  int size;
  var assets;

  GitRelease.fromJson(var body) {
    this.release_title = body['name'];
    this.release_description = body['body'];
    this.release_tag_name = body['tag_name'];
    this.isPrerelease = body['prerelease'];
    this.isDraft = body['draft'];
    this.assets = body['assets'][0];
    this.download_url = assets['browser_download_url'];
    this.size = assets['size'];
    this.assest_name = assets['name'];
  }
}
