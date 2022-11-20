import { useBackend } from '../backend';
import { LabeledList, Section, Flex, NumberInput, Button, Box } from '../components';
import { Window } from '../layouts';

export const AttributeEditor = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    parent,
    attribute_min,
    attribute_max,
    attribute_default,
    skill_min,
    skill_max,
    skill_default,
    cached_diceroll_modifier,
    attributes = [],
    skills = [],
  } = data;
  return (
    <Window
      title={parent ? parent + ` Attributes Editor` : `Attributes Editor`}
      width={600}
      height={600}>
      <Window.Content>
        <Flex
          height="100%"
          overflowX="hidden"
          overflowY="scroll"
          direction="column">
          <Flex.Item
            grow>
            <Section
              title="Misc Variables"
            >
              <LabeledList>
                <LabeledList.Item label="Attribute Max">
                  <NumberInput
                    value={attribute_max}
                    step={1}
                    onChange={(e, value) => act('change_var', {
                      var_name: "attribute_max",
                      var_value: value,
                    })} />
                  <Button
                    ml={1}
                    onClick={() => act('null_var', {
                      var_name: "attribute_max",
                    })}>
                    NULL
                  </Button>
                </LabeledList.Item>
                <LabeledList.Item label="Attribute Min">
                  <NumberInput
                    value={attribute_min}
                    step={1}
                    onChange={(e, value) => act('change_var', {
                      var_name: "attribute_min",
                      var_value: value,
                    })} />
                  <Button
                    ml={1}
                    onClick={() => act('null_var', {
                      var_name: "attribute_min",
                    })}>
                    NULL
                  </Button>
                </LabeledList.Item>
                <LabeledList.Item label="Attribute Default">
                  <NumberInput
                    value={attribute_default}
                    step={1}
                    onChange={(e, value) => act('change_var', {
                      var_name: "attribute_default",
                      var_value: value,
                    })} />
                  <Button
                    ml={1}
                    onClick={() => act('null_var', {
                      var_name: "attribute_default",
                    })}>
                    NULL
                  </Button>
                </LabeledList.Item>
                <LabeledList.Item label="Skill Max">
                  <NumberInput
                    value={attribute_max}
                    step={1}
                    onChange={(e, value) => act('change_var', {
                      var_name: "skill_max",
                      var_value: value,
                    })} />
                  <Button
                    ml={1}
                    onClick={() => act('null_var', {
                      var_name: "skill_max",
                    })}>
                    NULL
                  </Button>
                </LabeledList.Item>
                <LabeledList.Item label="Skill Min">
                  <NumberInput
                    value={attribute_min}
                    step={1}
                    onChange={(e, value) => act('change_var', {
                      var_name: "skill_min",
                      var_value: value,
                    })} />
                  <Button
                    ml={1}
                    onClick={() => act('null_var', {
                      var_name: "skill_min",
                    })}>
                    NULL
                  </Button>
                </LabeledList.Item>
                <LabeledList.Item label="Skill Default">
                  <NumberInput
                    value={skill_default}
                    step={1}
                    onChange={(e, value) => act('change_var', {
                      var_name: "skill_default",
                      var_value: value,
                    })} />
                  <Button
                    ml={1}
                    onClick={() => act('null_var', {
                      var_name: "skill_default",
                    })}>
                    NULL
                  </Button>
                </LabeledList.Item>
                <LabeledList.Item label="Diceroll Modifier">
                  <NumberInput
                    value={cached_diceroll_modifier}
                    step={1}
                    onChange={(e, value) => act('change_diceroll_modifier', {
                      new_value: value,
                    })} />
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <Section
              title="Attributes"
            >
              <LabeledList>
                {attributes.map(attribute => (
                  <LabeledList.Item
                    label={attribute.name}
                    key={attribute.name}>
                    <NumberInput
                      value={attribute.value}
                      step={1}
                      onChange={(e, value) => act('change_attribute', {
                        attribute_type: attribute.type,
                        new_value: value,
                      })} />
                    <Button
                      ml={1}
                      onClick={() => act('null_attribute', {
                        attribute_type: attribute.type,
                      })}>
                      NULL
                    </Button>
                    <Box
                      ml={1}
                      mr={1}
                      inline
                    >
                      Raw:
                    </Box>
                    <NumberInput
                      value={attribute.value}
                      maxValue={attribute_max}
                      minValue={attribute_min}
                      step={1}
                      onChange={(e, value) => act('change_raw_attribute', {
                        attribute_type: attribute.type,
                        new_value: value,
                      })} />
                    <Button
                      ml={1}
                      onClick={() => act('null_raw_attribute', {
                        attribute_type: attribute.type,
                      })}>
                      NULL
                    </Button>
                  </LabeledList.Item>
                ))}
              </LabeledList>
            </Section>
            <Section
              title="Skills"
            >
              <LabeledList>
                {skills.map(skill => (
                  <LabeledList.Item
                    label={skill.name}
                    key={skill.name}>
                    <NumberInput
                      value={skill.value}
                      step={1}
                      onChange={(e, value) => act('change_attribute', {
                        attribute_type: skill.type,
                        new_value: value,
                      })} />
                    <Button
                      ml={1}
                      onClick={() => act('null_attribute', {
                        attribute_type: skill.type,
                      })}>
                      NULL
                    </Button>
                    <Box
                      ml={1}
                      mr={1}
                      inline
                    >
                      Raw:
                    </Box>
                    <NumberInput
                      value={skill.value}
                      maxValue={skill_max}
                      minValue={skill_min}
                      step={1}
                      onChange={(e, value) => act('change_raw_attribute', {
                        attribute_type: skill.type,
                        new_value: value,
                      })} />
                    <Button
                      ml={1}
                      onClick={() => act('null_raw_attribute', {
                        attribute_type: skill.type,
                      })}>
                      NULL
                    </Button>
                  </LabeledList.Item>
                ))}
              </LabeledList>
            </Section>
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};
