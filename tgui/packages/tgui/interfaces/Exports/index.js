import { Icon, Tooltip } from "../../components";
import { useBackend } from "../../backend";
import { Section, Table, Box, Stack } from '../../components';
import { Window } from '../../layouts';
import { ExportCharting } from './ChartsPage';

export const Exports = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    current_export,
  } = data;

  return (
    <Window
      title="Exports Console"
      width={600}
      height={750}>
      <Window.Content scrollable>
        <Section
          title={(
            <Box textAlign="center">
              RobinHood Export Market v2
            </Box>
          )}
        >
          <Stack vertical>
            {current_export && (
              <Stack.Item>
                <ExportCharting props={props} context={context} />
              </Stack.Item>
            )}
            <Stack.Item>
              <ExportsTable props={props} context={context} />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};

const ExportsTable = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    current_export = [],
    exports = [],
  } = data;

  return (
    <Section title="Exports Table">
      <Table>
        <Table.Row
          className="Table__row"
          style={{
            'background-color': 'rgb(255, 255, 152, 1)',
          }}
          verticalAlign="middle"
          header>
          <Table.Cell collapsing textAlign="left">
            Export
          </Table.Cell>
          <Table.Cell collapsing textAlign="center">
            Previous Value
          </Table.Cell>
          <Table.Cell collapsing textAlign="right">
            Value
          </Table.Cell>
        </Table.Row>
        {exports.map(stonk => (
          <Table.Row
            key={stonk.unit_name}
            className="Table__row candystripe"
            textAlign="center"
          >
            <Table.Cell collapsing textAlign="left">
              {stonk.unit_name}
            </Table.Cell>
            <Table.Cell collapsing textAlign="center">
              <Box
                inline
                color="grey"
              >
                ${stonk.previous_cost}
              </Box>
            </Table.Cell>
            <Table.Cell collapsing textAlign="right">
              <Tooltip content={current_export.type !== stonk.type ? "View graph" : "Close graph"}>
                <Box onClick={() => act("graph_view", { type: stonk.type })}>
                  <Icon
                    name={stonk.cost > stonk.previous_cost
                      ? "caret-up" : (stonk.cost < stonk.previous_cost
                        ? "caret-down" : "minus")}
                    color={stonk.cost > stonk.previous_cost
                      ? "green" : (stonk.cost < stonk.previous_cost
                        ? "red" : "grey")}
                    mr={0.5}
                  />
                  <Box
                    inline
                    color={stonk.cost > stonk.previous_cost
                      ? "green" : (stonk.cost < stonk.previous_cost
                        ? "red" : "grey")}
                  >
                    ${stonk.cost}
                  </Box>
                </Box>
              </Tooltip>
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};
