import { Species } from "./base";

const Parotin: Species = {
  description: "The Parotin are natives to Nevado, most resembling old Earth birds.",
  features: {
    good: [{
      icon: "plane",
      name: "Flights of Fancy",
      description: "Parotin can use their wings to fly, if the atmosphere permits it.",
    }],
    neutral: [{
      icon: "dove",
      name: "Seagull Claws",
      description: "Fitting to their stereotypes as disgusting thieves, \
        Parotin favor sharp reflexes over strength.",
    },
    {
      icon: "thermometer-three-quarters",
      name: "Feathers",
      description: "Higher tolerance for cold temperatures, but lower tolerance for high temperatures.",
    }],
    bad: [{
      icon: "bone",
      name: "Glass Bones",
      description: "Parotin have brittle, easily shattered bones.",
    }],
  },
  lore: [
    "Sterotyped as decadent fops enslaved to their house clans,",
    "the Parotin have punched above their weight as a people and found a place as some of the most devilish and feathery workers this side of the galaxy.",
  ],
};

export default Parotin;
