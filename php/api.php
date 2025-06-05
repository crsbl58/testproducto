<?php
header('Content-Type: application/json');

// Configuración de conexión
$host = 'localhost';
$db = 'pruebaProducto';
$user = 'postgres';
$pass = '1234';
$port = '5432';

// Conexión con manejo de errores
try {
    $pdo = new PDO("pgsql:host=$host;port=$port;dbname=$db", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error de conexión: ' . $e->getMessage()]);
    exit;
}

// Obtener opciones iniciales para select y checkboxes
if ($_SERVER['REQUEST_METHOD'] === 'GET' && $_GET['action'] === 'loadOptions') {
    echo json_encode([
        'bodegas'    => getOptions($pdo, 'Bodega'),
        'monedas'    => getOptions($pdo, 'Moneda'),
        'intereses'  => getOptions($pdo, 'intereses')
    ]);
    exit;
}

// Obtener sucursales filtradas por bodega
if ($_SERVER['REQUEST_METHOD'] === 'GET' && $_GET['action'] === 'getSucursalesByBodega') {
    if (!isset($_GET['bodega_id'])) {
        http_response_code(400);
        echo json_encode(['error' => 'Falta el parámetro bodega_id']);
        exit;
    }

    $bodegaId = $_GET['bodega_id'];

    try {
        $stmt = $pdo->prepare('SELECT id, nombre FROM "Sucursal" WHERE estado = 0 AND bodega_id = ?');
        $stmt->execute([$bodegaId]);
        $sucursales = array_map(fn($row) => [
            'label' => $row['nombre'],
            'value' => $row['id']
        ], $stmt->fetchAll(PDO::FETCH_ASSOC));

        echo json_encode($sucursales);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Error al cargar sucursales: ' . $e->getMessage()]);
    }
    exit;
}

// Validar si un código ya existe
if ($_SERVER['REQUEST_METHOD'] === 'GET' && $_GET['action'] === 'validateCode') {
    if (!isset($_GET['code'])) {
        http_response_code(400);
        echo json_encode(['error' => 'Falta el parámetro code']);
        exit;
    }

    $code = $_GET['code'];

    try {
        $stmt = $pdo->prepare('SELECT COUNT(*) as total FROM "Producto" WHERE codigo = ?');
        $stmt->execute([$code]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);

        echo json_encode(['exists' => $result['total'] > 0]);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Error al validar el código: ' . $e->getMessage()]);
    }
    exit;
}

// Guardar producto e intereses seleccionados
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);

    if (!isset($data['code'], $data['nombre'], $data['descripcion'], $data['bodega_id'], $data['sucursal_id'], $data['moneda_id'], $data['precio'])) {
        http_response_code(400);
        echo json_encode(['error' => 'Datos incompletos']);
        exit;
    }

    try {
        $pdo->beginTransaction();

        // Insertar producto con estado = 0
        $stmt = $pdo->prepare('
            INSERT INTO "Producto" (codigo, nombre, descripcion, bodega_id, sucursal_id, moneda_id, precio, estado)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ');
        $stmt->execute([
            $data['code'],
            $data['nombre'],
            $data['descripcion'],
            $data['bodega_id'],
            $data['sucursal_id'],
            $data['moneda_id'],
            $data['precio'],
            0 // <--- aquí se inserta el estado = 0
        ]);

        // Insertar intereses seleccionados (si existen)
        if (!empty($data['intereses'])) {
            $stmtInteres = $pdo->prepare('INSERT INTO registro_intereses (intereses_id, producto_id) VALUES (?, ?)');
            foreach ($data['intereses'] as $interesId) {
                $stmtInteres->execute([$interesId, $data['code']]);
            }
        }

        $pdo->commit();
        echo json_encode(['message' => 'Producto guardado correctamente']);
    } catch (PDOException $e) {
        $pdo->rollBack();
        http_response_code(500);
        echo json_encode(['error' => 'Error al guardar: ' . $e->getMessage()]);
    }
    exit;
}

// Función para obtener opciones dinámicamente de una tabla
function getOptions($pdo, $table) {
    $allowedTables = ['Bodega', 'Sucursal', 'Moneda', 'intereses'];
    if (!in_array($table, $allowedTables)) {
        throw new Exception("Tabla no permitida");
    }

    $query = "SELECT id, nombre FROM \"$table\"";
    if ($table !== 'intereses') {
        $query .= " WHERE estado = 0";
    }

    $stmt = $pdo->prepare($query);
    $stmt->execute();

    return array_map(fn($row) => [
        'label' => $row['nombre'],
        'value' => $row['id']
    ], $stmt->fetchAll(PDO::FETCH_ASSOC));
}
?>
