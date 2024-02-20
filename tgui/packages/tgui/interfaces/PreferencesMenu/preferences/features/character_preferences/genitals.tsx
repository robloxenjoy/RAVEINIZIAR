import { useLocalState } from "../../../../../backend";
import { Button, Stack, Popper } from "../../../../../components";
import { FeatureChoiced, FeatureDropdownInput, FeatureToggle, CheckboxInput, FeatureTriColorInput, Feature, FeatureNumberInput } from "../base";

export enum Genital {
  Male = "Male",
  Female = "Female",
  Cuntboy = "Cuntboy",
  Futa = "Futa",
  Dickgirl = "Dickgirl",
}

export const GENITALS = {
  [Genital.Male]: {
    icon: "tg-penis",
    text: "Male",
  },

  [Genital.Female]: {
    icon: "tg-vaginabreasts",
    text: "Female",
  },

  [Genital.Cuntboy]: {
    icon: "tg-vagina",
    text: "Cuntboy",
  },

  [Genital.Futa]: {
    icon: "tg-penisvaginabreasts",
    text: "Futa",
  },

  [Genital.Dickgirl]: {
    icon: "tg-penisbreasts",
    text: "Dickgirl",
  },
};

export const GenitalsButton = (props: {
  handleSetGenitals: (genitals: Genital) => void,
  genitals: Genital,
}, context) => {
  const [genitalMenuOpen, setGenitalMenuOpen] = useLocalState(context, "genitalMenuOpen", false);
  return (
    <Popper options={{
      placement: "right-end",
    }} popperContent={(
      genitalMenuOpen
        && (
          <Stack backgroundColor="white" ml={0.5} p={0.3}>
            {[Genital.Male,
              Genital.Female,
              Genital.Cuntboy,
              Genital.Futa,
              Genital.Dickgirl].map(genitalia => {
              return (
                <Stack.Item key={genitalia}>
                  <Button
                    selected={genitalia === props.genitals}
                    onClick={() => {
                      props.handleSetGenitals(genitalia);
                      setGenitalMenuOpen(false);
                    }}
                    fontSize="22px"
                    icon={GENITALS[genitalia].icon}
                    tooltip={GENITALS[genitalia].text}
                    tooltipPosition="top"
                  />
                </Stack.Item>
              );
            })}
          </Stack>
        )
    )}>
      <Button
        onClick={() => {
          setGenitalMenuOpen(!genitalMenuOpen);
        }}
        icon={GENITALS[props.genitals].icon}
        fontSize="22px"
        tooltip="Genitals"
        tooltipPosition="top"
      />
    </Popper>
  );
};

export const feature_breasts: FeatureChoiced = {
  name: "Jugs type",
  component: FeatureDropdownInput,
};

export const breasts_size: FeatureChoiced = {
  name: "Jugs size",
  component: FeatureDropdownInput,
};

export const breasts_lactation_toggle: FeatureToggle = {
  name: "Jugs lactation",
  component: CheckboxInput,
};

export const breasts_color: Feature<string[]> = {
  name: "Jugs color",
  component: FeatureTriColorInput,
};

export const feature_penis: FeatureChoiced = {
  name: "Knob type",
  component: FeatureDropdownInput,
};

export const penis_sheath: FeatureChoiced = {
  name: "Knob sheath",
  component: FeatureDropdownInput,
};
export const penis_length: Feature<number> = {
  name: "Knob length (cm)",
  component: FeatureNumberInput,
};

export const penis_girth: Feature<number> = {
  name: "Knob girth (cm)",
  component: FeatureNumberInput,
};

export const penis_color: Feature<string[]> = {
  name: "Knob color",
  component: FeatureTriColorInput,
};

export const feature_testicles: FeatureChoiced = {
  name: "Gonads type",
  component: FeatureDropdownInput,
};

export const testicles_size: Feature<number> = {
  name: "Gonads size",
  component: FeatureDropdownInput,
};

export const testicles_color: Feature<string[]> = {
  name: "Gonads color",
  component: FeatureTriColorInput,
};

export const feature_vagina: FeatureChoiced = {
  name: "Vagina type",
  component: FeatureDropdownInput,
};

export const vagina_color: Feature<string[]> = {
  name: "Vagina color",
  component: FeatureTriColorInput,
};
