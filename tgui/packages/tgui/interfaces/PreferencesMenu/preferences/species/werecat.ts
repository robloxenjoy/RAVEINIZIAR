import { Species } from "./base";

const Perluni: Species = {
  description: "The Perluni are natives to Nevado, most resembling old Earth felines.",
  features: {
    good: [{
      icon: "grin-tongue",
      name: "Sensitive Tongue",
      description: "For better or for worse, Perluni can taste more than humans.",
    }],
    neutral: [{
      icon: "heartbeat",
      name: "Lion Heart",
      description: "Due to the cold harshness near the poles, as well as the bodily strain of carrying their bundles, \
      the Perluni favor hardiness over reflexes.",
    },
    {
      icon: "thermometer-full",
      name: "Thick Fur",
      description: "Way higher tolerance for cold temperatures, but way lower tolerance for high temperatures.",
    }],
    bad: [{
      icon: "user",
      name: "Uncongenial",
      description: "Perluni hate having company, and their mood gets affected negatively by it.",
    }],
  },
  lore: [
    "Known as the bundler people, these cat folk have proven themselves as hard workers in the field of cargo and transportation.",
    "While with a tainted past of sapient sacrifice, and other immoral rituals, they have proven capable workers for ZoomTech,",
    "not just as day labor but as entertainers and whatever trades benefit from hardiness.",
  ],
};

export default Perluni;
