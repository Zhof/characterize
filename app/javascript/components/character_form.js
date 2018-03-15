// const initializeCharacterForm = () => {
//   const background = document.getElementById("background");
//   background.addEventListener('input', (event) => {
//     extactAttributes(event.currentTarget.value);
//   });
// };


// const setFormFields = (characterAttrJSON) => {
//   ["personality_traits", "ideals", "bonds", "flaws"].forEach((attribute) => {
//     // select select tag
//     let selection = document.getElementById(attribute);
//     // empty its inner HTML
//     selection.innerHTML = `<option value=""></option>`;
//     // loop through the json of the given attribute
//     characterAttrJSON[attribute].forEach((category) => {
//     // insert a option tag for each
//       selection.innerHTML += createOption(category);
//     });
//   });
// };

// const createOption = (value) => {
//   return `<option value="${value}">${value}</option>`
// };
const capitalize = (string) => {
  return string.charAt(0).toUpperCase() + string.slice(1);
}

const extactAttributes = (background) => {
  const characterAttrJSON = JSON.parse(document.getElementById("character_attributes").dataset.character_attributes);
  return characterAttrJSON[capitalize(background)];
};

const selectCharacterOption = (selectedElement) => {
  selectedElement.classList.add("character-choice-selected");
  selectedElement.querySelector("input").checked = true;

  const parent = document.getElementById(selectedElement.dataset.parent_id);
  parent.style.display = "none";
  const nextSectionId = allCharacterAttributePages.indexOf(parent.id) + 1;
  document.getElementById(allCharacterAttributePages[nextSectionId]).style.display = "inline-block";
}

const initializeBackgroundSelectionMechanic = () => {
  document.getElementById("background-selection").querySelectorAll(".character-choice").forEach((jobOption) => {
    jobOption.addEventListener("click", (event) => {
      const jobSelected = event.currentTarget.dataset.value;
      buildForms(extactAttributes(jobSelected));
    
      tbdCharacterAttributePages.forEach((attributes) => {
        initializeAttributeSelection(attributes);
      })
    });
  });

} 

const buildForms = (data) => {
  Object.keys(data).forEach((attribute) => {
    console.log(`${attribute.toLowerCase()}-selection`);
    const attributeSelectionContainer = document.getElementById(`${attribute.toLowerCase()}-selection`);
    data[attribute].forEach((attributeValue) => {
      attributeSelectionContainer.insertAdjacentHTML("beforeend", buildOption(attribute, attributeValue));
    });
  });
}

const initializeAttributeSelection = (id) => {

  const attributeSelection = document.getElementById(id);

  attributeSelection.querySelectorAll(".character-choice").forEach((attributeOption) => {
    attributeOption.addEventListener("click", (event) => {
      selectCharacterOption(event.currentTarget);
    });
  });
}

var characterAttributePages = [
  "race-selection",
  "job-selection",
  "background-selection"
];

var tbdCharacterAttributePages = [
  "alignment-selection",
  "personality_traits-selection",
  "ideal-selection",
  "bond-selection",
  "flaw-selection"
]

var allCharacterAttributePages = [
  "race-selection",
  "job-selection",
  "background-selection",
  "alignment-selection",
  "personality_traits-selection",
  "ideal-selection",
  "bond-selection",
  "flaw-selection"
]

const buildOption = (attribute, value) => {
  return `<div class="character-choice" data-parent_id="${attribute}-selection">
    <input type="radio" name="${attribute}" id="${value}_${value}" value="${value}">
    <label for="${value}-${value}">${value}</label>
  </div>`
}

const initializeCharacterForm = () => {
  initializeBackgroundSelectionMechanic();
  characterAttributePages.forEach((attributes) => {
    initializeAttributeSelection(attributes);
  })
}

export { initializeCharacterForm };


