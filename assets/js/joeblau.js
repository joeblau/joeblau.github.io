var App = angular.module('JoeBlau', []);

App.controller('ProjectCtrl', function($scope, $http) {
  $http.get('../assets/projects.json')
    .then(function(res){
      $scope.projects = res.data;
      var grid = document.querySelector('#grid');
      salvattore['recreate_columns'](grid);
    });
});