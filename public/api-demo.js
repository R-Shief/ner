/* Monkey patch to fix jQuery referencing */
if ($==undefined){ $=jQuery; }

var showResults = function(data){
  console.log("showing results of "+data);
  console.log("response is here");
  if (data.status == "Error"){
     $("#api-results-summary").html("Error: " + data.error_message);
     $("#api-demo-results").hide();
     return false;
  }
  entities_found = data.entities.length;
  if(entities_found >0){
    $("#api-results-summary").html(entities_found + " matching topics has been found");
    $("#api-demo-results").show();
    $("#api-demo-results tbody").html("");
    console.log(entities_found);
    for(var i=0; i<entities_found; i++) {
      var entity = data.entities[i];
      console.log(entity.name + " :    "+ entity.brief);
      $.tmpl( "<tr><td>${name}</td><td>${brief}</td><td>${type}</td></tr>", 
              {"name": entity.name, "brief": entity.brief, "type": "Entity" }).
            appendTo("#api-demo-results tbody");
    }       
  }else{
    $("#api-results-summary").html("No matching topics has been found");
    $("#api-demo-results").hide();
  }  
  $("#demo-submit").removeAttr('disabled');
}

var process = function(query){
  url= "http://textapi.r-shief.org/v/0-dev/analyzer/analyze.js";
  // url = "/v/0-dev/analyzer/analyze.js";
  data={"query": query};
  dataType='jsonp';
  $.post(url,data,function(data,status,xhr){  },dataType);
}

/* Monkey patch to fix jQuery referencing */
if ($==undefined){ $=jQuery; }

$(document).ready(function(){
  $("#api-demo-form").submit(function(){
    $("#demo-submit").attr('disabled','disabled');
    var query = $(this.query).val();
    console.log("query is "+query);
    process(query);
    return false;
  });
  $("#api-demo-form").bind('reset',function(){

    $("#api-demo-results").hide();
    $("#api-results-summary").html("");
    $("#demo-submit").removeAttr('disabled');
  })
})