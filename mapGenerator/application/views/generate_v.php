<!DOCTYPE html>
<html>
	<head>
		<title></title>
	</head>
	<body>
		<h1>Map Generator</h1>


		<form action="main.php?/generate/generate/"  method="POST">
			<label for="scale">Scale: 
				<input type="number" value="30" name="scale"></input>
			</label>

			<label for="seed">Seed Value: 
				<input type="number" name="seed" id="seed" value="100">
			</label>	

			<br>
			<input type="submit" value="Generate">

	
		</form>



		<!-- <a href="main.php?/home/index/param1/param2">test link</a> -->
	</body>
</html>