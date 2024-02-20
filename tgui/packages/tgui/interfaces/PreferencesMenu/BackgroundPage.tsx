import { Stack, Box, BlockQuote, Button } from "../../components";
import { useBackend } from "../../backend";
import { Birthsign, PreferencesMenuData } from "./data";

const Gap = (props: {
  amount: number,
}) => {
  return <Box height={`${props.amount}px`} />;
};

const BirthsignBlock = (props: {
  selected: boolean,
  sign: Birthsign,
  key?: string,
}, context) => {
  const { act, data } = useBackend<PreferencesMenuData>(context);
  return (
    <Stack.Item
      key={props.key ? props.key : null}
      mb={2}>
      <Stack
        vertical={false}>
        <Stack.Item>
          <Box
            height="134px"
            width="134px"
            className="PreferencesMenu__papericonbox">
            <Box
              height="128px"
              width="128px"
              className={'birthsigns128x128 ' + props.sign.icon}
            />
          </Box>
        </Stack.Item>
        <Stack.Item
          width="85%"
          height="134px">
          <Stack
            width="100%"
            height="100%"
            vertical>
            <Stack.Item
              height="25%">
              <Box
                height="100%"
                width="100%"
                className="PreferencesMenu__papersplease__header__dotted"
                style={{
                  "font-size": "150%",
                  "padding-left": "3px",
                }}
              >
                {props.sign.name}
                {props.sign.patron_saint ? " (" + props.sign.patron_saint + ")" : null}
                {!props.selected && (
                  <Button
                    tooltip={props.sign.cant_buy}
                    tooltipPosition={"bottom"}
                    disabled={!!props.sign.cant_buy}
                    color="paperplease"
                    ml={2}
                    height="90%"
                    style={{
                      "font-size": "75%",
                    }}
                    onClick={() => act("select_birthsign", {
                      birthsign_name: props.sign.name,
                    })}>
                    Select ({props.sign.value})
                  </Button>
                ) || (
                  <Box
                    inline
                    color="paperplease"
                    ml={2}
                    height="90%"
                    style={{
                      "font-size": "75%",
                    }}>
                    Cost ({props.sign.value})
                  </Box>
                )}
              </Box>
            </Stack.Item>
            <Stack.Item
              height="75%">
              <Box
                height="100%"
                width="100%"
                className="PreferencesMenu__papersplease__dotted">
                {props.sign.description}
              </Box>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Stack.Item>
  );
};

export const BackgroundPage = (props, context) => {
  const { data } = useBackend<PreferencesMenuData>(context);

  const remainingpoints = "Remaining customization points: " + data.birthsign_balance + "/" + data.maximum_customization_points;

  return (
    <Stack
      vertical>
      <Stack.Item mb={1}>
        <BlockQuote>
          <Box mb={1.5} bold>
            {remainingpoints}
          </Box>
          <Box>
            Here you can choose a birthsign for your character. <br />
            In Nevado, mysticism is prevalent, and not just fiction -
            Most birthsigns cost nothing, and are small
            sidegrades for your character.
          </Box>
        </BlockQuote>
      </Stack.Item>
      <Stack.Item
        mb={0}
        height={18}>
        <Box
          height="100%">
          <Box
            height="20%"
            className="PreferencesMenu__papersplease__header__center">
            <Box
              textAlign="center"
              className="PreferencesMenu__papersplease__header__title"
              style={{
                "font-size": "275%",
              }}>
              Selected Birthsign
            </Box>
          </Box>
          <Box
            overflowX="hidden"
            overflowY="scroll"
            height="80%"
            className="PreferencesMenu__papersplease__centerbottomless">
            {!data.selected_birthsign && (
              <Box
                textAlign="center"
                style={{
                  "padding-top": "10px",
                  "font-size": "200%",
                }}>
                No birthsign!
              </Box>
            ) || (
              <Stack
                vertical>
                <Gap
                  amount={10} />
                <BirthsignBlock
                  selected
                  sign={data.selected_birthsign} />
              </Stack>
            )}
          </Box>
        </Box>
      </Stack.Item>
      <Stack.Item
        mt={0}
        mb={0}
        height={1}
      >
        <Box
          height="100%"
          width="100%"
          className="PreferencesMenu__papersplease__gutterhorizontal"
        />
      </Stack.Item>
      <Stack.Item
        mt={0}
        height={20}>
        <Box
          height="100%">
          <Box
            height="20%"
            className="PreferencesMenu__papersplease__header__centernoradius">
            <Box
              textAlign="center"
              className="PreferencesMenu__papersplease__header__title"
              style={{
                "font-size": "275%",
              }}>
              Available Birthsigns
            </Box>
          </Box>
          <Box
            overflowX="hidden"
            overflowY="scroll"
            height="80%"
            className="PreferencesMenu__papersplease__center">
            {!data.unselected_birthsigns && (
              <Box
                textAlign="center"
                style={{
                  "padding-top": "10px",
                  "font-size": "200%",
                }}>
                No birthsigns available!
              </Box>
            ) || (
              <Stack
                vertical>
                <Stack.Item>
                  <Gap
                    amount={10} />
                </Stack.Item>
                {data.unselected_birthsigns.map(birthsign => (
                  <BirthsignBlock
                    selected={false}
                    sign={birthsign}
                    key={birthsign.name}
                  />
                ))}
              </Stack>
            )}
          </Box>
        </Box>
      </Stack.Item>
    </Stack>
  );
};
