<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Multiline ComboBox - jQuery EasyUI Demo</title>
	<link rel="stylesheet" type="text/css" href="../../themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../../themes/icon.css">
	<link rel="stylesheet" type="text/css" href="../demo.css">
	<script type="text/javascript" src="../../jquery.min.js"></script>
	<script type="text/javascript" src="../../jquery.easyui.min.js"></script>
	<script>
		function loadData(){
			$('#cc').combobox({
				url:'combobox_data.json',
				valueField:'id',
				textField:'text'
			});
		}
		function getText(){
			$('#cc').combobox('getText');
	
		}
		function getValue(){
			var val = $('#cc').combobox('getValues');
			alert(val);
		}
		function disable(){
			$('#cc').combobox('disable');
		}
		function enable(){
			$('#cc').combobox('enable');
		}
	</script>
</head>
<body>
	<h2>Multiline ComboBox</h2>
	<p>This example shows how to create a multiline ComboBox.</p>
	<div style="margin:20px 0"></div>
	<div style="margin:10px 0;">
		<a href="#" class="easyui-linkbutton" onclick="loadData()">LoadData</a>
		<a href="#" class="easyui-linkbutton" onclick="setValue()">SetValue</a>
		<a href="#" class="easyui-linkbutton" onclick="getValue()">GetValue</a>
		<a href="#" class="easyui-linkbutton" onclick="disable()">Disable</a>
		<a href="#" class="easyui-linkbutton" onclick="enable()">Enable</a>
	</div>
	<select class="easyui-combobox" name="state" id="cc" data-options="multiple:true,multiline:true" style="width:200px;height:50px">
		<option value="AL">Alabama</option>
		<option value="AK">Alaska</option>
		<option value="AZ">Arizona</option>
		<option value="AR">Arkansas</option>
		<option value="CA">California</option>
		<option value="CO">Colorado</option>
		<option value="CT">Connecticut</option>
		<option value="DE">Delaware</option>
		<option value="FL">Florida</option>
		<option value="GA">Georgia</option>
		<option value="HI">Hawaii</option>
		<option value="ID">Idaho</option>
		<option value="IL">Illinois</option>
		<option value="IN">Indiana</option>
		<option value="IA">Iowa</option>
		<option value="KS">Kansas</option>
		<option value="KY">Kentucky</option>
		<option value="LA">Louisiana</option>
		<option value="ME">Maine</option>
		<option value="MD">Maryland</option>
		<option value="MA">Massachusetts</option>
		<option value="MI">Michigan</option>
		<option value="MN">Minnesota</option>
		<option value="MS">Mississippi</option>
		<option value="MO">Missouri</option>
		<option value="MT">Montana</option>
		<option value="NE">Nebraska</option>
		<option value="NV">Nevada</option>
		<option value="NH">New Hampshire</option>
		<option value="NJ">New Jersey</option>
		<option value="NM">New Mexico</option>
		<option value="NY">New York</option>
		<option value="NC">North Carolina</option>
		<option value="ND">North Dakota</option>
		<option value="OH" selected>Ohio</option>
		<option value="OK">Oklahoma</option>
		<option value="OR">Oregon</option>
		<option value="PA">Pennsylvania</option>
		<option value="RI">Rhode Island</option>
		<option value="SC">South Carolina</option>
		<option value="SD">South Dakota</option>
		<option value="TN">Tennessee</option>
		<option value="TX">Texas</option>
		<option value="UT">Utah</option>
		<option value="VT">Vermont</option>
		<option value="VA">Virginia</option>
		<option value="WA">Washington</option>
		<option value="WV">West Virginia</option>
		<option value="WI">Wisconsin</option>
		<option value="WY">Wyoming</option>
	</select>

</body>
</html>