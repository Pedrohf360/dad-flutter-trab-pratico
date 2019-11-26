<?php
session_start();
include('conexao.php');

if(empty($_POST['usuario']) == false){ // POST HERE
	$usuario = $_POST['usuario'];
	$senha = $_POST['senha'];
	$tipo = $_POST['tipoUsuario'];
	$cpf = $_POST['cpf'];

	// $nome, $id_youtube, $receita_produto
	$sql = "INSERT INTO usuario (usuario, senha, cpf, tipo) VALUES ('{$usuario}', md5('{$senha}'), '{$cpf}', '{$tipo}');";
	
	// $query = mysqli_query($conexao,$sql);

	if ($conexao->query($sql) === TRUE) {
		echo "New record created successfully";
	} else {
		echo "Error: " . $sql . "<br>" . $conexao->error;
	}
	$conexao->close();
	
	// while ($row = mysqli_fetch_assoc($query)) {
	// 	printf ("<b>%s</b> <br>%s<br> <br>", $row["name"],  $row["beschreibung"]);
	
	// }
} else if(empty($_POST['usuarioId']) == false) { // PUT OR DELETE HERE
	$usuarioId = $_POST['usuarioId'];

	if(empty($_POST['usuario']) == false) { // PUT HERE
		$usuario = $_POST['usuario'];
		$sql = "UPDATE usuario SET usuario='{$usuario}' WHERE id= '{$usuarioId}';";
		
		// $query = mysqli_query($conexao,$sql);

		if ($conexao->query($sql) === TRUE) {
			echo "New record updated successfully";
		} else {
			echo "Error: " . $sql . "<br>" . $conn->error;
		}
		$conexao->close();
		
	} else { // DELETE HERE
		$sql = "DELETE FROM usuario WHERE usuario_id = '{$usuarioId}';";
					
		if ($conexao->query($sql) === TRUE) {
			echo "New record updated successfully";
		} else {
			echo "Error: " . $sql . "<br>" . $conn->error;
		}
		$conexao->close();
	}
}// else if(empty($_GET['usuarioId'])) { // FAIL ON GET HERE
	//echo "Esse script nao pode ser acessado diretamente!";
//} 
else{ // GET HERE
	
	$tipo = $_GET['tipoUsuario'];
	//$usuarioId = $_GET['usuarioId'];
		
	//if($usuarioId == "true"){
		$sql = "SELECT * FROM usuario WHERE tipo = '{$tipo}';";
	//}else{
		//$sql = "SELECT * FROM usuario WHERE id= '{$usuarioId}';";
	//}

	$query = mysqli_query($conexao,$sql);

	// echo($sql);
	
	$usuarios = [];
	
	while($dados = mysqli_fetch_array($query)){
			array_push($usuarios, ["usuario_id"=>UTF8_ENCODE($dados['usuario_id']), "usuario"=>UTF8_ENCODE($dados['usuario']), "cpf"=>UTF8_ENCODE($dados['cpf'])]);
	}
	
	echo json_encode($usuarios);
}
?>