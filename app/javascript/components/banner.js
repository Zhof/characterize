import Typed from 'typed.js';

const initializeTypedJs = () => {
  const element = document.querySelector(".banner-script");

  new Typed(element ,{
    strings: ["SHORT-TEMPERED TIEFLING ROGUE FROM A HALFWAY HOUSE WHO REALLY KNOWS HOW TO PARTY.", "POSITIVE HALF-ORC SORCERER FROM THE HOLD OF A SLAVE SHIP WHO HAS BEEN EXILED TWICE UNDER DIFFERENT NAMES.", "EGOTISTICAL TIEFLING BARBARIAN FROM THE DEEP WOOD WHO LEFT THEIR HOME IN DISGRACE."],
    typeSpeed: 75,
    loop: true
  });
}

export { initializeTypedJs };
