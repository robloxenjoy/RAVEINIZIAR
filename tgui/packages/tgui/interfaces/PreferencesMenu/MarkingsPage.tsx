import { Section, Button, Box, ColorBox, Dropdown, Stack } from "../../components";
import { useBackend } from "../../backend";
import { Marking, MarkingZone, PreferencesMenuData } from "./data";
import { CharacterPreview } from "./CharacterPreview";
import { CharacterPreviewType } from "./preferences/features/game_preferences/preview_type";

const MarkingInput = (props: {
  our_zone: MarkingZone
  marking: Marking
}, context) => {
  const { act, data } = useBackend<PreferencesMenuData>(context);
  return (
    <Box
      textAlign="center"
      verticalAlign="middle"
      width="100%">
      <Button
        width="25%"
        onClick={() => act("color_marking", {
          body_zone: props.our_zone.body_zone,
          marking_name: props.marking.name,
          marking_index: props.marking.marking_index,
        })}
      >
        <ColorBox color={props.marking.color} />
      </Button>
      <Button
        width="25%"
        icon="sort-up"
        onClick={() => act("move_marking_up", {
          body_zone: props.our_zone.body_zone,
          marking_name: props.marking.name,
          marking_index: props.marking.marking_index,
        })}
      />
      <Button
        width="25%"
        icon="sort-down"
        onClick={() => act("move_marking_down", {
          body_zone: props.our_zone.body_zone,
          marking_name: props.marking.name,
          marking_index: props.marking.marking_index,
        })}
      />
      <Button
        icon="times"
        color="bad"
        onClick={() => act("remove_marking", {
          body_zone: props.our_zone.body_zone,
          marking_name: props.marking.name,
          marking_index: props.marking.marking_index,
        })}
      />
    </Box>
  );
};

const ZoneItem = (props: {
  our_zone: MarkingZone
}, context) => {
  const { act, data } = useBackend<PreferencesMenuData>(context);
  const maxmarkings = data.maximum_markings_per_limb;
  return (
    <Stack.Item>
      <Section title={props.our_zone.name + " (" + props.our_zone.markings.length + "/" + maxmarkings + ")"}>
        <Stack vertical>
          <Stack.Item>
            {props.our_zone.markings.map(marking => (
              <Stack key={marking.marking_index}>
                <Stack.Item width="50%" mb={1}>
                  <Dropdown
                    width="100%"
                    options={props.our_zone.markings_choices}
                    displayText={marking.name}
                    onSelected={(new_marking) => act("change_marking", {
                      body_zone: props.our_zone.body_zone,
                      marking_index: marking.marking_index,
                      new_marking: new_marking,
                    })}
                  />
                </Stack.Item>
                <Stack.Item width="50%">
                  <MarkingInput
                    our_zone={props.our_zone}
                    marking={marking}
                  />
                </Stack.Item>
              </Stack>
            ))}
          </Stack.Item>
          <Stack.Item>
            {(props.our_zone.can_add_markings) && (
              <Button
                icon="plus"
                color="good"
                onClick={() => act("add_marking", {
                  body_zone: props.our_zone.body_zone,
                })}
              />
            ) || (
              <Box>
                Marking limit reached!
              </Box>
            )}
          </Stack.Item>
        </Stack>
      </Section>
    </Stack.Item>
  );
};

export const MarkingsPage = (props, context, markingslist: MarkingZone[]) => {
  const { act, data } = useBackend<PreferencesMenuData>(context);
  markingslist = [];
  markingslist.length = data.marking_parts.length;
  for (let index = 0; index < data.marking_parts.length; index++) {
    markingslist[index] = data.marking_parts[index];
  }
  const firststack = markingslist.splice(0, 6);
  firststack.length = Math.min(firststack.length, 6);
  const secondstack = markingslist.splice(0, 6);
  secondstack.length = Math.min(firststack.length, 6);
  const maxmarkings = data.maximum_markings_per_limb;
  return (
    <Stack
      vertical>
      <Stack.Item>
        <Dropdown
          width="75%"
          displayText="Presets"
          options={data.body_marking_sets}
          onSelected={(value) => act("set_preset", { preset: value })}
        />
      </Stack.Item>
      <Stack.Item>
        <Stack
          vertical={false}>
          <Stack.Item
            minWidth="38%"
            height={40}>
            <Section
              overflowX="hidden"
              overflowY="scroll"
              fill>
              <Stack vertical>
                {firststack.map(zone => (
                  <ZoneItem
                    key={zone.body_zone}
                    our_zone={zone}
                  />
                ))}
              </Stack>
            </Section>
          </Stack.Item>
          <Stack.Item
            minWidth="38%"
            height={40}>
            <Section
              overflowX="hidden"
              overflowY="scroll"
              fill>
              <Stack vertical>
                {secondstack.map(zone => (
                  <ZoneItem
                    key={zone.body_zone}
                    our_zone={zone}
                  />
                ))}
              </Stack>
            </Section>
          </Stack.Item>
          <Stack.Item
            minWidth="20%"
            height={40}>
            <Box
              textAlign="center">
              <Button
                width="47%"
                onClick={() => {
                  act("rotateleft");
                }}
                textAlign="center"
                fontSize="22px"
                icon="undo"
                tooltip="Rotate Left"
                tooltipPosition="top"
              />
              <Button
                width="47%"
                onClick={() => {
                  act("rotateright");
                }}
                textAlign="center"
                fontSize="22px"
                icon="redo"
                tooltip="Rotate Right"
                tooltipPosition="top"
              />
            </Box>
            <CharacterPreview
              height="75%"
              id={data.character_preview_view}
            />
            <CharacterPreviewType
              character_preview_type={data.character_preview_type}
              handlePreviewJob={() => act('select_preview_type', {
                new_preview_type: 'Job',
              })}
              handlePreviewNaked={() => act('select_preview_type', {
                new_preview_type: 'Naked',
              })}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};
