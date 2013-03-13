<?php

################################################################################
# CONSTANTS
################################################################################

/**
* Defines the version.
*/
define("VERSION", "1.0.0");

/**
* Defines error descriptions.
*/
define("ERROR_300", "GET access is disabled.");
define("ERROR_301", "Invalid service syntax.");
define("ERROR_302", "Illegal character[s] found.");
define("ERROR_303", "No such method available.");
define("ERROR_304", "No such class available.");

/**
* Define used xml templates.
*/
define("TEMPLATE_REPLY", "<xmrpc status=\"ok\"><result><![CDATA[{0}]]></result></xmrpc>");
define("TEMPLATE_ERROR", "<xmrpc status=\"error\"><error id=\"{0}\"><![CDATA[{1}]]></error></xmrpc>");

################################################################################
# FUNCTIONS
################################################################################

/**
* Prints the xml document and exits.
*/
function print_xml($xml)
{
	header("Content-Type: text/xml;");
	print $xml;
	exit;
}

/**
* Prints the result object as xml.
*/
function print_result($result)
{
	$data = serialize($result);
	$reply = format_string(TEMPLATE_REPLY, array($data));
	print_xml($reply);
}

/**
* Validates the service path chunks.
*/
function is_legal($chunk)
{
	$result = ereg("^[a-zA-Z0-9_]*$", $chunk);
	return $result ? true : false;
}

/**
* Formats the string with paramaters.
*/
function format_string($string, $params)
{
	$result = $string;
	$count = count($params);
	for ($i = 0; $i < $count; $i++)
	{
		$index = "{" . $i . "}";
		$result = str_replace($index, $params[$i], $result);
	}
	return $result;
}

/**
* Handles all possible errors.
*/
function handle_error($id, $msg)
{
	if ($id < 300 || $id > 305) $id = 305;
	$reply = format_string(TEMPLATE_ERROR, array($id, $msg));
	print_xml($reply);
}

################################################################################
# EXECUTION
################################################################################

/**
* Registers global error handler.
*/
set_error_handler("handle_error");

/**
* If request method is "GET", gives an error.
*/
if ($_SERVER["REQUEST_METHOD"] == "GET")
{
	handle_error(300, ERROR_300);
}

/**
* Catches the recieved data.
*/
$data = file_get_contents("php://input");

/**
* Parses the xml and extracts service.
*/
$xmrpc = new SimpleXMLElement($data);
$service = (string)$xmrpc["service"];

/**
* Validates the service syntax.
*/
$chunks = split("\.", $service);
if (count($chunks) != 2)
{
	handle_error(301, ERROR_301);
}

/**
* Validates the service chucks.
*/
$class = (string)$chunks[0];
$method = (string)$chunks[1];
if (!is_legal($class) || !is_legal($method))
{
	handle_error(302, ERROR_302);
}

/**
* Executes the service.
*/
$include = "services/" . $class . ".php";
if (is_file($include))
{
	include_once($include);
	$instance = new $class();
	$methods = get_class_methods($class);
	if (array_search($method, $methods) !== false)
	{
		$params = unserialize($xmrpc->params);
		$result = call_user_func_array(array($instance, $method), $params);
		print_result($result);
	} 
	else handle_error(303, ERROR_303);
} 
else handle_error(304, ERROR_304);

################################################################################
# END OF FILE
################################################################################

?>
