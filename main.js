import SelectOptions from './selectOptions.js';

const API_URL = './php/api.php';

// 1. FUNCIÓN DE VALIDACIÓN DEL CÓDIGO (ESTRICTA)
const validateProductCode = (code) => {
  const errors = [];
  const trimmedCode = (code || '').trim();

  // Validación 1: Campo requerido
  if (!trimmedCode) {
    errors.push('El código del producto es obligatorio');
    return errors;
  }

  // Validación 2: Longitud exacta
  if (trimmedCode.length < 5 || trimmedCode.length > 15) {
    errors.push('El código debe tener entre 5 y 15 caracteres');
  }

  // Validación 3: Solo caracteres alfanuméricos
  if (!/^[A-Za-z0-9]+$/.test(trimmedCode)) {
    errors.push('El código solo puede contener letras y números');
  }

  // Validación 4: Al menos una letra
  if (!/[A-Za-z]/.test(trimmedCode)) {
    errors.push('El código debe contener al menos una letra');
  }

  // Validación 5: Al menos un número
  if (!/[0-9]/.test(trimmedCode)) {
    errors.push('El código debe contener al menos un número');
  }

  return errors;
};

// 2. FUNCIÓN PARA CARGAR COMBOS
const loadCombos = async () => {
  try {
    const response = await fetch(`${API_URL}?action=loadOptions`);
    const data = await response.json();

    SelectOptions(document.getElementById('comboBoxStore'), data.bodegas);
    SelectOptions(document.getElementById('comboBoxCurrency'), data.monedas);
    SelectOptions(document.getElementById('comboBoxBranch'), []);

    const interesesList = document.getElementById('interesesList');
    if (interesesList) {
      interesesList.innerHTML = '';
      data.intereses.forEach(({ value, label }) => {
        const li = document.createElement('li');
        li.innerHTML = `<label>${label}<input type="checkbox" name="intereses" value="${value}" /></label>`;
        interesesList.appendChild(li);
      });
    }
  } catch (error) {
    console.error('Error cargando datos:', error);
    alert('Error al cargar los datos iniciales');
  }
};

// 3. EVENTO CHANGE PARA BODEGAS
document.getElementById('comboBoxStore')?.addEventListener('change', async (e) => {
  const bodegaId = e.target.value;
  const branchCombo = document.getElementById('comboBoxBranch');
  
  if (!bodegaId || !branchCombo) {
    SelectOptions(branchCombo, []);
    return;
  }

  try {
    const response = await fetch(`${API_URL}?action=getSucursalesByBodega&bodega_id=${bodegaId}`);
    const sucursales = await response.json();
    SelectOptions(branchCombo, sucursales);
  } catch (error) {
    console.error('Error cargando sucursales:', error);
    alert('Error al cargar sucursales');
  }
});

// 4. FUNCIÓN PRINCIPAL DE VALIDACIÓN
const validateForm = async () => {
  const errors = [];
  const codeInput = document.getElementById('code');

  // Validación del código del producto
  if (codeInput) {
    const codeErrors = validateProductCode(codeInput.value);
    if (codeErrors.length > 0) {
      errors.push(...codeErrors);
    } else {
      try {
        const response = await fetch(`${API_URL}?action=validateCode&code=${encodeURIComponent(codeInput.value.trim())}`);
        const { exists } = await response.json();
        if (exists) {
          errors.push('El código ya está registrado');
        }
      } catch (error) {
        console.error('Error validando código:', error);
        errors.push('Error al verificar el código');
      }
    }
  }

  // Resto de validaciones (nombre, precio, etc.)
  const nombre = document.getElementById('nombre')?.value.trim();
  if (!nombre) {
    errors.push('El nombre es obligatorio');
  } else if (nombre.length < 2 || nombre.length > 50) {
    errors.push('El nombre debe tener entre 2 y 50 caracteres');
  }

  // ... (agrega aquí el resto de tus validaciones)

  return errors;
};

// 5. EVENTO SUBMIT DEL FORMULARIO (BLOQUEANTE)
document.getElementById('productForm')?.addEventListener('submit', async (e) => {
  e.preventDefault();
  
  const errors = await validateForm();
  if (errors.length > 0) {
    alert('ERRORES:\n\n' + errors.join('\n'));
    return;
  }

  // Construcción del payload
  const payload = {
    code: document.getElementById('code')?.value.trim(),
    nombre: document.getElementById('nombre')?.value.trim(),
    bodega_id: document.getElementById('comboBoxStore')?.value,
    sucursal_id: document.getElementById('comboBoxBranch')?.value,
    moneda_id: document.getElementById('comboBoxCurrency')?.value,
    precio: document.getElementById('price')?.value.trim(),
    descripcion: document.getElementById('description')?.value.trim(),
    intereses: Array.from(document.querySelectorAll('input[name="intereses"]:checked')).map(el => el.value)
  };

  // Envío al servidor
  try {
    const response = await fetch(API_URL, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    });

    const result = await response.json();
    if (response.ok) {
      alert('Producto guardado exitosamente');
      document.getElementById('productForm')?.reset();
      SelectOptions(document.getElementById('comboBoxBranch'), []);
    } else {
      throw new Error(result.error || 'Error desconocido');
    }
  } catch (error) {
    console.error('Error al guardar:', error);
    alert('Error al guardar el producto: ' + error.message);
  }
});

// 6. INICIALIZACIÓN
document.addEventListener('DOMContentLoaded', () => {
  loadCombos();
  
  // Validación en tiempo real (opcional)
  document.getElementById('code')?.addEventListener('blur', async function() {
    const errors = validateProductCode(this.value);
    if (errors.length > 0) {
      alert(errors.join('\n'));
      this.focus();
    }
  });
});