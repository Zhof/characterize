import Typed from 'typed.js';

const initializeTypedJs = () => {
  const element = document.querySelector(".banner-script");

  if (element) {
    new Typed(element ,{
      strings: ["Snuffles, a restless halfling rogue from a tropical paradise who is getting too old for all this.", "Composed dragonborn ranger from a small family farm who always gives the vaguest possible answer to questions.", "Decadent gnome fighter from the forked islands who loves ice sculptures.", "Responsible dwarf sorcerer from a run down tavern who winks with both eyes.", "Pompous dragonborn paladin from a notorious dungeon who was raised by ghosts.", "Earnest halfling bard from a hidden temple who makes inappropriate jokes at the worst times.", "Passionate dragonborn druid from the city sewers who always gives the bad news first.", "Perfectionist gnome rogue from a hidden temple who has only two months to live."],
      typeSpeed: 75,
      loop: true
    });
  }
}

export { initializeTypedJs };
