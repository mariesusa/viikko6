<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Listaa asiakkaat</title>
<link href="css/styleMyynti.css" rel="stylesheet" type="text/css">
</head>
<body>
<table id = "listaus">
	<thead>
		<tr>
			<th colspan="6"><label1><span id="uusiAsiakas">Lisää uusi asiakas</span></label1></th>
			</tr>
			<tr>
				<th><label1>Hakusana:</label1></th>
				<th colspan="4"><label1><input type="text" id="hakusana"></label1>
				<th><label1><input type="button" value="Hae" id="hakunappi"><tr></label1>

				<th><label>Etunimi</label></th>
				<th><label>Sukunimi</label></th>
				<th><label>Puhelinnumero</label></th>
				<th><label>Sähköpostiosoite</label></th>
				<th><label>Muuta</label></th>
				<th><label>Poista</label></th>
				<th></th>
		</tr>
	</thead>
	<tbody>
	</tbody>		
</table>
<script>
$(document).ready(function() {
	
	$("#uusiAsiakas").click(function() {
		document.location="lisaaasiakas.jsp";
	});
	
	haeAsiakkaat();
	$("#hakunappi").click(function(){
		haeAsiakkaat();
	});
	$(document.body).on("keydown", function(event) {
		if (event.which==13) {
			haeAsiakkaat();
		}
	});
	$("hakusana").focus();
});
function haeAsiakkaat() {
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result) {//Funktio palauttaa tiedot json-objektina
			$.each(result.asiakkaat, function(i, field) {
			var htmlStr;
			htmlStr+="<tr>";
			htmlStr+="<tr id='rivi_" + field.asiakas_id + "'>";
			htmlStr+="<td>" + field.etunimi + "</td>";
			htmlStr+="<td>" + field.sukunimi + "</td>";
			htmlStr+="<td>" + field.puhelin + "</td>";
			htmlStr+="<td>" + field.sposti + "</td>";
			htmlStr+="<td><a href='muutaasiakas.jsp?asiakas_id=" + field.asiakas_id + "'>Muuta</a>&nbsp;";
			htmlStr+="<td><span class='poista' onclick=poista('" + field.asiakas_id + "','" + field.etunimi + "','" + field.sukunimi + "')>Poista</span></td>";
			htmlStr+="</tr>";
			$("#listaus tbody").append(htmlStr);
		});
	}});
}
function poista(asiakas_id, etunimi, sukunimi) {
	if (confirm("Poista asiakas " + asiakas_id + " " + etunimi + " " + sukunimi + "?")) {
		$.ajax({url:"asiakkaat/" + asiakas_id, type:"DELETE", datatype:"json", success: function (result) {
			if (result.response==0) {
				$("#ilmo").html("Asiakkaan poisto epäonnistui.");
			} else if (result.response==1) {
				$("#rivi_" + asiakas_id).css("background-color", "red");
				alert("Asiakkaan " + asiakas_id + " poisto onnistui.");
				haeAsiakkaat();
			}
		}});
	}
}
</script>
</body>
</html>
