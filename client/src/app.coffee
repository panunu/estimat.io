'use strict'

angular
  .module("estimatio", [ "ngResource" ])
  .config ($routeProvider) ->
    $routeProvider
      .when "/room/:id",
        controller: "CardCtrl"
        templateUrl: "views/cards.html"

      .otherwise redirectTo: "/room/" + (Math.random()).toString(32).substring(2)
