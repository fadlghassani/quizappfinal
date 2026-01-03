<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET, POST");
header("Content-Type: application/json; charset=UTF-8");

// ⚠️ MOVE THESE TO ENV VARS LATER
$host = "yamabiko.proxy.rlwy.net";
$port = 29889; // ⚠️ PUT YOUR REAL RAILWAY PORT HERE
$user = "root";
$pass = "NLaTdEnVSoZPUDPBnxbpzsGfcXtwYEmx";
$db   = "railway";

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

$mysqli = mysqli_init();

// REQUIRED for Railway
$mysqli->ssl_set(NULL, NULL, NULL, NULL, NULL);

// Prevent hanging forever
$mysqli->options(MYSQLI_OPT_CONNECT_TIMEOUT, 10);

try {
    $mysqli->real_connect(
        $host,
        $user,
        $pass,
        $db,
        $port
    );

    // Success (temporary test)
    echo json_encode(["status" => "DB CONNECTED"]);

} catch (mysqli_sql_exception $e) {
    http_response_code(500);
    echo json_encode([
        "error" => "Database connection failed",
        "details" => $e->getMessage()
    ]);
}

