'use strict'

angular
  .module("estimatio", [ "ngResource" ])
  .config ($routeProvider) ->
    $routeProvider
      .when("/",
        templateUrl: "views/cards.html"
        controller: "CardCtrl"
      )
      .otherwise redirectTo: "/"
