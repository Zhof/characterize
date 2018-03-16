global.selectedAttributes = {};

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
  global.selectedAttributes[selectedElement.dataset.attribute] = selectedElement.dataset.value;
  window.scrollTo(0, 0);
  if (allCharacterAttributePages[nextSectionId]) {
    document.getElementById(allCharacterAttributePages[nextSectionId]).style.display = "flex";
  } else {
    document.getElementById("confirm").click();
  }
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
    const attributeSelectionContainer = document.getElementById(`${attribute.toLowerCase()}-selection`);
    data[attribute].forEach((attributeValue) => {
      attributeSelectionContainer.insertAdjacentHTML("beforeend", buildOption(attribute, attributeValue));
    });
  });
}

const initializeNameInput = () => {
  document.getElementById("character-name").addEventListener("input", (event) => {
    global.selectedAttributes.name = event.currentTarget.value;
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
  return `<div class="character-choice chacter-select-btn wide" data-parent_id="${attribute}-selection" data-attribute="${attribute}" data-value="${value}">
    <input type="radio" name="${attribute}" id="${value}_${value}" value="${value}">
    <label for="${value}-${value}">${value}</label>
  </div>`
}

const initializeCharacterForm = () => {
  initializeNameInput();
  initializeBackgroundSelectionMechanic();
  characterAttributePages.forEach((attributes) => {
    initializeAttributeSelection(attributes);
  })
}

// const initializeCodePenThing = () => {
//     $(".drop .option").click(function() {
//       var val = $(this).attr("data-value"),
//           $drop = $(".drop"),
//           prevActive = $(".drop .option.active").attr("data-value"),
//           options = $(".drop .option").length;
//       $drop.find(".option.active").addClass("mini-hack");
//       $drop.toggleClass("visible");
//       $drop.removeClass("withBG");
//       $(this).css("top");
//       $drop.toggleClass("opacity");
//       $(".mini-hack").removeClass("mini-hack");
//       if ($drop.hasClass("visible")) {
//         setTimeout(function() {
//           $drop.addClass("withBG");
//         }, 400 + options*100);
//       }
//       // triggerAnimation();
//       if (val !== "placeholder" || prevActive === "placeholder") {
//         $(".drop .option").removeClass("active");
//         $(this).addClass("active");
//       };
//     });

//     function triggerAnimation() {
//       var finalWidth = $(".drop").hasClass("visible") ? 22 : 20;
//       $(".drop").css("width", "24em");
//       setTimeout(function() {
//         $(".drop").css("width", finalWidth + "em");
//       }, 400);
//     }
// }

export { initializeCharacterForm };


