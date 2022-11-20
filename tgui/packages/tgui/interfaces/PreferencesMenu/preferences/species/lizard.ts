import { Species } from "./base";

const Lizard: Species = {
  description: "The Iglaak are complete outsiders to Nevado, but resemble old Earth reptiles.",
  features: {
    good: [],
    neutral: [{
      icon: "thermometer-empty",
      name: "Cold-blooded",
      description: "Higher tolerance for high temperatures, but lower \
        tolerance for cold temperatures.",
    }],
    bad: [{
      icon: "tint",
      name: "Exotic Blood",
      description: "Iglaak have a unique \"L\" type blood, which can make \
        receiving medical treatment more difficult.",
    }],
  },
  lore: [
    "Iglaak a strange race who have suffered greatly from ITOBEs enslavement of them.",
    "Their past is shrouded in mystery, as their brutal enslavement eroded pretty much all memory of it.",
    "Those lucky enough to be freed by ZoomTech in the course of the great war eagerly join her projects hoping one day to liberate their homeland. If they can find it.",
  ],
};

export default Lizard;
