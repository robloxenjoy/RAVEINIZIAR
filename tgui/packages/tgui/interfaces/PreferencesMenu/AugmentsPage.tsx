import { BlockQuote, Stack, Box, Tabs, Section, Button, Dropdown } from "../../components";
import { useBackend, useLocalState } from "../../backend";
import { AugmentItem, PreferencesMenuData } from "./data";


const AugmentStackItem = (props: {
  removal: boolean;
  our_item: AugmentItem;
}, context) => {
  const { act, data } = useBackend<PreferencesMenuData>(context);
  const maxmarkings = data.maximum_markings_per_limb;
  return (
    <Stack.Item>
      <Section
        title={props.our_item.name}
      >
        {props.our_item.description}<br />
        {props.removal && (
          <Box>
            {props.our_item.can_use_styles && (
              <Dropdown
                mt={1}
                mr={2}
                displayText={data.selected_augments_styles[props.our_item.slot]
                  ? data.selected_augments_styles[props.our_item.slot] : "Styles"}
                options={data.unselected_augments_styles}
                onSelected={(value) => act("set_augment_style", {
                  augment_item: props.our_item.name,
                  augment_slot: props.our_item.slot,
                  augment_style: value,
                })}
              />
            ) || (
              <Box />
            )}
            <Button
              icon="dollar-sign"
              tooltipPosition={"top"}
              tooltip={props.our_item.cant_buy}
              // eslint-disable-next-line no-extra-boolean-cast
              disabled={!!props.our_item.cant_buy}
              color={(props.our_item.value > 0) ? "bad" : (props.our_item.value < 0 ? "good" : null)}
              onClick={() => act("remove_augment", {
                augment_item: props.our_item.name,
                augment_slot: props.our_item.slot,
                augment_category: props.our_item.category,
              })}
              mt={1}
              mr={2}
            >
              Remove ({-props.our_item.value})
            </Button>
          </Box>
        ) || (
          <Box>
            <Button
              icon="dollar-sign"
              tooltipPosition={"top"}
              tooltip={props.our_item.cant_buy}
              // eslint-disable-next-line no-extra-boolean-cast
              disabled={!!props.our_item.cant_buy}
              color={(props.our_item.value > 0) ? "good" : (props.our_item.value < 0 ? "bad" : null)}
              onClick={() => act("add_augment", {
                augment_item: props.our_item.name,
                augment_slot: props.our_item.slot,
                augment_category: props.our_item.category,
              })}
              mt={2}
              mr={2}
            >
              Buy ({props.our_item.value})
            </Button>
          </Box>
        )}
      </Section>
    </Stack.Item>
  );
};

export const AugmentsPage = (props, context) => {
  const { data } = useBackend<PreferencesMenuData>(context);
  let [currentCategory, setCurrentCategory] = useLocalState(context, 'currentCategory', data.unselected_augments[0]);
  let [currentSlot, setCurrentSlot] = useLocalState(context, 'currentSlot', currentCategory.slots[0]);

  const remainingpoints = "Remaining customization points: " + data.augment_balance + "/" + data.maximum_customization_points;

  return (
    <Stack
      vertical>
      <Stack.Item>
        <BlockQuote>
          <Box mb={1.5} bold>
            {remainingpoints}
          </Box>
          <Box>
            Here you can buy augments with customization points. <br />
            You can get more points with negative augments,
            but you can only have one augment per augment slot!
          </Box>
        </BlockQuote>
      </Stack.Item>
      <Stack.Item>
        <Tabs
          fill
        >
          {data.unselected_augments.map(category => (
            <Tabs.Tab
              key={category.name}
              selected={category === currentCategory}
              onClick={() => {
                setCurrentCategory(category);
                setCurrentSlot(category.slots[0]);
              }}
            >
              {category.name}
            </Tabs.Tab>
          ))}
        </Tabs>
      </Stack.Item>
      <Stack.Item>
        <Section>
          <Stack
            height={40}
            vertical={false}>
            <Stack.Item
              width={"10%"}
              height={"100%"}
            >
              <Tabs
                fill
                vertical>
                {currentCategory.slots.map(slot => (
                  <Tabs.Tab
                    key={slot.name}
                    selected={slot === currentSlot}
                    onClick={() => setCurrentSlot(slot)}
                  >
                    {slot.name}
                  </Tabs.Tab>
                ))}
              </Tabs>
            </Stack.Item>
            <Stack.Item
              width={"60%"}
              height={"100%"}
            >
              <Section
                ml={2}
                fill
                height={"100%"}
                overflowX="hidden"
                overflowY="scroll"
              >
                <Stack
                  vertical>
                  {currentSlot.items.map(item => (
                    <AugmentStackItem
                      key={item.name}
                      our_item={item}
                      removal={false}
                    />
                  ))}
                </Stack>
              </Section>
            </Stack.Item>
            <Stack.Item
              width={"30%"}
              height={"100%"}
            >
              <Section
                ml={2}
                fill
                title={"Current Augments"}
                overflowX="hidden"
                overflowY="scroll"
              >
                {!(data.selected_augments.length) && (
                  <Box>
                    No augments selected.
                  </Box>
                )}
                <Stack
                  vertical>
                  {data.selected_augments.map(augslot => (
                    <Stack.Item
                      key={augslot.name}>
                      <Stack
                        vertical>
                        <Stack.Item>
                          <BlockQuote>
                            {augslot.name}
                          </BlockQuote>
                        </Stack.Item>
                        <AugmentStackItem
                          our_item={augslot.item}
                          removal
                        />
                      </Stack>
                    </Stack.Item>
                  ))}
                </Stack>
              </Section>
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
