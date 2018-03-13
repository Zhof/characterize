const initializeCharacterForm = () => {
  const background = document.getElementById("background");
  background.addEventListener('input', (event) => {
    extactAttributes(event.currentTarget.value);
  });
};

const extactAttributes = (background) => {
  const characterAttrJSON = JSON.parse(document.getElementById("character_attributes").dataset.character_attributes);
  setFormFields(characterAttrJSON[background]);
};

const setFormFields = (characterAttrJSON) => {
  ["personality_traits", "ideals", "bonds", "flaws"].forEach((attribute) => {
    // select select tag
    let selection = document.getElementById(attribute);
    // empty its inner HTML
    selection.innerHTML = `<option value=""></option>`;
    // loop through the json of the given attribute
    characterAttrJSON[attribute].forEach((category) => {
    // insert a option tag for each
      selection.innerHTML += createOption(category);
    });
  });
};

const createOption = (value) => {
  return `<option value="${value}">${value}</option>`
};

export { initializeCharacterForm };

