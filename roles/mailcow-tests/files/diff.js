// source: https://github.com/OFFLINE-GmbH/translations-diff
// license: https://github.com/OFFLINE-GmbH/translations-diff/blob/master/LICENSE
var fs = require('fs');

// TODO Error Handling if file does not exist
// TODO Error Handling if file is not a JSON

// global variables
var save = false;
var referenceData = null;
var checkIndex = 0;
var checkData = [];
var checkFilenames = [];
var missingPaths = [];

// Helper functions

// Extending arrays by contains
// (https://stackoverflow.com/questions/237104/how-do-i-check-if-an-array-includes-an-object-in-javascript)
function arrayContains(array,value){
  var i = array.length;
  while (i--) {
      if (array[i] === value) {
          return true;
      }
  }
  return false;
}

// Extending strings by replaceAll
// (https://stackoverflow.com/questions/1144783/how-to-replace-all-occurrences-of-a-string-in-javascript)
function stringReplaceAll(string, search, replacement){
  return string.replace(new RegExp(search, 'g'), replacement);
}


// Collects every unique keys of a given object with his full hierarchy
// This function will be called recoursively.
// path: base path of the given current object.
// object: the given object
// keys: a list of already collected keys
function collectKeys(path,object,keys){
  for (var key in object){
    if (typeof object[key] === 'object'){
      collectKeys(path+'.'+key, object[key], keys);
    }
    else{
      // value found
      var currentPath = path+'.'+key;
      currentPath = currentPath.substring(1); // remove leading dot
      keys.push(currentPath);
    }
  }
}


// checks, if an object has a value other than an object on a given path.
// object: the object to check
// path: the pat to the value, dot separated. eg. path.to.value
// returns: boolean value
function containsPath(obj, path){
  return getValueByPath(obj,path) != null;
}


// Finds String values in a source array of strings, that are not present in the
// ref array of strings.
// src: an array of strings to look for missing values
// ref: an array of strings as reference
// returns: a list of missing values
 function compareValues(src,ref){
  var result = [];
  ref.forEach(function handle(val, index, array) {
    if (!arrayContains(src,val)){
      result.push(val);
    }
  });
  return result;
}


// Returns the value of an object field, based on its path of null,
// if the field does not exist or is an object as itself.
// obj: the object containing the fields
// path: the path to the field
// returns: the value of the field or null, if the field does not exist or is an object.
function getValueByPath (obj, path){
  var parts = path.split('.');
  var o = JSON.parse(JSON.stringify(obj)); // copy object
  parts.forEach(function handle(val, index, array){
      if (!o.hasOwnProperty(val)){
        return null;
      }
      else {
        o = o[val];
      }
  });
  if (typeof 0 != 'object'){
    return o;
  }
  else{
    return null;
  }
}


// Prints the paths given in an array
// paths: the paths to print
function printPaths(paths){
  paths.forEach(function handle(pVal, pIndex, pArray) {
    console.log('- '+pVal);
  });
}

// determine reference data and options
if (process.argv.length > 2){
   if (process.argv[2] === '--save'){
     save = true;
     if (process.argv.length > 3){
       referenceData = JSON.parse(fs.readFileSync(process.argv[3], 'utf8'));
       checkIndex = 4;
     }
   }
   else{
     if (process.argv.length > 2){
       referenceData = JSON.parse(fs.readFileSync(process.argv[2], 'utf8'));
       checkIndex = 3;
     }
   }
}

// determine check data
process.argv.forEach(function handle(val, index, array) {
  if (index>=checkIndex){
    var checkItem = JSON.parse(fs.readFileSync(process.argv[index], 'utf8'));
    checkData.push(checkItem);
    checkFilenames.push(process.argv[index]);
  }
});

// read reference data
var refKeys = [];
collectKeys('',referenceData,refKeys);

// determine missing keys
checkData.forEach(function handle(val, index, array) {
  var checkKeys = [];
  collectKeys('',val,checkKeys);
  var missing = compareValues(checkKeys,refKeys);
  missingPaths.push(missing);
});

// print
checkFilenames.forEach(function handle(val, index, array) {
  console.log('missing in '+val+':');
  console.log();
  var currentMissingPaths = missingPaths[index];
  printPaths(currentMissingPaths);
  console.log();
});

// save to csv-files
if (save){
  checkFilenames.forEach(function handle(val, index, array){
    var filename = val.split('.')[0]+'.missing.csv';
    // TODO more generic filename creation???
    // TODO use csv-writer component
    var currentMissingPaths = missingPaths[index];
    var output = '';

    currentMissingPaths.forEach(function handle(pVal, pIndex, pArray) {
      var refValue = getValueByPath(referenceData,pVal);
      refValue = stringReplaceAll(refValue, ',', '\\,'); // not necessary, when using csv-writer.
      // TODO ^ there are certainly more cases!
      output = output + pVal + ',' + refValue +'\n';
    });

    fs.writeFile(filename, output, function(err) {
        if(err) {
            return console.log(err);
        }
    });
  });
}