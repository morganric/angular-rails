// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .
//= require angular.min
//= require angle-up
//= require_tree ./angular

// var app;

app = angular.module('Posts', []);


app.controller("PostsCtrl", this.PostsCtrl = function($scope, $http) {
  return $http.get('/posts.json').success(function(data) {
    return $scope.posts = data;
  });
});


// app.controller("PostsCtrl", this.PostsCtrl = function($scope) {
//   return $scope.posts = [
//     {
//       id: 1,
//       title: "Title 1",
//       intro: "This is posting 1 foo"
//     }, {
//       id: 2,
//       title: "Title 2",
//       intro: "This is posting 2 bar"
//     }, {
//       id: 3,
//       title: "Title 3",
//       intro: "This is posting 3 baz"
//     }
//   ];
// });