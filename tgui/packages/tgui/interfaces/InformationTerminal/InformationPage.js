import { useBackend } from "../../backend";
import { TERMINAL_PAGE_INDEX } from './constants';
import { Stack, Button, Section, Box } from "../../components";

export const InformationPage = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    announcements = [],
  } = data;

  return (
    <Stack
      height="100%"
      vertical>
      <Stack.Item height="67.5%">
        <Section
          fill
          overflowX="hidden"
          overflowY="scroll"
          className="Section__boundingbox">
          <Box
            style={{
              "font-size": "150%",
            }}
            mb={1}
            ml={2}>
            <b>Announcements</b>
          </Box>
          {announcements.map(announcement => (
            <Section
              key={announcement.title}
              title={(
                <Box>
                  {announcement.title}
                </Box>
              )}>
              {announcement.contents}
            </Section>
          ))}
          {!announcements.length && (
            <Box>
              ERROR 404: No announcements found.
            </Box>
          )}
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Button
          style={{
            "font-size": "150%",
          }}
          onClick={() => act("switch_page", {
            new_page: TERMINAL_PAGE_INDEX,
          })}
          ml={1}
        >
          Back
        </Button>
      </Stack.Item>
    </Stack>
  );
};
