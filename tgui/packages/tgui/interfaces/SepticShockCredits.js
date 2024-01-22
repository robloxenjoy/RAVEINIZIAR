import { useBackend } from "../backend";
import { LabeledList, Section, Stack, BlockQuote, Box } from "../components";
import { Window } from "../layouts";

export const SepticShockCredits = (props, context) => {
  const { act, data } = useBackend(context);

  return (
    <Window
      title="Podpol Credits"
      width={450}
      height={700}
      theme="quake">
      <Window.Content>
        <Stack
          height="100%"
          overflowX="hidden"
          overflowY="scroll"
          vertical>
          <Stack.Item>
            <Section title="Developers">
              <LabeledList>
                <LabeledList.Item label="Ravein">
                  Me.
                </LabeledList.Item>
                <LabeledList.Item label="Bob">
                  Coder, my friend.
                </LabeledList.Item>
                <LabeledList.Item label="Remis">
                  Coder and spriter, my friend.
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section title="Special thanks">
              <LabeledList>
                <LabeledList.Item label="The whole Podpol, Bobstation">
                  Cool guys, without them this server would not exist.
                </LabeledList.Item>
                <LabeledList.Item label="/TG/ Station">
                  Providing a base for this server.
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section
              title="Most special thanks..."
              style={{
                "font-size": "150%",
              }}>
              <LabeledList>
                <LabeledList.Item label="You">
                  For playing here!
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
