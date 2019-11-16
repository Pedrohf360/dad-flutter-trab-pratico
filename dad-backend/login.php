<?php
session_start();
include('conexao.php');

if(empty($_POST['usuario']) || empty($_POST['senha'])) {
//	header('Location: index.php');
	exit();
}

$cpf = $_POST['usuario'];
if (!validaCPF($cpf)) {
	http_response_code(401);
}

$usuario = mysqli_real_escape_string($conexao, $cpf);
$senha = mysqli_real_escape_string($conexao, $_POST['senha']);

$query = "select usuario, foto from usuario where cpf = '{$cpf}' and senha = md5('{$senha}')";

$result = mysqli_query($conexao, $query);

$row = mysqli_num_rows($result);
	
/*
$usuarios = [];

while($dados = mysqli_fetch_array($result)){
				array_push($usuarios, ["usuario"=>$dados['usuario'],"foto"=>$dados['foto']]);
}
		
echo json_encode($usuarios);
*/

if($row == 1) {
	//echo json_encode($result);
	http_response_code(200);
	$_SESSION['usuario'] = $usuario;
//	header('Location: painel.php');
	exit();
} else {
	http_response_code(404);
	$_SESSION['nao_autenticado'] = true;
//	header('Location: index.php');
	exit();
}

function validaCPF($cpf) {
 
    // Extrai somente os números
    $cpf = preg_replace( '/[^0-9]/is', '', $cpf );
     
    // Verifica se foi informado todos os digitos corretamente
    if (strlen($cpf) != 11) {
        return false;
    }
    // Verifica se foi informada uma sequência de digitos repetidos. Ex: 111.111.111-11
    if (preg_match('/(\d)\1{10}/', $cpf)) {
        return false;
    }
    // Faz o calculo para validar o CPF
    for ($t = 9; $t < 11; $t++) {
        for ($d = 0, $c = 0; $c < $t; $c++) {
            $d += $cpf{$c} * (($t + 1) - $c);
        }
        $d = ((10 * $d) % 11) % 10;
        if ($cpf{$c} != $d) {
            return false;
        }
    }
    return true;
}