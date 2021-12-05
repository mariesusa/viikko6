<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link href="css/styleMyynti.css" rel="stylesheet" type="text/css">
<title>Muuta asiakas</title>
</head>
<body>
<form id = "tiedot">
	<table>
		<thead>
			<tr>
				<th colspan="5"><label1><span id="takaisin">Takaisin listaukseen</span></label1></th>
			</tr>
			<tr>
				<th><label>Etunimi</label></th>
				<th><label>Sukunimi</label></th>
				<th><label>Puhelinnumero</label></th>
				<th><label>S�hk�postiosoite</label></th>
				<th><label>Muuta</label></th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type = "text" name = "etunimi" id = "etunimi"></td>
				<td><input type = "text" name = "sukunimi" id = "sukunimi"></td>
				<td><input type = "text" name = "puhelin" id = "puhelin"></td>
				<td><input type = "text" name = "sposti" id = "sposti"></td>
				<td><input type = "submit" id = "tallenna" value = "Hyv�ksy"></td>
			</tr>
		</tbody>
	</table>
<input type="hidden" name="asiakas_id" id="asiakas_id">	
</form>
<span id = "ilmo"></span>
</body>
<script>
$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	//Haetaan muutettavan auton tiedot. Kutsutaan backin GET-metodia ja v�litet��n kutsun mukana muutettavan tiedon id
	//GET /autot/haeyksi/rekno
	var asiakas_id = requestURLParam("asiakas_id");
	$.ajax({url: "asiakkaat/haeyksi/" + asiakas_id, type: "GET", dataType: "json", success: function(result) {
			//$("#asiakas_id").val(result.asiakas_id);
			$("#etunimi").val(result.etunimi);
			$("#sukunimi").val(result.sukunimi);
			$("#puhelin").val(result.puhelin);
			$("#sposti").val(result.sposti);
	}});
	
	$("#tiedot").validate({
		rules: {
			etunimi: {
				required: true,
				minlength: 2
			},
			sukunimi: {
				required: true,
				minlength: 2
			},
			puhelin: {
				required: true,
				minlength: 7
			},
			sposti: {
				required: true,
				minlength: 5
			}
		},
		messages: {
			etunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			sukunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			puhelin: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			sposti: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			}
		},
		submitHandler: function(form) {
			paivitaTiedot();
		}
	});
});
//funktio tietojen p�ivitt�mist� varten. Kutsutaan backin PUT-metodia ja v�litet��n kutsun mukana uudet tiedot json-stringin�.
//PUT /autot/
function paivitaTiedot() {
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	console.log(formJsonStr);
	$.ajax({url: "asiakkaat", data: formJsonStr, type: "PUT", dataType: "json", success: function(result) {
		if (result.response==0) {
			$("#ilmo").html("Asiakkaan p�ivitt�minen ep�onnistui.");
		} else if (result.response==1) {
			$("#ilmo").html("Asiakkaan p�ivitt�minen onnistui.");
			$("#asiakas_id", "#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
		}
	}});
}
</script>
</html>