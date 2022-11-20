import { useBackend } from "../../backend";
import { TERMINAL_PAGE_INDEX, TERMINAL_PAGE_BANKING, TERMINAL_PAGE_INFORMATION } from './constants';
import { Section, Stack, Button, Box } from '../../components';
import { BankingPage } from './BankingPage';
import { InformationPage } from './InformationPage';
import { Window } from "../../layouts";

export const InformationTerminal = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    current_page,
  } = data;

  return (
    <Window
      title={"Telescreen"}
      width={400}
      height={400}>
      <Window.Content>
        <Section
          fill
          grow
          title={(
            <Box textAlign="center">
              ZoomTech Publicitarium System v1.11
            </Box>
          )}
        >
          {(current_page === TERMINAL_PAGE_INDEX) && (
            <IndexPage props={props} context={context} />
          )}
          {(current_page === TERMINAL_PAGE_BANKING) && (
            <BankingPage props={props} context={context} />
          )}
          {(current_page === TERMINAL_PAGE_INFORMATION) && (
            <InformationPage props={props} context={context} />
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};

const IndexPage = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    account_holder,
    account_id,
    birthday_boys,
  } = data;

  return (
    <Stack
      textAlign="center"
      height="100%"
      vertical>
      {account_holder && (
        <Stack.Item mt={2} height="10%">
          <Box
            height="100%"
            style={{
              "font-size": "150%",
            }}
          >
            Welcome, {account_holder}.
          </Box>
        </Stack.Item>
      ) || (
        <Stack.Item mt={2} height="10%">
          <Box height="100%" />
        </Stack.Item>
      )}
      <Stack.Item mt={2}>
        <Button
          style={{
            "font-size": "150%",
          }}
          disabled={!account_id}
          tooltipPosition="top"
          tooltip={!account_id ? "Insert an ID card with a registered account!" : ""}
          onClick={() => act("switch_page", {
            new_page: TERMINAL_PAGE_BANKING,
          })}
        >
          Banking
        </Button>
      </Stack.Item>
      <Stack.Item mt={2}>
        <Button
          style={{
            "font-size": "150%",
          }}
          onClick={() => act("switch_page", {
            new_page: TERMINAL_PAGE_INFORMATION,
          })}
        >
          Information
        </Button>
      </Stack.Item>
      {birthday_boys && (
        <Stack.Item mt={2}>
          <Box
            style={{
              "font-size": "150%",
            }}
          >
            Happy birthday {birthday_boys}!
          </Box>
          <Box mt={2}>
            <img
              src="https://www.pngmart.com/files/12/Birthday-Party-Hard-Emoji-PNG-File.png"
              width="128"
              height="128"
            />
          </Box>
        </Stack.Item>
      )}
    </Stack>
  );
};
