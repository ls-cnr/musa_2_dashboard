<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
 <%@taglib prefix="display" uri="http://displaytag.sf.net"%>
 <%@ taglib prefix="sj" uri="/struts-jquery-tags"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- <META HTTP-EQUIV="Refresh" CONTENT="0;URL=listDomain.action"> -->
<link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" media="all" />
<link href="../css/tabMenu.css" rel="stylesheet" type="text/css" media="all" />
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="../script/musaGUIScript.js"></script>
<script type="text/javascript" src="../script/URI.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Domain Abstract Capability management</title>

</head>
<body>
<s:div id="bannerlogin" cssClass="bannerlogin">
  <p class="alignleft">Hello,	<s:property value="#session.userId" />(<s:property value="#session.role" />)  |  <s:a cssClass="ui-button ui-widget ui-corner-all" style="padding: .2em 0.5em;!important" href="../logout">LOGOUT</s:a></p>
  <p class="alignright"><b>MUSA DASHBOARD</b></p>
  <div style="clear: both;"></div>
</s:div>
<div id="header" class="container">	
<div class="breadcrumb flat">
	<a  href="domainListDev.action" >DOMAINS</a>
	<a class="active">LIST OF PROPOSALS (<s:property value="#session.domainName" />)</a>
</div></div>

<script>

function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

  $( function() {
		var editflag = getCookie("editflag");
	  	console.log("inizio programma, il flag e:"+editflag);
	 	var dialog, form,
	 	tips = $( ".validateTips" );
	    function updateTips( t ) {
	      tips
	        .text( t )
	        .addClass( "ui-state-highlight" );
	      setTimeout(function() {
	        tips.removeClass( "ui-state-highlight", 1500 );
	      }, 500 );
	    }
  
    dialog = $( "#dialog-form" ).dialog({
		
      autoOpen: false,
      height: 600,
      width: 800,
      modal: true,
      resizable: false,
      buttons: {
        "Save": function() {
        	$('#formtosub').submit();},
        "Close": function() {
          dialog.dialog( "close" );
        }
      },
      close: function() {
      }
    });

	if(editflag === "true")
	{	
		console.log("ho verificato che flag e true");
	    dialog.dialog( "open" );
	}
	else{
		console.log("ho verificato che flag e false");
		dialog = $( "#dialog-form" );
	  	dialog.dialog( "close" );
	  	}
	setCookie("editflag", "false", 365);
	editflag="false";
  });

function clickFunc(ref)
{	
	event.preventDefault();
	console.log("funzione click");
	
	if(ref.id === "newbtn"){
		console.log(ref.id + "click nuovo");
		dialog = $( "#dialog-form" );
		dialog.dialog( "open" );
		$( "#nameInput" ).val("");
		$( "#inputInput" ).val("");
		$( "#outputInput" ).val("");
		$( "#paramsInput" ).val("");
		$( "#bodyInput" ).val("");
		$( "#descriptionInput" ).val("");
}
	
	if(ref.id === "editbtn"){
        console.log(ref.id);
		setCookie("editflag", "true", 365);
		window.location.href=ref.href;
	}

}

$(window).resize(function() {
    $("#dialog-form").dialog("option", "position", {my: "center", at: "center", of: window});
});
</script>

<div id="dialog-form" title="Propose Abstract Capability">
  <p class="validateTips">Fill the fields and click Save.</p>
 <fieldset>
     <s:form id="formtosub" action="saveOrUpdateAbstractCapabilitiesProposal">
     	<s:push value="abstractCapabilityProposal">
		<s:hidden id="idInput" name="idAbstratCapability" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />
		<s:textfield id="nameInput" name="name" label="Name" style="height: auto; width: 600px;resize: none;" />
		<s:textarea id="inputInput" name="input" label="Input"  style="height: 80px; width: 600px;resize: none;" />
		<s:textarea id="outputInput" name="output" label="Output" style="height: 80px; width: 600px;resize: none;"/>
		<s:textarea id="paramsInput" name="params" label="Params" style="height: 80px; width: 600px;resize: none;" />
		<s:textarea id="bodyInput" name="body" label="Body" style="height: 80px; width: 600px;resize: none;" />
		<s:textarea id="descriptionInput" name="description" label="Notes" style="height: 80px; width: 600px;resize: none;" />
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
		</s:push>
</s:form>
</fieldset>

      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
</div>

<s:div  cssClass="mainDiV">
<display:table export="false" id="alternatecolor" name="abstractCapabilityProposalsList" pagesize="5" class="altrowstable"  uid="row" requestURI="" style="margin-top:20px;">		
<display:setProperty name="basic.empty.showtable" value="true" />
<display:column property="name" title="NAME" sortable="true"> <s:property value="name"/></display:column>
<display:column property="description" title="NOTES" sortable="true" ><s:property value="description"/></display:column>
<display:column property="state" title="PROPOSAL STATE" sortable="true" ></display:column>

				
<display:column title="ACTIONS" sortable="false" style="white-space:nowrap;width: 1%;" >

				<s:url id="retreatProposalURL" action="deleteAbstractCapabilityProposal">
					<s:param name="id" value="%{#attr.row.idProposal}"></s:param>
					<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
					</s:url> 
					
			<s:if test='%{#attr.row.state=="waiting"}'>
				<s:a  cssClass="ui-button ui-widget ui-corner-all" href="%{retreatProposalURL}">RETREAT</s:a>
			
			</s:if>

</display:column>

</display:table>

 </s:div>
 
<div style="display:table; margin:auto;margin-top: 30px;">
	<s:a id="newbtn" onClick="clickFunc(this)" cssClass="ui-button ui-widget ui-corner-all"  href="#">PROPOSE NEW ABSTRACT CAPABILITY</s:a>
</div>
</body>
</html>