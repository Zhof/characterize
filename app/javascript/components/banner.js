import Typed from 'typed.js';

const initializeTypedJs = () => {
  const element = document.querySelector(".banner-script");

  if (element) {
    new Typed(element ,{
      strings: ["Snuffles, a restless halfling rogue from a tropical paradise who is getting too old for all this.", "Psychopathic gnome bard from a destitute plantation who once stepped on grass when the sign clearly said not to.", "Write a random story for your character.", "Your character is an orc from Vancouver, played for the Grizzles, now is on a quest to find...", "His meaning in life."],
      typeSpeed: 75,
      loop: true
    });
  }
}

export { initializeTypedJs };
