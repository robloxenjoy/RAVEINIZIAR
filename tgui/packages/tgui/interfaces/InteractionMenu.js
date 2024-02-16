import { useBackend } from '../backend';
import { NoticeBox, Button, Section, Stack, Tooltip, Flex } from '../components';
import { Window } from '../layouts';

export const InteractionMenu = (props, context) => {
  const { act, data } = useBackend(context);
  const { categories, target_name, block_interact } = data;

  return (
    <Window
      width={400}
      height={600}
      title={"Interacting With " + target_name}
      theme="cutesy">
      <Window.Content>
        <Stack
          fill
          vertical>
          <Stack.Item>
            {block_interact && (
              <NoticeBox>
                Unable to interact
              </NoticeBox>
            ) || (
              <NoticeBox>
                Able to interact
              </NoticeBox>
            )}
          </Stack.Item>
          <Stack.Item
            grow>
            <Section
              fill
              scrollable>
              {categories.length !== 0 ? (
                <Flex.Item>
                  {categories.map(category => (
                    <Section
                      title={category.name}
                      key={category.name}>
                      {category.interactions.map(interaction => (
                        <Tooltip
                          key={interaction.name}
                          content={interaction.desc}>
                          <Button
                            mt={0.5}
                            mx={0.5}
                            color={"default"}
                            icon={interaction.button_icon}
                            disabled={interaction.block_interact}
                            onClick={() => act('interact', { interaction: interaction.name })}>
                            {interaction.name}
                          </Button>
                        </Tooltip>
                      ))}
                    </Section>
                  ))}
                </Flex.Item>
              ) : (
                <NoticeBox
                  danger>
                  No valid interactions!
                </NoticeBox>
              )}
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
