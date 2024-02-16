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
    "Nightmarish evolved apes.",
  ],
};

export default Human;
