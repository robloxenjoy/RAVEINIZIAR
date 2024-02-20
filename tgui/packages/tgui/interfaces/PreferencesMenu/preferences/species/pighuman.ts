import { Species } from "./base";

const Pighuman: Species = {
  description: "Ancient pighuman, but the model is presented in a more degenerate form, unlike their great progenitor killers.",
  features: {
    good: [],
    neutral: [{
      icon: "tint",
      name: "Fat",
      description: "You might be hard to kill.",
    }],
    bad: [{
      icon: "tint",
      name: "Too much fat.",
      description: "Slow piggy. Also, I don't think you can wear all the clothes.",
    }],
  },
  lore: [
    "Their history will probably remain a mystery.",
  ],
};

export default Pighuman;
