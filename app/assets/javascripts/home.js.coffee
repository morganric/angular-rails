# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

app = angular.module 'Posts', []

app.controller "PostsCtrl", @PostsCtrl = ($scope) ->
  $scope.posts = [
    { id: 1, title: "Title 1", intro: "This is posting 1 foo" },
    { id: 2, title: "Title 2", intro: "This is posting 2 bar" },
    { id: 3, title: "Title 3", intro: "This is posting 3 baz" }
  ]