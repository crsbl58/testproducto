import SelectOptions from './selectOptions.js';

const API_URL = './php/api.php';

const validateProductCode = (code) => {
  const errors = [];
  const trimmedCode = (code || '').trim();

  if (!trimmedCode) {
    errors.push('El código del producto es obligatorio');
    return errors;
  }

  if (trimmedCode.length < 5 || trimmedCode.length > 15) {
    errors.push('El código debe tener entre 5 y 15 caracteres');
  }

  if (!/^[A-Za-z0-9]+$/.test(trimmedCode)) {
    errors.push('El código solo puede contener letras y números');
  }

  if (!/[A-Za-z]/.test(trimmedCode)) {
    errors.push('El código debe contener al menos una letra');
  }

  if (!/[0-9]/.test(trimmedCode)) {
    errors.push('El código debe contener al menos un número');
  }

  return errors;
};

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

const validateForm = async () => {
  const errors = [];
  const codeInput = document.getElementById('code');

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

  const nombre = document.getElementById('nombre')?.value.trim();
  if (!nombre) {
    errors.push('El nombre es obligatorio');
  } else if (nombre.length < 2 || nombre.length > 50) {
    errors.push('El nombre debe tener entre 2 y 50 caracteres');
  }

  const checkedIntereses = document.querySelectorAll('input[name="intereses"]:checked');
  if (checkedIntereses.length < 2) {
    errors.push('Debe seleccionar al menos 2 intereses');
  }

  const descripcion = document.getElementById('description')?.value.trim();
  if (descripcion && (descripcion.length < 10 || descripcion.length > 1000)) {
    errors.push('La descripción debe tener entre 10 y 1000 caracteres');
  }

  const precio = document.getElementById('price')?.value.trim();
  if (!/^\d+(\.\d{1,2})?$/.test(precio) || parseFloat(precio) <= 0) {
    errors.push('El precio debe ser un número positivo con hasta dos decimales');
  }

  return errors;
};

document.getElementById('productForm')?.addEventListener('submit', async (e) => {
  e.preventDefault();
  
  const errors = await validateForm();
  if (errors.length > 0) {
    alert('ERRORES:\n\n' + errors.join('\n'));
    return;
  }

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

document.addEventListener('DOMContentLoaded', () => {
  loadCombos();
});