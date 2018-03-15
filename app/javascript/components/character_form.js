const initializeCharacterForm = () => {
  const background = document.getElementById("background");
  background.addEventListener('input', (event) => {
    extactAttributes(event.currentTarget.value);
  });
  initializeCodePenThing();
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

const initializeCodePenThing = () => {
    $(".drop .option").click(function() {
      var val = $(this).attr("data-value"),
          $drop = $(".drop"),
          prevActive = $(".drop .option.active").attr("data-value"),
          options = $(".drop .option").length;
      $drop.find(".option.active").addClass("mini-hack");
      $drop.toggleClass("visible");
      $drop.removeClass("withBG");
      $(this).css("top");
      $drop.toggleClass("opacity");
      $(".mini-hack").removeClass("mini-hack");
      if ($drop.hasClass("visible")) {
        setTimeout(function() {
          $drop.addClass("withBG");
        }, 400 + options*100);
      }
      // triggerAnimation();
      if (val !== "placeholder" || prevActive === "placeholder") {
        $(".drop .option").removeClass("active");
        $(this).addClass("active");
      };
    });

    function triggerAnimation() {
      var finalWidth = $(".drop").hasClass("visible") ? 22 : 20;
      $(".drop").css("width", "24em");
      setTimeout(function() {
        $(".drop").css("width", finalWidth + "em");
      }, 400);
    }
}

export { initializeCharacterForm };

