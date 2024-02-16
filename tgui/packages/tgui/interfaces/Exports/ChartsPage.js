import { useBackend } from "../../backend";
import { Section, Chart, Stack, Flex, Box } from '../../components';

// update frequency in seconds
const update_frequency = 30;

export const ExportCharting = (props, context) => {
  const { act, data } = useBackend(context);
  const { current_export } = data;
  const history = current_export.cost_history;
  const costHistoryData = history.map((value, i) => [i, value]);
  const timeframe = (history.length * update_frequency)/60;
  const minValue = Math.min(...history);
  const maxValue = Math.max(...history);

  return (
    <Section title={current_export.unit_name + " Chart"} height="100%">
      <Stack vertical mt={1}>
        <Stack.Item height="100px">
          <Stack vertical={false}>
            <Stack.Item>
              <Flex height="100px" direction="column" justify="space-between">
                <Flex.Item>
                  ${maxValue}
                </Flex.Item>
                <Flex.Item>
                  ${minValue}
                </Flex.Item>
              </Flex>
            </Stack.Item>
            <Stack.Item width="90%">
              <Flex>
                <Flex.Item grow={1}>
                  <Box height="100px" position="relative">
                    <Chart.Line
                      fillPositionedParent
                      data={costHistoryData}
                      rangeX={[0, costHistoryData.length]}
                      rangeY={[minValue, maxValue]}
                      strokeColor={current_export.cost
                        > current_export.previous_cost
                        ? "rgba(16, 218, 0, 0.8)" : (current_export.cost < current_export.previous_cost
                          ? "rgba(234, 0, 0, 0.8)" : "rgba(16, 218, 0, 0.8)")}
                      fillColor={current_export.cost
                        > current_export.previous_cost
                        ? "rgba(16, 218, 0, 0.2)" : (current_export.cost < current_export.previous_cost
                          ? "rgba(234, 0, 0, 0.2)" : "rgba(16, 218, 0, 0.2)")}
                    />
                  </Box>
                </Flex.Item>
              </Flex>
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item ml={6}>
          <Flex direction="row" justify="space-between">
            <Flex.Item>
              {timeframe} minutes ago
            </Flex.Item>
            <Flex.Item>
              Now
            </Flex.Item>
          </Flex>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
