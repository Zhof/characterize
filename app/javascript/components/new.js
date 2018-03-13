import Typed from 'typed.js';

const initializeTypedJs = () => {
  const element = document.querySelector(".story");

  new Typed(element ,{
    strings: [<%= @character.story %>.],
    typeSpeed: 75,
    loop: true
  });
}

export { initializeTypedJs };
