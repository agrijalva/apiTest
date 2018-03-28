<?php
class Usuario
{
	var $Return_Type;
	var $conn;

	var $email;

	public function __construct( $Class_Properties = array() ) {
		$this->Assign_Properties_Values($Class_Properties);
		$this->conn = new Connection();
		$this->Return_Type = 'json';
	}

	public function GetUser(){
		$_response['success'] = false;
		$params = array(
				'email' => array( 'value' => $this->email, 'type' => 'STRING' ) // STRINT | INT
			);

		$_result = $this->conn->Query( "SP_GETUSER", $params );
		
		if( !empty( $_result ) ){
			$_response['success'] 	= true;
			$_response['msg']     	= 'Se ha obtenido la siguientes cantidad de registros: ' . count($_result);
			$_response['data'] 		= $_result;
		}
		else{
			$_response['msg']     	= 'No se encontraron resultados para tu solicitud.';
		}
		
		return $this->Request( $_response );
	}

	private function Assign_Properties_Values($Properties_Array){
		if (is_array($Properties_Array)) {
			foreach($Properties_Array as $Property_Name => $Property_Value)  {
				$this->{$Property_Name} = trim(htmlentities($Property_Value, ENT_QUOTES, 'UTF-8'));
			}
		}
	}

	private function Request( $_array ){
		if( empty( $this->Return_Type ) ){
			return $_array;			
		}
		else if( $this->Return_Type == 'json'  || $this->Return_Type == 'JSON' ){
			print_r( json_encode( $_array ) );
		}
	}
}
?>