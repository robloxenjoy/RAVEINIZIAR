import { Species } from "./base";

const Human: Species = {
  description: "Humans are the dominant species in the known universe, their \
    kind extend from old Earth to the edges of the milky way.",
  features: {
    good: [],
    neutral: [{
      icon: "tools",
      name: "Jack of All Trades",
      description: "Humans don't excel or lack in any particular field, and can \
      adapt to many situations.",
    }],
    bad: [],
  },
  lore: [
    "Humanity needs no introduction.",
    "Most humans are allied to Itobe, however corporate war continues raging on as what ZoomTech lacks in numbers,",
    "it has in technology. ZoomTech is also mostly composed of humans, but they have greatly accepted and incorporated",
    "alien life in it's ranks to compensate for war related casualties and diminished birth rates.",
  ],
};

export default Human;
