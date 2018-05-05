<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<meta http-equiv="content-type" content="text/html;charset=UTF-8" />
<head>
    <meta charset="utf-8">
    <title>MUSA Goal Editor</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" type="text/css" href="../../build/rappid.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/theme-picker.css">

    <!-- theme-specific application CSS  -->
    <link rel="stylesheet" type="text/css" href="css/style.dark.css">
    <link rel="stylesheet" type="text/css" href="css/style.material.css">
    <link rel="stylesheet" type="text/css" href="css/style.modern.css">
</head>
<body>

    <div id="app">
        <div class="app-header">
              <div class="app-title">
                  <h1>MUSA Goal Editor</h1>
              </div>
              <div class="toolbar-container"></div>
        </div>
        <div class="app-body">
              <div class="stencil-container"></div>
              <div class="paper-container"></div>
              <div class="inspector-container"></div>
              <div class="navigator-container"></div>
        </div>
    </div>

    <!-- Rappid/JointJS dependencies: -->
    <script src="../../node_modules/jquery/dist/jquery.js"></script>
    <script src="../../node_modules/lodash/index.js"></script>
    <script src="../../node_modules/backbone/backbone.js"></script>
    <script src="../../node_modules/graphlib/dist/graphlib.core.js"></script>
    <script src="../../node_modules/dagre/dist/dagre.core.js"></script>

    <script src="../../build/rappid.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link href="../../../../css/jquery-ui.css" rel="stylesheet" type="text/css" media="all" />
    
    <!--[if IE 9]>
        <script>
          // `-ms-user-select: none` doesn't work in IE9
          document.onselectstart = function() { return false; };
        </script>
    <![endif]-->

    <!-- Application files:  -->
    <script src="js/config/halo.js"></script>
    <script src="js/config/selection.js"></script>
    <script src="js/config/inspector.js"></script>
    <script src="js/config/stencil.js"></script>
    <script src="js/config/toolbar.js"></script>
    <script src="js/config/sample-graphs.js"></script>
    <script src="js/views/main.js"></script>
    <script src="js/views/theme-picker.js"></script>
    <script src="js/models/joint.shapes.app.js"></script>
	<script type="text/javascript" src="js/config/FileSaver.js"></script>

<!--  Form che contiene i dati del grafico che verranno memorizzati su DB -->	
	<s:form id="formtosub" action="saveGoalJson" namespace="/customer" method="post">

		<s:hidden id="idSpecification" name="idSpecification" value="%{#parameters.idSpecification}" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />

		<s:hidden id="supportContent" name="supportContent" />
		<s:hidden id="graphName" name="graphName" />
		
		<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
	
  	</s:form>

    <script>
        joint.setTheme('material');
        app = new App.MainView({ el: '#app' });
        themePicker = new App.ThemePicker({ mainView: app });
        themePicker.render().$el.appendTo(document.body);

        var parser = new DOMParser;
        window.addEventListener('load', function() {
            var content ='<s:property value="jsonContent" />';
            var dom = parser.parseFromString(content, "text/html");
            if((content!=null)|| !(content.equals("")) ){
            app.graph.fromJSON(JSON.parse(dom.body.textContent));
            }
        });

			$('#goalname').val($('#graphName').val());

    </script>


<!-- Dialog per l'inserimento di goal presenti su DB -->
	<script>
	 var goalName =parser.parseFromString('<s:property value="jsonNameList" />', "text/html").body.textContent;
	 var nameList=JSON.parse(goalName);
	 
	 var goalBody =parser.parseFromString('<s:property value="jsonBodyList" />', "text/html").body.textContent;
	 var bodyList=JSON.parse(goalBody);

	 var goalPriority =parser.parseFromString('<s:property value="jsonPriorityList" />', "text/html").body.textContent;
	 var priorityList=JSON.parse(goalPriority);

	 var goalActors =parser.parseFromString('<s:property value="jsonActorsList" />', "text/html").body.textContent;
	 var actorsList=JSON.parse(goalActors);
	 
	 var goalDescription =parser.parseFromString('<s:property value="jsonDescriptionList" />', "text/html").body.textContent;
	 var descriptionList=JSON.parse(goalDescription);	
	  	 
	var dialog;
	$( function() {
		dialog=$( "#goaldg" ).dialog({
	    resizable: false,
	    height: "auto",
	    width: "auto",
	    modal: true,
	    autoOpen:false,
	    buttons: {
	      "Insert": function() {
	    	 		$( this ).dialog( "close" );
			      	var ind=$("#idGoal").prop("selectedIndex");
			        var goal = new joint.shapes.erd.Goal({
			            position: { x: 300, y: 300 },
			            attrs: {
				            'text': { text: nameList[ind]},
				            '.actors': { text: actorsList[ind]},
				            '.priority': { text: priorityList[ind]},
				            '.description': { text: descriptionList[ind]},
				            '.body': { text: bodyList[ind]}
			            }
		        });
			    var graph=new joint.dia.Graph;
		        window.Graf.addCells([goal]);    
	      },
	      Cancel: function() {
	        $( this ).dialog( "close" );
	      }
	    }
	  });
	} );
	</script> 
 
	<div id="goaldg" title="Select Functional Requirement to Insert">
		<s:select
		id="idGoal"
		name="idGoal"
		label="Functional Requirement"
		list="functionalReqList"
		listKey="idFunctionalReq"
		listValue="name"/>
	</div>
</body>

</html>
