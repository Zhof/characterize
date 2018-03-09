import Typed from 'typed.js';

const initializeTypedJs = () => {
  const element = document.querySelector(".banner-script");

  new Typed(element ,{
    strings: ["What's up? We Can write a random story for your character.", "Your character is an orc from Vancouver, played for the Grizzles, now is on a quest to find...", "His meaning in life."],
    typeSpeed: 75,
    loop: true
  });
}

export { initializeTypedJs };
