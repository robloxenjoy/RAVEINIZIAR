import { Stack, Section, Button, Box, BlockQuote } from "../../components";
import { useBackend } from "../../backend";
import { Language, PreferencesMenuData } from "./data";

const LanguageUnderstood = 1;
const LanguageSpoken = 2;

const KnownLanguage = (props: {
  language: Language
}, context) => {
  const { act, data } = useBackend<PreferencesMenuData>(context);
  return (
    <Section
      title={(
        <Box>
          {props.language.name}
          <Box
            ml={1}
            className={'languages16x16 ' + props.language.icon} />
        </Box>
      )}>
      {props.language.description}<br />
      <Button
        mt={2}
        mr={2}
        icon="brain"
        tooltip={props.language.cant_learn_understand ? "Not enough points!" : null}
        tooltipPosition={"top"}
        // eslint-disable-next-line no-extra-boolean-cast
        disabled={!!props.language.cant_learn_understand}
        color={(props.language.understand_type >= LanguageUnderstood) ? "good" : null}
        onClick={() => act("give_language", {
          language_name: props.language.name,
          understand_type: LanguageUnderstood,
          language_balance: data.language_balance,
          already_understood_type: props.language.understand_type,
        })}
      >
        Understood ({props.language.value_understand})
      </Button>
      <Button
        mt={2}
        mr={2}
        icon="volume-up"
        tooltip={props.language.cant_learn_speak}
        tooltipPosition={"top"}
        // eslint-disable-next-line no-extra-boolean-cast
        disabled={!!props.language.cant_learn_speak}
        color={(props.language.understand_type >= LanguageSpoken) ? "good" : null}
        onClick={() => act("give_language", {
          language_name: props.language.name,
          understand_type: LanguageSpoken,
          language_balance: data.language_balance,
          already_understood_type: props.language.understand_type,
        })}
      >
        Spoken ({props.language.value_speak})
      </Button>
      <Button
        mt={2}
        mr={2}
        icon="times"
        tooltip={props.language.cant_forget}
        tooltipPosition={"top"}
        // eslint-disable-next-line no-extra-boolean-cast
        disabled={!!props.language.cant_forget}
        // eslint-disable-next-line no-extra-boolean-cast
        color={!!(props.language.cant_forget) ? "grey" : "bad"}
        onClick={() => act("remove_language", {
          language_name: props.language.name,
        })}
      >
        Forget
        (-{props.language.understand_type >= LanguageSpoken
          ? props.language.value_speak : props.language.value_understand})
      </Button>
    </Section>
  );
};

const UnknownLanguage = (props: {
  language: Language
}, context) => {
  const { act, data } = useBackend<PreferencesMenuData>(context);
  return (
    <Section
      title={(
        <Box>
          {props.language.name}
          <Box
            ml={1}
            className={'languages16x16 ' + props.language.icon} />
        </Box>
      )}>
      {props.language.description}<br />
      <Button
        mt={2}
        mr={2}
        icon="brain"
        tooltip={props.language.cant_learn_understand}
        tooltipPosition={"top"}
        // eslint-disable-next-line no-extra-boolean-cast
        disabled={!!props.language.cant_learn_understand}
        onClick={() => act("give_language", {
          language_name: props.language.name,
          understand_type: LanguageUnderstood,
          language_balance: data.language_balance,
          already_understood_type: props.language.understand_type,
        })}
      >
        Understand ({props.language.value_understand})
      </Button>
      <Button
        mt={2}
        mr={2}
        icon="volume-up"
        tooltip={props.language.cant_learn_speak}
        tooltipPosition={"top"}
        // eslint-disable-next-line no-extra-boolean-cast
        disabled={!!props.language.cant_learn_speak}
        onClick={() => act("give_language", {
          language_name: props.language.name,
          understand_type: LanguageSpoken,
          language_balance: data.language_balance,
          already_understood_type: props.language.understand_type,
        })}
      >
        Speak ({props.language.value_speak})
      </Button>
    </Section>
  );
};

export const LanguagesPage = (props, context) => {
  const { data } = useBackend<PreferencesMenuData>(context);

  const remainingpoints = "Remaining customization points: " + data.language_balance + "/" + data.maximum_customization_points;

  return (
    <Stack vertical>
      <Stack.Item>
        <BlockQuote>
          <Box mb={1.5} bold>
            {remainingpoints}
          </Box>
          <Box>
            Here you can buy languages with customization points. <br />
            Each language costs 1 point to understand,
            plus 1 point to speak.
          </Box>
        </BlockQuote>
      </Stack.Item>
      <Stack.Item>
        <Stack
          vertical={false}>
          <Stack.Item
            grow
            minWidth="50%"
            height={40}>
            <Section
              fill
              overflowX="hidden"
              overflowY="scroll"
              title="Available Languages">
              <Stack vertical>
                {!data.unselected_languages.length && (
                  <Stack.Item>
                    No languages available.
                  </Stack.Item>
                )}
                {data.unselected_languages.map(language => (
                  <Stack.Item key={language.name}>
                    <UnknownLanguage
                      language={language}
                    />
                  </Stack.Item>
                ))}
              </Stack>
            </Section>
          </Stack.Item>
          <Stack.Item
            fill
            minWidth="50%"
            height={40}>
            <Section
              fill
              overflowX="hidden"
              overflowY="scroll"
              title="Known Languages">
              <Stack vertical>
                {!data.selected_languages.length && (
                  <Stack.Item>
                    No languages selected.
                  </Stack.Item>
                )}
                {data.selected_languages.map(language => (
                  <Stack.Item key={language.name}>
                    <KnownLanguage
                      language={language}
                    />
                  </Stack.Item>
                ))}
              </Stack>
            </Section>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};
