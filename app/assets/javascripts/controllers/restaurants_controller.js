var myApp = angular.module('restaurant', ['ngRoute', 'ngResource']);

myApp.factory('Restaurants', ['$resource',function($resource){
 return $resource('/restaurants.json', {},{
 query: { method: 'GET', isArray: true },
 create: { method: 'POST' }
 })
}]);

myApp.factory('Restaurant', ['$resource', function($resource){
 return $resource('/users/:id.json', {}, {
 show: { method: 'GET' },
 update: { method: 'PUT', params: {id: '@id'} },
 delete: { method: 'DELETE', params: {id: '@id'} }
 });
}]);

function getRestaurantList($scope, $http) {
  //$scope.restaurants = Restaurants.query(); //it's getting user collection
  $http.get('/restaurants.json').success(function(data) { 
    $scope.restaurants = data;
  });
}
myApp.controller("RestaurantListCtrl", getRestaurantList);

myApp.controller("RestaurantDetailCtrl", function($scope, $http, $routeParams) {
  url = '/restaurants/'+$routeParams.id+'.json'
  $http.get(url).success(function(data) { 
    $scope.restaurant = data;
  });
});

myApp.config([
 '$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
 	$routeProvider.
	when('/restaurants',{
	    templateUrl: '/templates/restaurants/index.html',
	    controller: 'RestaurantListCtrl'
	}).
	when('/restaurants/:id',{
    	templateUrl: '/templates/restaurants/show.html',
    	controller: 'RestaurantDetailCtrl'
 	}).
 	when('/restaurants/new', {
	   templateUrl: '/templates/users/new.html',
	   controller: 'UserAddCtr'
	}).
	otherwise({
	   redirectTo: '/restaurants'
 	})
 }
]);
