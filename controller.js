// Filename /tmp/tmp.js
var app = angular.module('upl', ['ngFileUpload']);

app.controller('myCtrl', function($scope, Upload) {
  $scope.size = 32499;
  $scope.result = null;
  $scope.prcnt = 0;

  
  $scope.run  = function () {
    var file = new Blob([new Uint8Array($scope.size)], {type: 'application/octet-stream'});
    $scope.prcnt = 0;
    Upload.upload({
      url: '/upload',
      data: {file: file}
    }).then(
      function (resp){
	console.log('Success ' + resp.config.data.file.name + 'uploaded. Response: ' + resp.data);
	$scope.result = resp.data;
      },
      function (resp) {
	console.log('Error status: ' + resp.status);
	$scope.result = resp.data;
      },
      function (evt) {
	var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
        console.log('progress: ' + progressPercentage + '% ' + evt.config.data.file.name);
	$scope.prcnt = progressPercentage;
      });
  };
});
