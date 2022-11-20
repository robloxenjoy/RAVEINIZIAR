import { Species } from "./base";

const Shibu: Species = {
  description: "The Shibu are natives to Nevado, most resembling old Earth canines.",
  features: {
    good: [{
      icon: "grin-tongue",
      name: "Sensitive Tongue",
      description: "For better or for worse, Shibu can taste more than humans.",
    }],
    neutral: [{
      icon: "dumbbell",
      name: "Wolf Muscles",
      description: "Due to the harshness of the pre ice age tropical forests, and \
      post ice age wasteland, Shibu favor strength over wits.",
    },
    {
      icon: "thermometer-three-quarters",
      name: "Fur",
      description: "Higher tolerance for cold temperatures, but lower tolerance for high temperatures.",
    }],
    bad: [{
      icon: "users",
      name: "Congenial",
      description: "Shibu hate being alone, and their mood gets affected negatively by it.",
    }],
  },
  lore: [
    "Steadfast, devout and loyal. These are the qualities that define the Shibu.",
    "Once on the brink in a world of collapsing tradition and ever more bitter conditions,",
    "the Shibu through loyalty to ZoomTech have helped transform Nevado and plan to bring it ever forward",
    "into a new golden age under the guidance of their elders.",
  ],
};

export default Shibu;
