'use strict'

angular
  .module("estimatio", [ "ngResource" ])
  .config ($routeProvider) ->
    $routeProvider
      .when("/",
        templateUrl: "views/main.html"
        controller: "CardCtrl"
      )
      .otherwise redirectTo: "/"
