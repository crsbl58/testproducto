export default function SelectOptions(selectElement, options) {
    selectElement.innerHTML = '';

    // Opción vacía al principio
    const emptyOption = document.createElement('option');
    emptyOption.value = '';
    emptyOption.textContent = '';
    selectElement.appendChild(emptyOption);

    options.forEach(({ label, value }) => {
        const option = document.createElement('option');
        option.value = value;
        option.textContent = label;
        selectElement.appendChild(option);
    });
}
