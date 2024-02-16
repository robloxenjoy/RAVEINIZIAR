import { FeatureToggle, FeatureTriColorInput, Feature, CheckboxInput, FeatureChoiced, FeatureDropdownInput } from "../base";

export const allow_mismatched_parts_toggle: FeatureToggle = {
  name: "Allow mismatched parts",
  component: CheckboxInput,
};

export const ears_color: Feature<string[]> = {
  name: "Ear color",
  component: FeatureTriColorInput,
};

export const fluff_color: Feature<string[]> = {
  name: "Fluff color",
  component: FeatureTriColorInput,
};

export const frills_color: Feature<string[]> = {
  name: "Frills color",
  component: FeatureTriColorInput,
};

export const head_acc_color: Feature<string[]> = {
  name: "Head accessory color",
  component: FeatureTriColorInput,
};

export const horns_color: Feature<string[]> = {
  name: "Horns color",
  component: FeatureTriColorInput,
};

export const moth_antennae_color: Feature<string[]> = {
  name: "Moth antennae color",
  component: FeatureTriColorInput,
};

export const moth_markings_color: Feature<string[]> = {
  name: "Moth markings color",
  component: FeatureTriColorInput,
};

export const mutant_colors: Feature<string[]> = {
  name: "Mutant colors",
  component: FeatureTriColorInput,
};

export const neck_acc_color: Feature<string[]> = {
  name: "Neck accessory colors",
  component: FeatureTriColorInput,
};

export const snout_color: Feature<string[]> = {
  name: "Snout colors",
  component: FeatureTriColorInput,
};

export const spines_color: Feature<string[]> = {
  name: "Spines colors",
  component: FeatureTriColorInput,
};

export const tail_color: Feature<string[]> = {
  name: "Tail colors",
  component: FeatureTriColorInput,
};

export const wings_color: Feature<string[]> = {
  name: "Wings colors",
  component: FeatureTriColorInput,
};

export const feature_body_markings: FeatureChoiced = {
  name: "Full-body markings",
  component: FeatureDropdownInput,
};

export const body_markings_color: Feature<string[]> = {
  name: "Full-body markings color",
  component: FeatureTriColorInput,
};
